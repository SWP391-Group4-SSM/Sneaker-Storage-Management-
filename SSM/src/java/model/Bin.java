package model;

import java.sql.Timestamp;

public class Bin {
    private int binID;
    private int sectionID;
    private String binName;
    private int capacity;
    private String description;
    private Timestamp createdAt;
    private boolean isDeleted;

    public Bin(int binID, int sectionID, String binName, int capacity, String description, Timestamp createdAt, boolean isDeleted) {
        this.binID = binID;
        this.sectionID = sectionID;
        this.binName = binName;
        this.capacity = capacity;
        this.description = description;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
    }

    // Getters and setters
    public int getBinID() {
        return binID;
    }

    public void setBinID(int binID) {
        this.binID = binID;
    }

    public int getSectionID() {
        return sectionID;
    }

    public void setSectionID(int sectionID) {
        this.sectionID = sectionID;
    }

    public String getBinName() {
        return binName;
    }

    public void setBinName(String binName) {
        this.binName = binName;
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

    public boolean isDeleted() {
        return isDeleted;
    }

    public void setDeleted(boolean isDeleted) {
        this.isDeleted = isDeleted;
    }
}