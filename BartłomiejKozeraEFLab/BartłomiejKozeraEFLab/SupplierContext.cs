﻿using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Sqlite;
using System;

namespace BartlomiejKozeraProducts
{
    public class SupplierContext : DbContext
    {
        public DbSet<Company> Suppliers { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            base.OnConfiguring(optionsBuilder);
            optionsBuilder.UseSqlite("Datasource=CompanyDatabase");
        }
    }
}

