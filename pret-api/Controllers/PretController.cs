using PretApi.Models;
using PretApi.Services;
using PretApi.DTOs;
using Microsoft.AspNetCore.Mvc;

namespace PretApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class PretController : ControllerBase
    {
        private readonly PretService _pretService;
        private readonly ILogger<PretController> _logger;

        public PretController(PretService pretService, ILogger<PretController> logger)
        {
            _pretService = pretService;
            _logger = logger;
        }

        // ===== ENDPOINTS POUR LES PRÊTS =====
        [HttpPost("prets")]
        public async Task<ActionResult<PretResponseDto>> CreerPret([FromBody] CreerPretRequest request)
        {
            try
            {
                var pret = await _pretService.CreerPretAsync(request.IdCompte, request.Montant, request.DureeEnMois);
                _logger.LogInformation($"Prêt créé: {pret.IdPret} pour le compte {request.IdCompte}");
                
                // Créer un DTO simple sans références circulaires
                var pretDto = new PretResponseDto
                {
                    IdPret = pret.IdPret,
                    Duree = pret.Duree,
                    DatePret = pret.DatePret,
                    MontantInitial = pret.MontantInitial,
                    MontantRestant = pret.MontantRestant,
                    Statut = pret.Statut,
                    IdTaux = pret.IdTaux,
                    IdCompte = pret.IdCompte,
                    TauxPourcentage = pret.TauxPret?.Pourcentage ?? 0,
                    NumeroCompte = pret.Compte?.NumeroCompte ?? "",
                    NomClient = pret.Compte?.Client?.Nom ?? "",
                    PrenomClient = pret.Compte?.Client?.Prenom ?? ""
                };
                
                return CreatedAtAction(nameof(ObtenirPret), new { id = pret.IdPret }, pretDto);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur lors de la création du prêt: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning($"Opération invalide lors de la création du prêt: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur inattendue lors de la création du prêt");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("prets/{id}")]
        public async Task<ActionResult<PretResponseDto>> ObtenirPret(long id)
        {
            try
            {
                var pret = await _pretService.ObtenirPretParIdAsync(id);
                if (pret == null)
                {
                    return NotFound(new { message = "Prêt introuvable" });
                }

                // Mapper vers un DTO pour aplatir les données
                var pretDto = new PretResponseDto
                {
                    IdPret = pret.IdPret,
                    Duree = pret.Duree,
                    DatePret = pret.DatePret,
                    MontantInitial = pret.MontantInitial,
                    MontantRestant = pret.MontantRestant,
                    Statut = pret.Statut,
                    IdTaux = pret.IdTaux,
                    IdCompte = pret.IdCompte,
                    TauxPourcentage = pret.TauxPret?.Pourcentage ?? 0,
                    NumeroCompte = pret.Compte?.NumeroCompte ?? "",
                    NomClient = pret.Compte?.Client?.Nom ?? "",
                    PrenomClient = pret.Compte?.Client?.Prenom ?? ""
                };

                return Ok(pretDto);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération du prêt {id}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("comptes/{idCompte}/prets")]
        public async Task<ActionResult<List<Pret>>> ObtenirPretsParCompte(long idCompte)
        {
            try
            {
                var prets = await _pretService.ObtenirPretsParCompteAsync(idCompte);
                return Ok(prets);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération des prêts pour le compte {idCompte}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("prets")]
        public async Task<ActionResult<List<PretResponseDto>>> ObtenirPretsActifs()
        {
            try
            {
                var prets = await _pretService.ObtenirPretsActifsAsync();
                
                // Mapper vers des DTOs pour éviter les références circulaires et aplatir les données
                var pretDtos = prets.Select(pret => new PretResponseDto
                {
                    IdPret = pret.IdPret,
                    Duree = pret.Duree,
                    DatePret = pret.DatePret,
                    MontantInitial = pret.MontantInitial,
                    MontantRestant = pret.MontantRestant,
                    Statut = pret.Statut,
                    IdTaux = pret.IdTaux,
                    IdCompte = pret.IdCompte,
                    TauxPourcentage = pret.TauxPret?.Pourcentage ?? 0,
                    NumeroCompte = pret.Compte?.NumeroCompte ?? "",
                    NomClient = pret.Compte?.Client?.Nom ?? "",
                    PrenomClient = pret.Compte?.Client?.Prenom ?? ""
                }).ToList();
                
                return Ok(pretDtos);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la récupération des prêts actifs");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpPut("prets/{id}/statut")]
        public async Task<ActionResult<Pret>> ModifierStatutPret(long id, [FromBody] ModifierStatutRequest request)
        {
            try
            {
                var pret = await _pretService.ModifierStatutPretAsync(id, request.NouveauStatut);
                _logger.LogInformation($"Statut du prêt {id} modifié vers {request.NouveauStatut}");
                return Ok(pret);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur lors de la modification du statut: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la modification du statut du prêt {id}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES REMBOURSEMENTS =====

        [HttpPost("remboursements")]
        public async Task<ActionResult<Remboursement>> EffectuerRemboursement([FromBody] EffectuerRemboursementRequest request)
        {
            try
            {
                _logger.LogInformation($"Tentative de remboursement - IdPret: {request.IdPret}, Montant: {request.Montant}");
                
                if (request.IdPret <= 0)
                {
                    _logger.LogWarning($"ID prêt invalide: {request.IdPret}");
                    return BadRequest(new { message = "ID prêt invalide" });
                }
                
                if (request.Montant <= 0)
                {
                    _logger.LogWarning($"Montant invalide: {request.Montant}");
                    return BadRequest(new { message = "Montant invalide" });
                }
                
                var remboursement = await _pretService.EffectuerRemboursementAsync(request.IdPret, request.Montant);
                _logger.LogInformation($"Remboursement effectué avec succès: {remboursement.IdRemboursement} pour le prêt {request.IdPret}");
                return CreatedAtAction(nameof(ObtenirRemboursement), new { id = remboursement.IdRemboursement }, remboursement);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur de validation lors du remboursement: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur inattendue lors du remboursement - IdPret: {request?.IdPret}, Montant: {request?.Montant}");
                return StatusCode(500, new { message = "Erreur interne du serveur", details = ex.Message });
            }
        }

        [HttpGet("remboursements/{id}")]
        public async Task<ActionResult<Remboursement>> ObtenirRemboursement(long id)
        {
            try
            {
                // Trouver le remboursement via les prêts
                var prets = await _pretService.ObtenirPretsActifsAsync();
                var remboursement = prets.SelectMany(p => p.Remboursements)
                                        .FirstOrDefault(r => r.IdRemboursement == id);
                
                if (remboursement == null)
                {
                    return NotFound(new { message = "Remboursement introuvable" });
                }

                return Ok(remboursement);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération du remboursement {id}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("prets/{idPret}/remboursements")]
        public async Task<ActionResult<List<Remboursement>>> ObtenirRemboursementsParPret(long idPret)
        {
            try
            {
                var remboursements = await _pretService.ObtenirRemboursementsParPretAsync(idPret);
                return Ok(remboursements);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération des remboursements pour le prêt {idPret}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES SIMULATIONS ET CALCULS =====

        [HttpPost("simulations")]
        public async Task<ActionResult<object>> SimulerPret([FromBody] SimulerPretRequest request)
        {
            try
            {
                var simulation = await _pretService.SimulerPretAsync(request.Montant, request.DureeEnMois, request.IdTaux);
                return Ok(simulation);
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning($"Erreur lors de la simulation: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la simulation de prêt");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("prets/{idPret}/echeancier")]
        public async Task<ActionResult<object>> CalculerEcheancier(long idPret)
        {
            try
            {
                var echeancier = await _pretService.CalculerEcheancierAsync(idPret);
                return Ok(echeancier);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur lors du calcul de l'échéancier: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors du calcul de l'échéancier pour le prêt {idPret}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES TAUX =====

        [HttpGet("taux")]
        public async Task<ActionResult<List<TauxPret>>> ObtenirTaux()
        {
            try
            {
                var taux = await _pretService.ObtenirTousLesTauxAsync();
                return Ok(taux);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la récupération des taux de prêt");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("taux/actuel")]
        public async Task<ActionResult<TauxPret>> ObtenirTauxActuel()
        {
            try
            {
                var taux = await _pretService.ObtenirTauxActuelAsync();
                if (taux == null)
                {
                    return NotFound(new { message = "Aucun taux de prêt configuré" });
                }
                return Ok(taux);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la récupération du taux actuel");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES STATISTIQUES =====

        [HttpGet("statistiques")]
        public async Task<ActionResult<object>> ObtenirStatistiquesGenerales()
        {
            try
            {
                var statistiques = await _pretService.ObtenirStatistiquesPretsAsync();
                return Ok(statistiques);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la récupération des statistiques générales");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("comptes/{idCompte}/statistiques")]
        public async Task<ActionResult<object>> ObtenirStatistiquesParCompte(long idCompte)
        {
            try
            {
                var statistiques = await _pretService.ObtenirStatistiquesPretsAsync(idCompte);
                return Ok(statistiques);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération des statistiques pour le compte {idCompte}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINT DE SANTÉ =====

        [HttpGet("health")]
        public IActionResult Health()
        {
            return Ok(new { status = "healthy", service = "pret-api", timestamp = DateTime.Now });
        }

        [HttpGet("diagnostic")]
        public async Task<IActionResult> Diagnostic()
        {
            try
            {
                var diagnostic = new
                {
                    service = "pret-api",
                    timestamp = DateTime.Now,
                    database = new
                    {
                        canConnect = false,
                        tablesExist = false,
                        pretCount = 0,
                        remboursementCount = 0,
                        error = ""
                    }
                };

                try
                {
                    // Test de connexion à la base
                    var pretCount = await _pretService.ObtenirPretsActifsAsync();
                    diagnostic = new
                    {
                        service = "pret-api",
                        timestamp = DateTime.Now,
                        database = new
                        {
                            canConnect = true,
                            tablesExist = true,
                            pretCount = pretCount.Count,
                            remboursementCount = 0, // À implémenter si nécessaire
                            error = ""
                        }
                    };
                }
                catch (Exception dbEx)
                {
                    diagnostic = new
                    {
                        service = "pret-api",
                        timestamp = DateTime.Now,
                        database = new
                        {
                            canConnect = false,
                            tablesExist = false,
                            pretCount = 0,
                            remboursementCount = 0,
                            error = dbEx.Message
                        }
                    };
                }

                return Ok(diagnostic);
            }
            catch (Exception ex)
            {
                return StatusCode(500, new { error = ex.Message, details = ex.ToString() });
            }
        }
    }

    // ===== MODÈLES DE REQUÊTE =====

    public class CreerPretRequest
    {
        public long IdCompte { get; set; }
        public decimal Montant { get; set; }
        public int DureeEnMois { get; set; }
    }

    public class ModifierStatutRequest
    {
        public string NouveauStatut { get; set; } = string.Empty;
    }

    public class EffectuerRemboursementRequest
    {
        public long IdPret { get; set; }
        public decimal Montant { get; set; }
    }

    public class SimulerPretRequest
    {
        public decimal Montant { get; set; }
        public int DureeEnMois { get; set; }
        public long? IdTaux { get; set; }
    }
}
