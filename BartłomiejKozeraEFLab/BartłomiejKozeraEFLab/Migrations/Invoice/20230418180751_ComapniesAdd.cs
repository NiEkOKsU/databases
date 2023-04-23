using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BartłomiejKozeraEFLab.Migrations.Invoice
{
    /// <inheritdoc />
    public partial class ComapniesAdd : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Product_Supplier_SupplierID",
                table: "Product");

            migrationBuilder.DropTable(
                name: "Supplier");

            migrationBuilder.RenameColumn(
                name: "SupplierID",
                table: "Product",
                newName: "CompanyID");

            migrationBuilder.RenameIndex(
                name: "IX_Product_SupplierID",
                table: "Product",
                newName: "IX_Product_CompanyID");

            migrationBuilder.CreateTable(
                name: "Company",
                columns: table => new
                {
                    CompanyID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    CompanyName = table.Column<string>(type: "TEXT", nullable: false),
                    Street = table.Column<string>(type: "TEXT", nullable: false),
                    City = table.Column<string>(type: "TEXT", nullable: false),
                    ZipCode = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Company", x => x.CompanyID);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Product_Company_CompanyID",
                table: "Product",
                column: "CompanyID",
                principalTable: "Company",
                principalColumn: "CompanyID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Product_Company_CompanyID",
                table: "Product");

            migrationBuilder.DropTable(
                name: "Company");

            migrationBuilder.RenameColumn(
                name: "CompanyID",
                table: "Product",
                newName: "SupplierID");

            migrationBuilder.RenameIndex(
                name: "IX_Product_CompanyID",
                table: "Product",
                newName: "IX_Product_SupplierID");

            migrationBuilder.CreateTable(
                name: "Supplier",
                columns: table => new
                {
                    SupplierID = table.Column<int>(type: "INTEGER", nullable: false)
                        .Annotation("Sqlite:Autoincrement", true),
                    City = table.Column<string>(type: "TEXT", nullable: false),
                    CompanyName = table.Column<string>(type: "TEXT", nullable: false),
                    Street = table.Column<string>(type: "TEXT", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Supplier", x => x.SupplierID);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Product_Supplier_SupplierID",
                table: "Product",
                column: "SupplierID",
                principalTable: "Supplier",
                principalColumn: "SupplierID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
