using Microsoft.EntityFrameworkCore;

namespace PretApi.Models
{
    public class PretContext : DbContext
    {
        public PretContext(DbContextOptions<PretContext> options) : base(options)
        {
        }

        public DbSet<Pret> Prets { get; set; }
        public DbSet<Remboursement> Remboursements { get; set; }
        public DbSet<TauxPret> TauxPrets { get; set; }
        public DbSet<Compte> Comptes { get; set; }
        public DbSet<Client> Clients { get; set; }
        public DbSet<TypeCompte> TypesCompte { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuration des relations
            modelBuilder.Entity<Pret>()
                .HasOne(p => p.TauxPret)
                .WithMany(t => t.Prets)
                .HasForeignKey(p => p.IdTaux)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Pret>()
                .HasOne(p => p.Compte)
                .WithMany()
                .HasForeignKey(p => p.IdCompte)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Remboursement>()
                .HasOne(r => r.Pret)
                .WithMany(p => p.Remboursements)
                .HasForeignKey(r => r.IdPret)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<Compte>()
                .HasOne(c => c.Client)
                .WithMany()
                .HasForeignKey(c => c.IdClient)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<Compte>()
                .HasOne(c => c.TypeCompte)
                .WithMany()
                .HasForeignKey(c => c.IdTypeCompte)
                .OnDelete(DeleteBehavior.Restrict);

            // Configuration des contraintes
            modelBuilder.Entity<Pret>()
                .HasCheckConstraint("CK_Pret_DureePositive", "duree > 0");

            modelBuilder.Entity<Pret>()
                .HasCheckConstraint("CK_Pret_MontantInitialPositif", "montantinitial > 0");

            modelBuilder.Entity<Remboursement>()
                .HasCheckConstraint("CK_Remboursement_MontantPositif", "montantrembourser > 0");

            modelBuilder.Entity<TauxPret>()
                .HasCheckConstraint("CK_TauxPret_PourcentageValide", "pourcentage >= 0 AND pourcentage <= 100");

            // Configuration des types de données pour PostgreSQL
            modelBuilder.Entity<Pret>()
                .Property(p => p.MontantInitial)
                .HasPrecision(15, 2);

            modelBuilder.Entity<Pret>()
                .Property(p => p.MontantRestant)
                .HasPrecision(15, 2);

            modelBuilder.Entity<Remboursement>()
                .Property(r => r.MontantRembourser)
                .HasPrecision(15, 2);

            modelBuilder.Entity<TauxPret>()
                .Property(t => t.Pourcentage)
                .HasPrecision(5, 2);

            // Configuration des index pour les performances
            modelBuilder.Entity<Pret>()
                .HasIndex(p => p.IdCompte)
                .HasDatabaseName("IX_Pret_IdCompte");

            modelBuilder.Entity<Pret>()
                .HasIndex(p => p.Statut)
                .HasDatabaseName("IX_Pret_Statut");

            modelBuilder.Entity<Remboursement>()
                .HasIndex(r => r.IdPret)
                .HasDatabaseName("IX_Remboursement_IdPret");

            modelBuilder.Entity<Remboursement>()
                .HasIndex(r => r.DateRemboursement)
                .HasDatabaseName("IX_Remboursement_DateRemboursement");
        }
    }
}
