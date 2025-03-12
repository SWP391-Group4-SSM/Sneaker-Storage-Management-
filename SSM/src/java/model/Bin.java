package model;

public class Bin {
    private int binID;
    private String binName;
    private String description;

    public Bin() {}

    public Bin(int binID, String binName, String description) {
        this.binID = binID;
        this.binName = binName;
        this.description = description;
    }

    public int getBinID() {
        return binID;
    }

    public void setBinID(int binID) {
        this.binID = binID;
    }

    public String getBinName() {
        return binName;
    }

    public void setBinName(String binName) {
        this.binName = binName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
