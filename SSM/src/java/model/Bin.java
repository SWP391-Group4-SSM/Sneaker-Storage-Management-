package model;

import java.time.LocalDateTime;

public class Bin {
    private int binId;
    private int sectionId;
    private String binName;
    private int capacity;
    private String description;
    private LocalDateTime createdAt; 
    private Boolean isDeleted;      
    private boolean isLocked;       

    public Bin() {
    }

    public Bin(int binId, int sectionId, String binName, int capacity, String description, 
               LocalDateTime createdAt, Boolean isDeleted, boolean isLocked) {
        this.binId = binId;
        this.sectionId = sectionId;
        this.binName = binName;
        this.capacity = capacity;
        this.description = description;
        this.createdAt = createdAt;
        this.isDeleted = isDeleted;
        this.isLocked = isLocked;
    }

    public int getBinId() {
        return binId;
    }

    public void setBinId(int binId) {
        this.binId = binId;
    }

    public int getSectionId() {
        return sectionId;
    }

    public void setSectionId(int sectionId) {
        this.sectionId = sectionId;
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

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

    public boolean isLocked() {
        return isLocked;
    }

    public void setLocked(boolean isLocked) {
        this.isLocked = isLocked;
    }

    @Override
    public String toString() {
        return "Bin{" +
                "binId=" + binId +
                ", sectionId=" + sectionId +
                ", binName='" + binName + '\'' +
                ", capacity=" + capacity +
                ", description='" + description + '\'' +
                ", createdAt=" + createdAt +
                ", isDeleted=" + isDeleted +
                ", isLocked=" + isLocked +
                '}';
    }
}