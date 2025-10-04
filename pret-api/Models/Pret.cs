using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace PretApi.Models
{
    [Table("prets")]
    public class Pret
    {
        [Key]
        [Column("idpret")]
        public long IdPret { get; set; }

        [Column("duree")]
        [Required]
        public int Duree { get; set; } // Durée en mois

        [Column("datepret")]
        public DateTime DatePret { get; set; }

        [Column("montantinitial")]
        [Required]
        public decimal MontantInitial { get; set; }

        [Column("montantrestant")]
        [Required]
        public decimal MontantRestant { get; set; }

        [Column("statut")]
        [StringLength(20)]
        public string Statut { get; set; } = "ACTIF";

        [Column("idtaux")]
        [Required]
        public long IdTaux { get; set; }

        [Column("idcompte")]
        [Required]
        public long IdCompte { get; set; }

        // Navigation properties
        public virtual TauxPret? TauxPret { get; set; }
        public virtual Compte? Compte { get; set; }
        public virtual ICollection<Remboursement> Remboursements { get; set; } = new List<Remboursement>();

        // Propriétés calculées
        public decimal MontantRembourse => Remboursements?.Sum(r => r.MontantRembourser) ?? 0;
        public decimal MontantTotal => MontantInitial + CalculerInteretsTotal();
        public int NombreRemboursementsEffectues => Remboursements?.Count ?? 0;
        public int RemboursementsRestants => Duree - NombreRemboursementsEffectues;

        public decimal CalculerInteretsTotal()
        {
            if (TauxPret == null) return 0;
            return MontantInitial * (TauxPret.Pourcentage / 100) * (Duree / 12m);
        }

        public decimal CalculerMensualite()
        {
            if (TauxPret == null || Duree == 0) return 0;
            
            var tauxMensuel = TauxPret.Pourcentage / 100 / 12;
            if (tauxMensuel == 0) return MontantInitial / Duree;
            
            var facteur = (decimal)Math.Pow((double)(1 + tauxMensuel), Duree);
            return MontantInitial * tauxMensuel * facteur / (facteur - 1);
        }
    }

    [Table("compte")]
    public class Compte
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
