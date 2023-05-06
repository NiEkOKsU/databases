using System;
using System.ComponentModel.DataAnnotations;

namespace BartlomiejKozeraProducts
{
    public abstract class Company
    {
        public int CompanyID { get; set; }
        public string CompanyName { get; set; }
        public string Street { get; set; }
        public string City { get; set; }
        public string ZipCode { get; set; }

        public ICollection<Product> Products { get; set; }
    }
}