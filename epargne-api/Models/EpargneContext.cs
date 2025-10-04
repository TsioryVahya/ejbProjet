using Microsoft.EntityFrameworkCore;

namespace EpargneApi.Models
{
    public class EpargneContext : DbContext
    {
        public EpargneContext(DbContextOptions<EpargneContext> options) : base(options)
        {
        }

        public DbSet<CompteEpargne> Comptes { get; set; }
        public DbSet<Client> Clients { get; set; }
        public DbSet<TypeCompte> TypesCompte { get; set; }
        public DbSet<DepotEpargne> DepotsEpargne { get; set; }
        public DbSet<RetraitEpargne> RetraitsEpargne { get; set; }
        public DbSet<TauxEpargne> TauxEpargne { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configuration des relations
            modelBuilder.Entity<CompteEpargne>()
                .HasOne(c => c.Client)
                .WithMany()
                .HasForeignKey(c => c.IdClient)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<CompteEpargne>()
                .HasOne(c => c.TypeCompte)
                .WithMany()
                .HasForeignKey(c => c.IdTypeCompte)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<DepotEpargne>()
                .HasOne(d => d.Compte)
                .WithMany(c => c.DepotsEpargne)
                .HasForeignKey(d => d.IdCompte)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<DepotEpargne>()
                .HasOne(d => d.TauxEpargne)
                .WithMany()
                .HasForeignKey(d => d.IdTaux)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<RetraitEpargne>()
                .HasOne(r => r.DepotEpargne)
                .WithMany(d => d.RetraitsEpargne)
                .HasForeignKey(r => r.IdDepotEpargne)
                .OnDelete(DeleteBehavior.Cascade);

            // Configuration des contraintes
            modelBuilder.Entity<DepotEpargne>()
                .HasCheckConstraint("CK_DepotEpargne_MontantPositif", "montantepargne > 0");

            modelBuilder.Entity<RetraitEpargne>()
                .HasCheckConstraint("CK_RetraitEpargne_MontantPositif", "montantretraitepargne > 0");

            modelBuilder.Entity<TauxEpargne>()
                .HasCheckConstraint("CK_TauxEpargne_PourcentageValide", "pourcentage >= 0 AND pourcentage <= 100");

            // Configuration des types de données pour PostgreSQL
            modelBuilder.Entity<DepotEpargne>()
                .Property(d => d.MontantEpargne)
                .HasPrecision(15, 2);

            modelBuilder.Entity<RetraitEpargne>()
                .Property(r => r.MontantRetraitEpargne)
                .HasPrecision(15, 2);

            modelBuilder.Entity<TauxEpargne>()
                .Property(t => t.Pourcentage)
                .HasPrecision(5, 2);
        }
    }
}
