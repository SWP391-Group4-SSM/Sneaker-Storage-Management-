package model;

public class Stock {

    private int stockID;
    private int productID;
    private int warehouseID;
    private int zoneID;
    private int binID;
    private int quantity;

    public Stock(int stockID, int productID, int warehouseID, int zoneID, int binID, int quantity) {
        this.stockID = stockID;
        this.productID = productID;
        this.warehouseID = warehouseID;
        this.zoneID = zoneID;
        this.binID = binID;
        this.quantity = quantity;
    }

    public int getStockID() {
        return stockID;
    }

    public void setStockID(int stockID) {
        this.stockID = stockID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public int getZoneID() {
        return zoneID;
    }

    public void setZoneID(int zoneID) {
        this.zoneID = zoneID;
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

}
