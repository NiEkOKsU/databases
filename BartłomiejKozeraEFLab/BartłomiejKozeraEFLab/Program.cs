using System;

namespace BartlomiejKozeraProducts
{
    class Program
    {
        static void Main(String[] args)
        {
            CompanyContext companyContext = new CompanyContext();
            /*
            Customer company = new Customer{CompanyName = "Gouda Gruchała", Street = "Wielka wieś 11", City= "Wielka wieś", ZipCode="30364", Discount=0.10};
            companyContext.Customers.Add(company);
            companyContext.SaveChanges();
            IQueryable<Company> linqQuery2 = from b in companyContext.Companies select b;
            List<Company> companiesDetails = linqQuery2.ToList();
            foreach (Company name in companiesDetails)
            {
                System.Console.WriteLine(name.CompanyName);
            }
            var linqQuery = from b in companyContext.Suppliers select b.CompanyName;

            foreach(string name in linqQuery)
            {
                System.Console.WriteLine(name);
            }
            IQueryable<Customer> query = from b in companyContext.Companies.OfType<Customer>()
                                            select b;
            foreach (Customer name in query)
            {
                System.Console.WriteLine(name.CompanyName);
            }
            System.Console.ReadLine();
            */
        }

    }
}


