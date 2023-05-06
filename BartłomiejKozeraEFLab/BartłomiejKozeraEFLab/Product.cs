using System;
using System.ComponentModel.DataAnnotations;

namespace BartlomiejKozeraProducts
{
    public class Product
    {
        public Product()
        {
            this.Invoices = new HashSet<Invoice>();
        }
        public int ProductID { get; set; }
        [Required]
        public string ProductName { get; set; }
        [Required]
        public int UnitsOnStock { get; set; }
        [Required]
        public Company Company { get; set; }

        public virtual ICollection<Invoice> Invoices { get; set; }
    }
}

