package model;

import java.time.LocalDateTime;

public class TransferOrder {

    private int transferOrderId;
    private int warehouseId;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public TransferOrder(int transferOrderId, int warehouseId, String status, LocalDateTime createdAt,
            LocalDateTime updatedAt) {
        this.transferOrderId = transferOrderId;
        this.warehouseId = warehouseId;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters và Setters
    public int getTransferOrderId() {
        return transferOrderId;
    }

    public void setTransferOrderId(int transferOrderId) {
        this.transferOrderId = transferOrderId;
    }

    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }
}
