using BartlomiejKozeraProducts;
using Microsoft.EntityFrameworkCore;
using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace BartlomiejKozeraProducts
{
    public class ProductInvoices
    {
        public int ProductInvoicesID { get; set; }
        [ForeignKey("Product")]
        public ICollection<Product> ProductsID { get; set; }
        [ForeignKey("Product")]
        public ICollection<Invoice> InvoicesID { get; set; }
    }
}
