package model;

import java.sql.Timestamp;

public class WarehouseSection {
    private int sectionID;
    private int warehouseID;
    private String sectionName;
    private int capacity;
    private String description;
    private Timestamp createdAt;

    public WarehouseSection(int sectionID, int warehouseID, String sectionName, int capacity, String description, Timestamp createdAt) {
        this.sectionID = sectionID;
        this.warehouseID = warehouseID;
        this.sectionName = sectionName;
        this.capacity = capacity;
        this.description = description;
        this.createdAt = createdAt;
    }

    public int getSectionID() {
        return sectionID;
    }

    public void setSectionID(int sectionID) {
        this.sectionID = sectionID;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

    public String getSectionName() {
        return sectionName;
    }

    public void setSectionName(String sectionName) {
        this.sectionName = sectionName;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(int capacity) {
        this.capacity = capacity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
