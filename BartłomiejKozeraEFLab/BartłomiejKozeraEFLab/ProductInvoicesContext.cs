using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Sqlite;

namespace BartlomiejKozeraProducts
{
    public class ProductInvoicesContext : DbContext
    {
        public DbSet<ProductInvoices> ProductInvoices { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlite("Datasource=ProductInvoicesDatabase");
        }
    }
}
