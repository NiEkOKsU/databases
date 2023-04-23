using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BartłomiejKozeraEFLab.Migrations.Product
{
    /// <inheritdoc />
    public partial class ChangeRelation : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Supplier_SupplierID",
                table: "Products");

            migrationBuilder.DropTable(
                name: "Supplier");

            migrationBuilder.RenameColumn(
                name: "SupplierID",
                table: "Products",
                newName: "CompanyID");

            migrationBuilder.RenameIndex(
                name: "IX_Products_SupplierID",
                table: "Products",
                newName: "IX_Products_CompanyID");

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
                name: "FK_Products_Company_CompanyID",
                table: "Products",
                column: "CompanyID",
                principalTable: "Company",
                principalColumn: "CompanyID",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Products_Company_CompanyID",
                table: "Products");

            migrationBuilder.DropTable(
                name: "Company");

            migrationBuilder.RenameColumn(
                name: "CompanyID",
                table: "Products",
                newName: "SupplierID");

            migrationBuilder.RenameIndex(
                name: "IX_Products_CompanyID",
                table: "Products",
                newName: "IX_Products_SupplierID");

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
                name: "FK_Products_Supplier_SupplierID",
                table: "Products",
                column: "SupplierID",
                principalTable: "Supplier",
                principalColumn: "SupplierID",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
