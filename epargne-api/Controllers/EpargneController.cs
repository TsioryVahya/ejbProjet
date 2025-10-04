using EpargneApi.Models;
using EpargneApi.Services;
using Microsoft.AspNetCore.Mvc;

namespace EpargneApi.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class EpargneController : ControllerBase
    {
        private readonly EpargneService _epargneService;
        private readonly ILogger<EpargneController> _logger;

        public EpargneController(EpargneService epargneService, ILogger<EpargneController> logger)
        {
            _epargneService = epargneService;
            _logger = logger;
        }

        // ===== ENDPOINTS POUR LES DÉPÔTS D'ÉPARGNE =====

        [HttpPost("depots")]
        public async Task<ActionResult<DepotEpargne>> CreerDepot([FromBody] CreerDepotRequest request)
        {
            try
            {
                var depot = await _epargneService.CreerDepotEpargneAsync(request.IdCompte, request.Montant);
                _logger.LogInformation($"Dépôt d'épargne créé: {depot.IdDepotEpargne} pour le compte {request.IdCompte}");
                return CreatedAtAction(nameof(ObtenirDepot), new { id = depot.IdDepotEpargne }, depot);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur lors de la création du dépôt: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur inattendue lors de la création du dépôt");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("depots/{id}")]
        public async Task<ActionResult<DepotEpargne>> ObtenirDepot(long id)
        {
            try
            {
                var depot = await _epargneService.ObtenirDepotParIdAsync(id);
                if (depot == null)
                {
                    return NotFound(new { message = "Dépôt d'épargne introuvable" });
                }

                return Ok(depot);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération du dépôt {id}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("comptes/{idCompte}/depots")]
        public async Task<ActionResult<List<DepotEpargne>>> ObtenirDepotsParCompte(long idCompte)
        {
            try
            {
                var depots = await _epargneService.ObtenirDepotsParCompteAsync(idCompte);
                return Ok(depots);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération des dépôts pour le compte {idCompte}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES RETRAITS D'ÉPARGNE =====

        [HttpPost("retraits")]
        public async Task<ActionResult<RetraitEpargne>> CreerRetrait([FromBody] CreerRetraitRequest request)
        {
            try
            {
                var retrait = await _epargneService.CreerRetraitEpargneAsync(request.IdDepot, request.Montant);
                _logger.LogInformation($"Retrait d'épargne créé: {retrait.IdRetraitEpargne} pour le dépôt {request.IdDepot}");
                return CreatedAtAction(nameof(ObtenirRetrait), new { id = retrait.IdRetraitEpargne }, retrait);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning($"Erreur lors de la création du retrait: {ex.Message}");
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur inattendue lors de la création du retrait");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("retraits/{id}")]
        public async Task<ActionResult<RetraitEpargne>> ObtenirRetrait(long id)
        {
            try
            {
                var depot = await _epargneService.ObtenirDepotParIdAsync(id);
                if (depot == null)
                {
                    return NotFound(new { message = "Retrait d'épargne introuvable" });
                }

                var retrait = depot.RetraitsEpargne.FirstOrDefault(r => r.IdRetraitEpargne == id);
                if (retrait == null)
                {
                    return NotFound(new { message = "Retrait d'épargne introuvable" });
                }

                return Ok(retrait);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération du retrait {id}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("depots/{idDepot}/retraits")]
        public async Task<ActionResult<List<RetraitEpargne>>> ObtenirRetraitsParDepot(long idDepot)
        {
            try
            {
                var retraits = await _epargneService.ObtenirRetraitsParDepotAsync(idDepot);
                return Ok(retraits);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération des retraits pour le dépôt {idDepot}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES CALCULS ET STATISTIQUES =====

        [HttpGet("comptes/{idCompte}/solde")]
        public async Task<ActionResult<decimal>> ObtenirSoldeEpargne(long idCompte)
        {
            try
            {
                var solde = await _epargneService.CalculerTotalEpargneParCompteAsync(idCompte);
                return Ok(new { idCompte, solde });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors du calcul du solde épargne pour le compte {idCompte}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("comptes/{idCompte}/statistiques")]
        public async Task<ActionResult<object>> ObtenirStatistiques(long idCompte)
        {
            try
            {
                var statistiques = await _epargneService.ObtenirStatistiquesEpargneAsync(idCompte);
                return Ok(statistiques);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors de la récupération des statistiques pour le compte {idCompte}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("depots/{idDepot}/interets")]
        public async Task<ActionResult<object>> CalculerInterets(long idDepot, [FromQuery] DateTime? dateCalcul = null)
        {
            try
            {
                var depot = await _epargneService.ObtenirDepotParIdAsync(idDepot);
                if (depot == null)
                {
                    return NotFound(new { message = "Dépôt d'épargne introuvable" });
                }

                var date = dateCalcul ?? DateTime.Now;
                var interets = _epargneService.CalculerInterets(depot, date);
                var montantDisponible = _epargneService.CalculerMontantDisponible(depot);

                return Ok(new
                {
                    idDepot,
                    montantInitial = depot.MontantEpargne,
                    interetsCalcules = interets,
                    montantDisponible,
                    dateCalcul = date,
                    tauxApplique = depot.TauxEpargne?.Pourcentage
                });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, $"Erreur lors du calcul des intérêts pour le dépôt {idDepot}");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINTS POUR LES TAUX =====

        [HttpGet("taux")]
        public async Task<ActionResult<List<TauxEpargne>>> ObtenirTaux()
        {
            try
            {
                var taux = await _epargneService.ObtenirTousLesTauxAsync();
                return Ok(taux);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la récupération des taux d'épargne");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        [HttpGet("taux/actuel")]
        public async Task<ActionResult<TauxEpargne>> ObtenirTauxActuel()
        {
            try
            {
                var taux = await _epargneService.ObtenirTauxActuelAsync();
                if (taux == null)
                {
                    return NotFound(new { message = "Aucun taux d'épargne configuré" });
                }
                return Ok(taux);
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Erreur lors de la récupération du taux actuel");
                return StatusCode(500, new { message = "Erreur interne du serveur" });
            }
        }

        // ===== ENDPOINT DE SANTÉ =====

        [HttpGet("health")]
        public IActionResult Health()
        {
            return Ok(new { status = "healthy", service = "epargne-api", timestamp = DateTime.Now });
        }
    }

    // ===== MODÈLES DE REQUÊTE =====

    public class CreerDepotRequest
    {
        public long IdCompte { get; set; }
        public decimal Montant { get; set; }
    }

    public class CreerRetraitRequest
    {
        public long IdDepot { get; set; }
        public decimal Montant { get; set; }
    }
}
