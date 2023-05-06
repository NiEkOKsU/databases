using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace BartlomiejKozeraProducts
{
    [Table("Customer")]
    public class Customer : Company
    {
        public double Discount { get; set; }

    }
}
