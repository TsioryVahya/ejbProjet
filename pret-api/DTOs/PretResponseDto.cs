namespace PretApi.DTOs
{
    public class PretResponseDto
    {
        public long IdPret { get; set; }
        public int Duree { get; set; }
        public DateTime DatePret { get; set; }
        public decimal MontantInitial { get; set; }
        public decimal MontantRestant { get; set; }
        public string Statut { get; set; } = string.Empty;
        public long IdTaux { get; set; }
        public long IdCompte { get; set; }
        
        // Informations du taux (sans relations circulaires)
        public decimal TauxPourcentage { get; set; }
        
        // Informations du compte (sans relations circulaires)
        public string NumeroCompte { get; set; } = string.Empty;
        public string NomClient { get; set; } = string.Empty;
        public string PrenomClient { get; set; } = string.Empty;
    }
}
