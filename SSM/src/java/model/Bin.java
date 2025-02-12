package model;

import java.sql.Timestamp;

public class Bin {
    private int id;
    private int zoneId;
    private String name;
    private int capacity;
    private int currentLoad;
    private String description;
    private Timestamp createdAt;

    public Bin() {}

    public Bin(int id, int zoneId, String name, int capacity, int currentLoad, String description, Timestamp createdAt) {
        this.id = id;
        this.zoneId = zoneId;
        this.name = name;
        this.capacity = capacity;
        this.currentLoad = currentLoad;
        this.description = description;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getZoneId() { return zoneId; }
    public void setZoneId(int zoneId) { this.zoneId = zoneId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public int getCurrentLoad() { return currentLoad; }
    public void setCurrentLoad(int currentLoad) { this.currentLoad = currentLoad; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
