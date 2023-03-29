using System;

namespace BartlomiejKozeraProducts
{
    class Program
    {
        static void Main(String[] args)
        {

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


