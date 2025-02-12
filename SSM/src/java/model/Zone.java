package model;
import java.sql.Timestamp;

public class Zone {
    private int id;
    private int warehouseId;
    private String name;
    private int capacity;
    private String description;

    public Zone() {}

    public Zone(int id, int warehouseId, String name, int capacity, String description) {
        this.id = id;
        this.warehouseId = warehouseId;
        this.name = name;
        this.capacity = capacity;
        this.description = description;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getWarehouseId() { return warehouseId; }
    public void setWarehouseId(int warehouseId) { this.warehouseId = warehouseId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public int getCapacity() { return capacity; }
    public void setCapacity(int capacity) { this.capacity = capacity; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

}
