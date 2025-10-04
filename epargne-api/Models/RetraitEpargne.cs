using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EpargneApi.Models
{
    [Table("retraitepargne")]
    public class RetraitEpargne
    {
        [Key]
        [Column("idretraitepargne")]
        public long IdRetraitEpargne { get; set; }

        [Column("montantretraitepargne")]
        [Required]
        public decimal MontantRetraitEpargne { get; set; }

        [Column("dateretraitepargne")]
        public DateTime DateRetraitEpargne { get; set; }

        [Column("iddepotepargne")]
        [Required]
        public long IdDepotEpargne { get; set; }

        // Navigation property
        public virtual DepotEpargne? DepotEpargne { get; set; }
    }
}
