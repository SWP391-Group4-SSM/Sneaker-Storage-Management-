package model;

public class Warehouse {

    private int warehouseID;
    private String name;
    private String location;

    public Warehouse(int warehouseID, String name, String location) {
        this.warehouseID = warehouseID;
        this.name = name;
        this.location = location;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
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

}
