
package model;

;public class Product {
    private int productID;
    private String name;
    private String description;
    private String sku;
    private double price;
    private String imageURL;

    public Product() {
    }
    public Product(int productID, String name, String description, String sku, double price, String imgURL) {
        this.productID = productID;
        this.name = name;
        this.description = description;
        this.sku = sku;
        this.price = price;
        this.imageURL = imgURL;
    }

    public Product(String name, String description, String sku, double price, String imageURL) {
        this.name = name;
        this.description = description;
        this.sku = sku;
        this.price = price;
        this.imageURL = imageURL;
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

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    
    
}