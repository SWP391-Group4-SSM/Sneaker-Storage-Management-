package model;

import java.time.LocalDateTime;

public class Stock {

    private int stockId;
    private int productDetailId;
    private int warehouseId;
    private int binId;
    private int quantity;
    private LocalDateTime lastUpdated;

    public Stock() {
    }
    

    public Stock(int stockId, int productDetailId, int warehouseId, int binId, int quantity,
            LocalDateTime lastUpdated) {
        this.stockId = stockId;
        this.productDetailId = productDetailId;
        this.warehouseId = warehouseId;
        this.binId = binId;
        this.quantity = quantity;
        this.lastUpdated = lastUpdated;
    }

    // Getters và Setters
    public int getStockId() {
        return stockId;
    }

    public void setStockId(int stockId) {
        this.stockId = stockId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public int getBinId() {
        return binId;
    }

    public void setBinId(int binId) {
        this.binId = binId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public LocalDateTime getLastUpdated() {
        return lastUpdated;
    }

    public void setLastUpdated(LocalDateTime lastUpdated) {
        this.lastUpdated = lastUpdated;
    }
}
