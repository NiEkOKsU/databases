package org.example;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Product {
    @Id
    @GeneratedValue( strategy = GenerationType.AUTO)
    private int ProductID;
    private String ProductName;
    private int UnitsOnStock;
    public Product(){

    }
    public Product(String productName, int unitsOnStock){
        this.ProductName = productName;
        this.UnitsOnStock = unitsOnStock;
    }

    public Product(String productName){
        this.ProductName = productName;
        this.UnitsOnStock = 0;
    }
}
