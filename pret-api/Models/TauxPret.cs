using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PretApi.Models
{
    [Table("tauxpret")]
    public class TauxPret
    {
        [Key]
        [Column("idtaux")]
        public long IdTaux { get; set; }

        [Column("pourcentage")]
        [Required]
        [Range(0, 100)]
        public decimal Pourcentage { get; set; }

        [Column("dateapplication")]
        public DateTime DateApplication { get; set; }

        // Navigation property
        public virtual ICollection<Pret> Prets { get; set; } = new List<Pret>();
    }
}
