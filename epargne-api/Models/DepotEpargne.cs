using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EpargneApi.Models
{
    [Table("depotepargne")]
    public class DepotEpargne
    {
        [Key]
        [Column("iddepotepargne")]
        public long IdDepotEpargne { get; set; }

        [Column("montantepargne")]
        [Required]
        public decimal MontantEpargne { get; set; }

        [Column("dateepargne")]
        public DateTime DateEpargne { get; set; }

        [Column("duree")]
        [Required]
        public int Duree { get; set; }

        [Column("idcompte")]
        [Required]
        public long IdCompte { get; set; }

        [Column("idtaux")]
        [Required]
        public long IdTaux { get; set; }

        // Navigation properties
        public virtual CompteEpargne? Compte { get; set; }
        public virtual TauxEpargne? TauxEpargne { get; set; }
        public virtual ICollection<RetraitEpargne> RetraitsEpargne { get; set; } = new List<RetraitEpargne>();
    }

    [Table("tauxepargne")]
    public class TauxEpargne
    {
        [Key]
        [Column("idtaux")]
        public long IdTaux { get; set; }

        [Column("pourcentage")]
        [Required]
        public decimal Pourcentage { get; set; }

        [Column("dateapplication")]
        public DateTime DateApplication { get; set; }
    }
}
