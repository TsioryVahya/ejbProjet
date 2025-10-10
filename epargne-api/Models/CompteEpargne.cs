using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace EpargneApi.Models
{
    [Table("compte")]
    public class CompteEpargne
    {
        [Key]
        [Column("idcompte")]
        public long IdCompte { get; set; }

        [Column("numerocompte")]
        [StringLength(50)]
        public string NumeroCompte { get; set; } = string.Empty;

        [Column("datecreation")]
        public DateTime DateCreation { get; set; }

        [Column("datemodification")]
        public DateTime DateModification { get; set; }

        [Column("actif")]
        public bool Actif { get; set; }

        [Column("idclient")]
        public long IdClient { get; set; }

        [Column("idtypecompte")]
        public long IdTypeCompte { get; set; }

        // Navigation properties
        public virtual ICollection<DepotEpargne> DepotsEpargne { get; set; } = new List<DepotEpargne>();
        public virtual Client? Client { get; set; }
        public virtual TypeCompte? TypeCompte { get; set; }
    }

    [Table("client")]
    public class Client
    {
        [Key]
        [Column("idclient")]
        public long IdClient { get; set; }

        [Column("nom")]
        [StringLength(50)]
        public string Nom { get; set; } = string.Empty;

        [Column("prenom")]
        [StringLength(50)]
        public string Prenom { get; set; } = string.Empty;

        [Column("telephone")]
        [StringLength(15)]
        public string? Telephone { get; set; }

        [Column("email")]
        [StringLength(100)]
        public string? Email { get; set; }

        [Column("datecreation")]
        public DateTime DateCreation { get; set; }
    }

    [Table("typecompte")]
    public class TypeCompte
    {
        [Key]
        [Column("idtypecompte")]
        public long IdTypeCompte { get; set; }

        [Column("nomtypecompte")]
        [StringLength(50)]
        public string NomTypeCompte { get; set; } = string.Empty;

        [Column("description")]
        public string? Description { get; set; }

        [Column("datecreation")]
        public DateTime DateCreation { get; set; }
    }
}
