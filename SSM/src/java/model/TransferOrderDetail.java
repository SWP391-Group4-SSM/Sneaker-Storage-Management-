package model;

import java.time.LocalDateTime;

public class TransferOrderDetail {

    private int transferOrderDetailId;
    private int transferOrderId;
    private int productDetailId;
    private int sourceBinId;
    private int destinationBinId;
    private int quantity;
    private String status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public TransferOrderDetail(int transferOrderDetailId, int transferOrderId, int productDetailId,
            int sourceBinId, int destinationBinId, int quantity, String status,
            LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.transferOrderDetailId = transferOrderDetailId;
        this.transferOrderId = transferOrderId;
        this.productDetailId = productDetailId;
        this.sourceBinId = sourceBinId;
        this.destinationBinId = destinationBinId;
        this.quantity = quantity;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters và Setters
    public int getTransferOrderDetailId() {
        return transferOrderDetailId;
    }

    public void setTransferOrderDetailId(int transferOrderDetailId) {
        this.transferOrderDetailId = transferOrderDetailId;
    }

    public int getTransferOrderId() {
        return transferOrderId;
    }

    public void setTransferOrderId(int transferOrderId) {
        this.transferOrderId = transferOrderId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public int getSourceBinId() {
        return sourceBinId;
    }

    public void setSourceBinId(int sourceBinId) {
        this.sourceBinId = sourceBinId;
    }

    public int getDestinationBinId() {
        return destinationBinId;
    }

    public void setDestinationBinId(int destinationBinId) {
        this.destinationBinId = destinationBinId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
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
