package model;

public class Bin {

    private int binId;
    private int warehouseId;
    private String binType; // "Temporary" hoặc "Permanent"

    public Bin() {
    }
    

    public Bin(int binId, int warehouseId, String binType) {
        this.binId = binId;
        this.warehouseId = warehouseId;
        this.binType = binType;
    }


    public int getBinId() {
        return binId;
    }

    public void setBinId(int binId) {
        this.binId = binId;
    }

    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getBinType() {
        return binType;
    }

    public void setBinType(String binType) {
        this.binType = binType;
    }
}
