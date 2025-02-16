package model;

public class WarehouseManager {

    private int managerID;
    private int warehouseID;

    public WarehouseManager(int managerID, int warehouseID) {
        this.managerID = managerID;
        this.warehouseID = warehouseID;
    }

    public int getManagerID() {
        return managerID;
    }

    public void setManagerID(int managerID) {
        this.managerID = managerID;
    }

    public int getWarehouseID() {
        return warehouseID;
    }

    public void setWarehouseID(int warehouseID) {
        this.warehouseID = warehouseID;
    }

}
