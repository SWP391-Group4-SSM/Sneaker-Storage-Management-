package model;

import java.time.LocalDateTime;

public class DeliveryOrder {

    private int deliveryOrderId;
    private Integer supplierId;
    private int warehouseId;
    private int createdByUserId;
    private LocalDateTime documentDate;
    private String documentStatus;
    private LocalDateTime updatedAt;
    private Boolean isDeleted;
    private Integer purchaseOrderId;

    public DeliveryOrder() {

    }

    public DeliveryOrder(int deliveryOrderId, Integer supplierId, int warehouseId, int createdByUserId, LocalDateTime documentDate, String documentStatus, LocalDateTime updatedAt, Boolean isDeleted) {
        this.deliveryOrderId = deliveryOrderId;
        this.supplierId = supplierId;
        this.warehouseId = warehouseId;
        this.createdByUserId = createdByUserId;
        this.documentDate = documentDate;
        this.documentStatus = documentStatus;
        this.updatedAt = updatedAt;
        this.isDeleted = isDeleted;
    }

   public Integer getPurchaseOrderId() {
    // Return a default value (0) instead of null
    return (this.purchaseOrderId == null) ? 0 : this.purchaseOrderId;
}

    public void setPurchaseOrderId(Integer purchaseOrderId) {
        this.purchaseOrderId = purchaseOrderId;
    }

    // Getters and setters
    public int getDeliveryOrderId() {
        return deliveryOrderId;
    }

    public void setDeliveryOrderId(int deliveryOrderId) {
        this.deliveryOrderId = deliveryOrderId;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public int getWarehouseId() {
        return warehouseId;
    }

    public void setWarehouseId(int warehouseId) {
        this.warehouseId = warehouseId;
    }

    public int getCreatedByUserId() {
        return createdByUserId;
    }

    public void setCreatedByUserId(int createdByUserId) {
        this.createdByUserId = createdByUserId;
    }

    public LocalDateTime getDocumentDate() {
        return documentDate;
    }

    public void setDocumentDate(LocalDateTime documentDate) {
        this.documentDate = documentDate;
    }

    public String getDocumentStatus() {
        return documentStatus;
    }

    public void setDocumentStatus(String documentStatus) {
        this.documentStatus = documentStatus;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Boolean getIsDeleted() {
        return isDeleted;
    }

    public void setIsDeleted(Boolean isDeleted) {
        this.isDeleted = isDeleted;
    }

}
