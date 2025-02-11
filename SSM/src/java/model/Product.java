
package model;

public class Product {
    private int productID;
    private String name;
    private String description;
    private String sku;
    private double price;

    public Product(int productID, String name, String description, String sku, double price) {
        this.productID = productID;
        this.name = name;
        this.description = description;
        this.sku = sku;
        this.price = price;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getSku() {
        return sku;
    }

    public void setSku(String sku) {
        this.sku = sku;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
    
    

}