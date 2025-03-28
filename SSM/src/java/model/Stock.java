package model;

import java.time.LocalDateTime;

public class Stock {

    private int stockID;
    private int productDetailID;
    private int warehouseID;
    private int binID;
    private int quantity;
    private LocalDateTime LastUpdated;
    
    private String productName;
    private int productSize;
    private String productColor;
    private String warehouseName;
    private String binName;

    public Stock() {
    }

    public Stock(int stockID, int productDetailID, int warehouseID, int binID, int quantity, LocalDateTime LastUpdated) {
        this.stockID = stockID;
        this.productDetailID = productDetailID;
        this.warehouseID = warehouseID;
        this.binID = binID;
        this.quantity = quantity;
        this.LastUpdated = LastUpdated;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getProductDetailID() {
        return productDetailID;
    }

    public void setProductDetailID(int productDetailID) {
        this.productDetailID = productDetailID;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public int getBinID() {
        return binID;
    }

    public void setBinID(int binID) {
        this.binID = binID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getLastUpdated() {
        return LastUpdated;
    }

    public void setLastUpdated(LocalDateTime LastUpdated) {
        this.LastUpdated = LastUpdated;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductSize() {
        return productSize;
    }

    public void setProductSize(int productSize) {
        this.productSize = productSize;
    }

    public String getProductColor() {
        return productColor;
    }

    public void setProductColor(String productColor) {
        this.productColor = productColor;
    }

    public String getWarehouseName() {
        return warehouseName;
    }

    public void setWarehouseName(String warehouseName) {
        this.warehouseName = warehouseName;
    }

    public String getBinName() {
        return binName;
    }

    public void setBinName(String binName) {
        this.binName = binName;
    }
    
    

    
}
