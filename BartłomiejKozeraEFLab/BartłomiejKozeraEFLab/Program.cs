using System;

namespace BartlomiejKozeraProducts
{
    class Program
    {
        static void Main(String[] args)
        {
            Console.WriteLine("Podaj nazwę dostawcy: ");
            string CompanyName = Console.ReadLine();
            Console.WriteLine("Podaj adres dostawcy: ");
            string Street = Console.ReadLine();
            Console.WriteLine("Podaj miasto dostawcy: ");
            string City = Console.ReadLine();
            Console.WriteLine("Lista dostawcow: ");
            SupplierContext supplierContext = new SupplierContext();
            Supplier supplier = new Supplier { CompanyName = CompanyName, Street = Street, City = City };
            supplierContext.Suppliers.Add(supplier);
            supplierContext.SaveChanges();

            var query2 = from supp in supplierContext.Suppliers
                         select supp.CompanyName;
            foreach (var cName in query2)
            {
                Console.WriteLine(cName);
            }

            Console.WriteLine("Podaj nazwę produktu: ");
            string ProductName = Console.ReadLine();

            Console.WriteLine("Lista produktów: ");
            ProductContext productContext = new ProductContext();
            Product product = new Product { ProductName = ProductName };
            productContext.Products.Add(product);
            productContext.SaveChanges();

            var query = from prod in productContext.Products
                       select prod.ProductName;
            foreach (var pName in query)
            {
                Console.WriteLine(pName);
            }
        }

    }
}


