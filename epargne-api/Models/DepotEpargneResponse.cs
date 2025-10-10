namespace EpargneApi.Models
{
    public class DepotEpargneResponse
    {
        public long IdDepotEpargne { get; set; }
        public decimal MontantEpargne { get; set; }
        public DateTime DateEpargne { get; set; }
        public int Duree { get; set; }
        public long IdCompte { get; set; }
        public long IdTaux { get; set; }
        
        // Informations du compte
        public string NumeroCompte { get; set; } = string.Empty;
        public string NomClient { get; set; } = string.Empty;
        public string PrenomClient { get; set; } = string.Empty;
        
        // Informations du taux
        public decimal TauxPourcentage { get; set; }
        public string? DescriptionTaux { get; set; }
        
        // Retraits associés
        public List<RetraitEpargneResponse> RetraitsEpargne { get; set; } = new List<RetraitEpargneResponse>();
        
        // Méthode statique pour créer à partir d'un DepotEpargne
        public static DepotEpargneResponse FromEntity(DepotEpargne depot)
        {
            return new DepotEpargneResponse
            {
                IdDepotEpargne = depot.IdDepotEpargne,
                MontantEpargne = depot.MontantEpargne,
                DateEpargne = depot.DateEpargne,
                Duree = depot.Duree,
                IdCompte = depot.IdCompte,
                IdTaux = depot.IdTaux,
                NumeroCompte = depot.Compte?.NumeroCompte ?? "",
                NomClient = depot.Compte?.Client?.Nom ?? "",
                PrenomClient = depot.Compte?.Client?.Prenom ?? "",
                TauxPourcentage = depot.TauxEpargne?.Pourcentage ?? 0,
                DescriptionTaux = "Taux standard", // Peut être étendu plus tard
                RetraitsEpargne = depot.RetraitsEpargne?.Select(RetraitEpargneResponse.FromEntity).ToList() ?? new List<RetraitEpargneResponse>()
            };
        }
    }
    
    public class RetraitEpargneResponse
    {
        public long IdRetraitEpargne { get; set; }
        public decimal MontantRetraitEpargne { get; set; }
        public DateTime DateRetraitEpargne { get; set; }
        public long IdDepotEpargne { get; set; }
        
        public static RetraitEpargneResponse FromEntity(RetraitEpargne retrait)
        {
            return new RetraitEpargneResponse
            {
                IdRetraitEpargne = retrait.IdRetraitEpargne,
                MontantRetraitEpargne = retrait.MontantRetraitEpargne,
                DateRetraitEpargne = retrait.DateRetraitEpargne,
                IdDepotEpargne = retrait.IdDepotEpargne
            };
        }
    }
}
