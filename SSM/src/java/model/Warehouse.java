package model;
import java.util.Date;

public class Warehouse {
    private int warehouseID;
    private String warehouseCode;
    private String name;
    private String location;
    private Date createdAt;

    // Constructor
    public Warehouse() {}

    public Warehouse(int warehouseID, String warehouseCode, String name, String location, Date createdAt) {
        this.warehouseID = warehouseID;
        this.warehouseCode = warehouseCode;
        this.name = name;
        this.location = location;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public String getWarehouseCode() {
        return warehouseCode;
    }

    public void setWarehouseCode(String warehouseCode) {
        this.warehouseCode = warehouseCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Warehouse{" +
                "warehouseID=" + warehouseID +
                ", warehouseCode='" + warehouseCode + '\'' +
                ", name='" + name + '\'' +
                ", location='" + location + '\'' +
                ", createdAt=" + createdAt +
                '}';
    }
}
