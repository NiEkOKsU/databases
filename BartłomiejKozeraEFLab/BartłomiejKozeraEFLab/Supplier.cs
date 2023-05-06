using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BartlomiejKozeraProducts
{
    [Table("Supplier")]
    public class Supplier : Company
    {
        public int BankAccountNumber { get; set; }
    }
}

