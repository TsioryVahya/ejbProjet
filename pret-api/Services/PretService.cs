using PretApi.Models;
using Microsoft.EntityFrameworkCore;

namespace PretApi.Services
{
    public class PretService
    {
        private readonly PretContext _context;

        public PretService(PretContext context)
        {
            _context = context;
        }

        // ===== GESTION DES PRÊTS =====

        public async Task<Pret> CreerPretAsync(long idCompte, decimal montant, int dureeEnMois)
        {
            // Vérifier que le compte existe et est actif
            var compte = await _context.Comptes
                .Include(c => c.Client)
                .Include(c => c.TypeCompte)
                .FirstOrDefaultAsync(c => c.IdCompte == idCompte && c.Actif);

            if (compte == null)
            {
                throw new ArgumentException("Compte introuvable ou inactif");
            }

            if (montant <= 0)
            {
                throw new ArgumentException("Le montant du prêt doit être positif");
            }

            if (dureeEnMois <= 0)
            {
                throw new ArgumentException("La durée du prêt doit être positive");
            }

            // Vérifier l'éligibilité au prêt (règles métier)
            await VerifierEligibilitePretAsync(idCompte, montant);

            // Récupérer le taux de prêt actuel
            var tauxActuel = await _context.TauxPrets
                .OrderByDescending(t => t.DateApplication)
                .FirstOrDefaultAsync();

            if (tauxActuel == null)
            {
                throw new InvalidOperationException("Aucun taux de prêt configuré");
            }

            var pret = new Pret
            {
                Duree = dureeEnMois,
                DatePret = DateTime.UtcNow,
                MontantInitial = montant,
                MontantRestant = montant,
                Statut = "ACTIF",
                IdTaux = tauxActuel.IdTaux,
                IdCompte = idCompte
            };

            _context.Prets.Add(pret);
            await _context.SaveChangesAsync();

            // Recharger avec les relations
            return await ObtenirPretParIdAsync(pret.IdPret) ?? pret;
        }

        public async Task<Pret?> ObtenirPretParIdAsync(long idPret)
        {
            return await _context.Prets
                .Include(p => p.TauxPret)
                .Include(p => p.Compte)
                    .ThenInclude(c => c!.Client)
                .Include(p => p.Remboursements)
                .FirstOrDefaultAsync(p => p.IdPret == idPret);
        }

        public async Task<List<Pret>> ObtenirPretsParCompteAsync(long idCompte)
        {
            return await _context.Prets
                .Include(p => p.TauxPret)
                .Include(p => p.Remboursements)
                .Where(p => p.IdCompte == idCompte)
                .OrderByDescending(p => p.DatePret)
                .ToListAsync();
        }

        public async Task<List<Pret>> ObtenirPretsActifsAsync()
        {
            return await _context.Prets
                .Include(p => p.TauxPret)
                .Include(p => p.Compte)
                    .ThenInclude(c => c!.Client)
                .Include(p => p.Remboursements)
                .Where(p => p.Statut == "ACTIF")
                .OrderByDescending(p => p.DatePret)
                .ToListAsync();
        }

        public async Task<Pret> ModifierStatutPretAsync(long idPret, string nouveauStatut)
        {
            var pret = await _context.Prets.FindAsync(idPret);
            if (pret == null)
            {
                throw new ArgumentException("Prêt introuvable");
            }

            var statutsValides = new[] { "ACTIF", "REMBOURSE", "EN_RETARD", "ANNULE" };
            if (!statutsValides.Contains(nouveauStatut))
            {
                throw new ArgumentException("Statut invalide");
            }

            pret.Statut = nouveauStatut;
            await _context.SaveChangesAsync();

            return await ObtenirPretParIdAsync(idPret) ?? pret;
        }

        // ===== GESTION DES REMBOURSEMENTS =====

        public async Task<Remboursement> EffectuerRemboursementAsync(long idPret, decimal montant)
        {
            var pret = await _context.Prets
                .Include(p => p.Remboursements)
                .FirstOrDefaultAsync(p => p.IdPret == idPret);

            if (pret == null)
            {
                throw new ArgumentException("Prêt introuvable");
            }

            if (pret.Statut != "ACTIF")
            {
                throw new ArgumentException("Le prêt n'est pas actif");
            }

            if (montant <= 0)
            {
                throw new ArgumentException("Le montant du remboursement doit être positif");
            }

            if (montant > pret.MontantRestant)
            {
                throw new ArgumentException($"Le montant dépasse le montant restant ({pret.MontantRestant:C})");
            }

            var remboursement = new Remboursement
            {
                MontantRembourser = montant,
                DateRemboursement = DateTime.UtcNow,
                IdPret = idPret
            };

            _context.Remboursements.Add(remboursement);

            // Mettre à jour le montant restant
            pret.MontantRestant -= montant;

            // Vérifier si le prêt est entièrement remboursé
            if (pret.MontantRestant <= 0)
            {
                pret.Statut = "REMBOURSE";
                pret.MontantRestant = 0;
            }

            await _context.SaveChangesAsync();
            return remboursement;
        }

        public async Task<List<Remboursement>> ObtenirRemboursementsParPretAsync(long idPret)
        {
            return await _context.Remboursements
                .Where(r => r.IdPret == idPret)
                .OrderByDescending(r => r.DateRemboursement)
                .ToListAsync();
        }

        // ===== CALCULS ET SIMULATIONS =====

        public async Task<object> SimulerPretAsync(decimal montant, int dureeEnMois, long? idTaux = null)
        {
            TauxPret? taux;
            if (idTaux.HasValue)
            {
                taux = await _context.TauxPrets.FindAsync(idTaux.Value);
            }
            else
            {
                taux = await _context.TauxPrets
                    .OrderByDescending(t => t.DateApplication)
                    .FirstOrDefaultAsync();
            }

            if (taux == null)
            {
                throw new InvalidOperationException("Aucun taux de prêt disponible");
            }

            var tauxMensuel = taux.Pourcentage / 100 / 12;
            decimal mensualite;

            if (tauxMensuel == 0)
            {
                mensualite = montant / dureeEnMois;
            }
            else
            {
                var facteur = (decimal)Math.Pow((double)(1 + tauxMensuel), dureeEnMois);
                mensualite = montant * tauxMensuel * facteur / (facteur - 1);
            }

            var montantTotal = mensualite * dureeEnMois;
            var interetsTotal = montantTotal - montant;

            return new
            {
                MontantEmprunte = montant,
                DureeEnMois = dureeEnMois,
                TauxAnnuel = taux.Pourcentage,
                MensualiteCalculee = Math.Round(mensualite, 2),
                MontantTotal = Math.Round(montantTotal, 2),
                InteretsTotal = Math.Round(interetsTotal, 2),
                DateSimulation = DateTime.Now
            };
        }

        public async Task<object> CalculerEcheancierAsync(long idPret)
        {
            var pret = await ObtenirPretParIdAsync(idPret);
            if (pret == null)
            {
                throw new ArgumentException("Prêt introuvable");
            }

            var mensualite = pret.CalculerMensualite();
            var echeances = new List<object>();
            var capitalRestant = pret.MontantInitial;
            var dateEcheance = pret.DatePret.AddMonths(1);

            for (int i = 1; i <= pret.Duree; i++)
            {
                var interetsMensuel = capitalRestant * (pret.TauxPret!.Pourcentage / 100 / 12);
                var capitalRembourse = mensualite - interetsMensuel;
                capitalRestant -= capitalRembourse;

                if (capitalRestant < 0) capitalRestant = 0;

                echeances.Add(new
                {
                    NumeroEcheance = i,
                    DateEcheance = dateEcheance,
                    Mensualite = Math.Round(mensualite, 2),
                    CapitalRembourse = Math.Round(capitalRembourse, 2),
                    InteretsMensuel = Math.Round(interetsMensuel, 2),
                    CapitalRestant = Math.Round(capitalRestant, 2)
                });

                dateEcheance = dateEcheance.AddMonths(1);
            }

            return new
            {
                IdPret = idPret,
                MontantInitial = pret.MontantInitial,
                Duree = pret.Duree,
                TauxAnnuel = pret.TauxPret!.Pourcentage,
                MensualiteFixe = Math.Round(mensualite, 2),
                Echeances = echeances
            };
        }

        // ===== GESTION DES TAUX =====

        public async Task<List<TauxPret>> ObtenirTousLesTauxAsync()
        {
            return await _context.TauxPrets
                .OrderByDescending(t => t.DateApplication)
                .ToListAsync();
        }

        public async Task<TauxPret?> ObtenirTauxActuelAsync()
        {
            return await _context.TauxPrets
                .OrderByDescending(t => t.DateApplication)
                .FirstOrDefaultAsync();
        }

        // ===== RAPPORTS ET STATISTIQUES =====

        public async Task<object> ObtenirStatistiquesPretsAsync(long? idCompte = null)
        {
            var query = _context.Prets.AsQueryable();
            
            if (idCompte.HasValue)
            {
                query = query.Where(p => p.IdCompte == idCompte.Value);
            }

            var prets = await query.Include(p => p.Remboursements).ToListAsync();

            var totalPretsAccordes = prets.Sum(p => p.MontantInitial);
            var totalRembourse = prets.Sum(p => p.MontantRembourse);
            var totalRestant = prets.Where(p => p.Statut == "ACTIF").Sum(p => p.MontantRestant);

            return new
            {
                NombrePretsTotal = prets.Count,
                NombrePretsActifs = prets.Count(p => p.Statut == "ACTIF"),
                NombrePretsRembourses = prets.Count(p => p.Statut == "REMBOURSE"),
                TotalPretsAccordes = totalPretsAccordes,
                TotalRembourse = totalRembourse,
                TotalRestantARembouser = totalRestant,
                TauxRemboursement = totalPretsAccordes > 0 ? (totalRembourse / totalPretsAccordes * 100) : 0
            };
        }

        // ===== MÉTHODES PRIVÉES =====

        private async Task VerifierEligibilitePretAsync(long idCompte, decimal montant)
        {
            // Vérifier les prêts existants
            var pretsActifs = await _context.Prets
                .Where(p => p.IdCompte == idCompte && p.Statut == "ACTIF")
                .ToListAsync();

            // Règle métier : maximum 3 prêts actifs par compte
            if (pretsActifs.Count >= 3)
            {
                throw new InvalidOperationException("Nombre maximum de prêts actifs atteint (3)");
            }

            // Règle métier : montant total des prêts actifs ne doit pas dépasser 100 000€
            var montantTotalActif = pretsActifs.Sum(p => p.MontantRestant);
            if (montantTotalActif + montant > 100000)
            {
                throw new InvalidOperationException("Montant total des prêts ne peut pas dépasser 100 000€");
            }

            // Règle métier : montant minimum 1000€, maximum 50 000€ par prêt
            if (montant < 1000)
            {
                throw new InvalidOperationException("Montant minimum d'un prêt : 1 000€");
            }

            if (montant > 50000)
            {
                throw new InvalidOperationException("Montant maximum d'un prêt : 50 000€");
            }
        }
    }
}
