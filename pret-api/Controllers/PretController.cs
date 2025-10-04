using PretApi.Models;
using PretApi.Services;
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
        public async Task<ActionResult<Pret>> CreerPret([FromBody] CreerPretRequest request)
        {
            try
            {
                var pret = await _pretService.CreerPretAsync(request.IdCompte, request.Montant, request.DureeEnMois);
                _logger.LogInformation($"Prêt créé: {pret.IdPret} pour le compte {request.IdCompte}");
                return CreatedAtAction(nameof(ObtenirPret), new { id = pret.IdPret }, pret);
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
        public async Task<ActionResult<Pret>> ObtenirPret(long id)
        {
            try
            {
                var pret = await _pretService.ObtenirPretParIdAsync(id);
                if (pret == null)
                {
                    return NotFound(new { message = "Prêt introuvable" });
                }

                return Ok(pret);
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
        public async Task<ActionResult<List<Pret>>> ObtenirPretsActifs()
        {
            try
            {
                var prets = await _pretService.ObtenirPretsActifsAsync();
                return Ok(prets);
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
                var remboursement = await _pretService.EffectuerRemboursementAsync(request.IdPret, request.Montant);
                _logger.LogInformation($"Remboursement effectué: {remboursement.IdRemboursement} pour le prêt {request.IdPret}");
                return CreatedAtAction(nameof(ObtenirRemboursement), new { id = remboursement.IdRemboursement }, remboursement);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur lors du remboursement: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur inattendue lors du remboursement");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
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
