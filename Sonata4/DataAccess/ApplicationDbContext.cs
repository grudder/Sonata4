using System.Data.Entity;

using Sonata4.Models;

namespace Sonata4.DataAccess
{
	public class ApplicationDbContext : DbContext
	{
		public ApplicationDbContext()
			: base("name=DefaultConnection")
		{
		}

		public virtual DbSet<Shop> Shops
		{
			get;
			set;
		}

		public virtual DbSet<Appointment> Appointments
		{
			get;
			set;
		}

		public virtual DbSet<Score> Scores
		{
			get;
			set;
		}

		public virtual DbSet<Prize> Prizes
		{
			get;
			set;
		}
		
		public virtual DbSet<Winning> Winnings
		{
			get;
			set;
		}

		protected override void OnModelCreating(DbModelBuilder modelBuilder)
		{
		}
	}
}