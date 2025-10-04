using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PretApi.Models
{
    [Table("remboursement")]
    public class Remboursement
    {
        [Key]
        [Column("idremboursement")]
        public long IdRemboursement { get; set; }

        [Column("montantrembourser")]
        [Required]
        public decimal MontantRembourser { get; set; }

        [Column("dateremboursement")]
        public DateTime DateRemboursement { get; set; }

        [Column("idpret")]
        [Required]
        public long IdPret { get; set; }

        // Navigation property
        public virtual Pret? Pret { get; set; }
    }
}
