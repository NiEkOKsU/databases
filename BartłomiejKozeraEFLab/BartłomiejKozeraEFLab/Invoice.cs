using System;
using System.ComponentModel.DataAnnotations;

namespace BartlomiejKozeraProducts
{
    public class Invoice
    {
        public Invoice() 
        { 
            this.Products = new HashSet<Product>();
        }
        public int InvoiceID { get; set; }
        [Required]
        public int invoiceNumber { get; set; }
        [Required]
        public int quantity { get; set; }
        public virtual ICollection<Product> Products { get; set; }
    }
}

