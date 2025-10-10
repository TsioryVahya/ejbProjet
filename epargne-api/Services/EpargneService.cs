using EpargneApi.Models;
using Microsoft.EntityFrameworkCore;

namespace EpargneApi.Services
{
    public class EpargneService
    {
        private readonly EpargneContext _context;

        public EpargneService(EpargneContext context)
        {
            _context = context;
        }

        // ===== GESTION DES TAUX D'ÉPARGNE =====

        public async Task<List<TauxEpargne>> ObtenirTousLesTauxAsync()
        {
            return await _context.TauxEpargne
                .OrderByDescending(t => t.DateApplication)
                .ToListAsync();
        }

        public async Task<TauxEpargne?> ObtenirTauxActuelAsync()
        {
            return await _context.TauxEpargne
                .OrderByDescending(t => t.DateApplication)
                .FirstOrDefaultAsync();
        }

        // ===== GESTION DES DÉPÔTS D'ÉPARGNE =====

        public async Task<DepotEpargne> CreerDepotEpargneAsync(long idCompte, decimal montant, int duree, long? idTaux = null)
        {
            // Vérifier que le compte existe et est actif
            var compte = await _context.Comptes
                .Include(c => c.TypeCompte)
                .FirstOrDefaultAsync(c => c.IdCompte == idCompte && c.Actif);

            if (compte == null)
            {
                throw new ArgumentException("Compte introuvable ou inactif");
            }

            // Permettre la création de dépôts d'épargne depuis n'importe quel type de compte
            // Suppression de la validation du type de compte

            if (montant <= 0)
            {
                throw new ArgumentException("Le montant doit être positif");
            }

            if (duree <= 0)
            {
                throw new ArgumentException("La durée doit être positive");
            }

            // Récupérer le taux d'épargne (soit celui spécifié, soit le plus récent)
            TauxEpargne tauxUtilise;
            if (idTaux.HasValue)
            {
                tauxUtilise = await _context.TauxEpargne
                    .FirstOrDefaultAsync(t => t.IdTaux == idTaux.Value);
                if (tauxUtilise == null)
                {
                    throw new ArgumentException("Taux d'épargne introuvable");
                }
            }
            else
            {
                tauxUtilise = await _context.TauxEpargne
                    .OrderByDescending(t => t.DateApplication)
                    .FirstOrDefaultAsync();
                if (tauxUtilise == null)
                {
                    throw new InvalidOperationException("Aucun taux d'épargne configuré");
                }
            }

            var depot = new DepotEpargne
            {
                MontantEpargne = montant,
                DateEpargne = DateTime.UtcNow,
                Duree = duree,
                IdCompte = idCompte,
                IdTaux = tauxUtilise.IdTaux
            };

            _context.DepotsEpargne.Add(depot);
            await _context.SaveChangesAsync();

            return depot;
        }

        public async Task<List<DepotEpargne>> ObtenirTousLesDepotsAsync()
        {
            return await _context.DepotsEpargne
                .Include(d => d.TauxEpargne)
                .Include(d => d.RetraitsEpargne)
                .Include(d => d.Compte)
                    .ThenInclude(c => c.Client)
                .OrderByDescending(d => d.DateEpargne)
                .ToListAsync();
        }

        public async Task<List<DepotEpargne>> ObtenirDepotsParCompteAsync(long idCompte)
        {
            return await _context.DepotsEpargne
                .Include(d => d.TauxEpargne)
                .Include(d => d.RetraitsEpargne)
                .Include(d => d.Compte)
                    .ThenInclude(c => c.Client)
                .Where(d => d.IdCompte == idCompte)
                .OrderByDescending(d => d.DateEpargne)
                .ToListAsync();
        }

        public async Task<DepotEpargne?> ObtenirDepotParIdAsync(long idDepot)
        {
            return await _context.DepotsEpargne
                .Include(d => d.TauxEpargne)
                .Include(d => d.RetraitsEpargne)
                .Include(d => d.Compte)
                .FirstOrDefaultAsync(d => d.IdDepotEpargne == idDepot);
        }

        // ===== GESTION DES RETRAITS D'ÉPARGNE =====

        public async Task<RetraitEpargne> CreerRetraitEpargneAsync(long idDepot, decimal montant)
        {
            var depot = await _context.DepotsEpargne
                .Include(d => d.RetraitsEpargne)
                .FirstOrDefaultAsync(d => d.IdDepotEpargne == idDepot);

            if (depot == null)
            {
                throw new ArgumentException("Dépôt d'épargne introuvable");
            }

            if (montant <= 0)
            {
                throw new ArgumentException("Le montant doit être positif");
            }

            // Calculer le montant disponible pour retrait
            var montantDisponible = CalculerMontantDisponible(depot);
            
            if (montant > montantDisponible)
            {
                throw new ArgumentException($"Montant insuffisant. Disponible: {montantDisponible:C}");
            }

            var retrait = new RetraitEpargne
            {
                MontantRetraitEpargne = montant,
                DateRetraitEpargne = DateTime.UtcNow,
                IdDepotEpargne = idDepot
            };

            _context.RetraitsEpargne.Add(retrait);
            await _context.SaveChangesAsync();

            return retrait;
        }

        public async Task<List<RetraitEpargne>> ObtenirRetraitsParDepotAsync(long idDepot)
        {
            return await _context.RetraitsEpargne
                .Where(r => r.IdDepotEpargne == idDepot)
                .OrderByDescending(r => r.DateRetraitEpargne)
                .ToListAsync();
        }

        // ===== CALCULS D'INTÉRÊTS =====

        public decimal CalculerInterets(DepotEpargne depot, DateTime dateCalcul)
        {
            if (depot.TauxEpargne == null) return 0;

            var joursEcoules = (dateCalcul - depot.DateEpargne).Days;
            if (joursEcoules <= 0) return 0;

            // Calcul des intérêts simples (peut être modifié selon les règles métier)
            var tauxAnnuel = depot.TauxEpargne.Pourcentage / 100;
            var interetsAnnuels = depot.MontantEpargne * tauxAnnuel;
            var interetsJournaliers = interetsAnnuels / 365;
            
            return interetsJournaliers * joursEcoules;
        }

        public decimal CalculerMontantDisponible(DepotEpargne depot)
        {
            var montantInitial = depot.MontantEpargne;
            var interets = CalculerInterets(depot, DateTime.UtcNow);
            var totalRetraits = depot.RetraitsEpargne?.Sum(r => r.MontantRetraitEpargne) ?? 0;
            
            return montantInitial + interets - totalRetraits;
        }


        // ===== RAPPORTS ET STATISTIQUES =====

        public async Task<decimal> CalculerTotalEpargneParCompteAsync(long idCompte)
        {
            var depots = await ObtenirDepotsParCompteAsync(idCompte);
            return depots.Sum(d => CalculerMontantDisponible(d));
        }

        public async Task<object> ObtenirStatistiquesEpargneAsync(long idCompte)
        {
            var depots = await ObtenirDepotsParCompteAsync(idCompte);
            
            var totalDepose = depots.Sum(d => d.MontantEpargne);
            var totalRetraits = depots.SelectMany(d => d.RetraitsEpargne).Sum(r => r.MontantRetraitEpargne);
            var totalInterets = depots.Sum(d => CalculerInterets(d, DateTime.UtcNow));
            var soldeActuel = depots.Sum(d => CalculerMontantDisponible(d));

            return new
            {
                TotalDepose = totalDepose,
                TotalRetraits = totalRetraits,
                TotalInterets = totalInterets,
                SoldeActuel = soldeActuel,
                NombreDepots = depots.Count,
                NombreRetraits = depots.SelectMany(d => d.RetraitsEpargne).Count()
            };
        }
    }
}
