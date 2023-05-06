using Microsoft.EntityFrameworkCore;
using System;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Sqlite;

namespace BartlomiejKozeraProducts
{
    public abstract class Company2
    {
        public int CompanyID { get; set; }
        public string CompanyName { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }

        public ICollection<Product> Products { get; set; }
    }

    [Table("Supplier")]
    public class Supplier2 : Company2
    {
        public int BankAccountNumber { get; set; }
    }

    [Table("Customer")]
    public class Customer2 : Company2
    {
        public double Discount { get; set; }

    }

    public class Company2Context : DbContext
    {
        public DbSet<Company2> Companies2 { get; set; }
    }
}
