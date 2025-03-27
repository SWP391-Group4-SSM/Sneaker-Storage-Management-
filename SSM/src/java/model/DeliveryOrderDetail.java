package model;

import java.time.LocalDateTime;

public class DeliveryOrderDetail {

    private int deliveryOrderDetailId;
    private int deliveryOrderId;
    private int productDetailId;
    private int quantityOrdered;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    

    public DeliveryOrderDetail() {
    }

    public DeliveryOrderDetail(int deliveryOrderDetailId, int deliveryOrderId, int productDetailId, int quantityOrdered, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.deliveryOrderDetailId = deliveryOrderDetailId;
        this.deliveryOrderId = deliveryOrderId;
        this.productDetailId = productDetailId;
        this.quantityOrdered = quantityOrdered;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and setters
    public int getDeliveryOrderDetailId() {
        return deliveryOrderDetailId;
    }

    public void setDeliveryOrderDetailId(int deliveryOrderDetailId) {
        this.deliveryOrderDetailId = deliveryOrderDetailId;
    }

    public int getDeliveryOrderId() {
        return deliveryOrderId;
    }

    public void setDeliveryOrderId(int deliveryOrderId) {
        this.deliveryOrderId = deliveryOrderId;
    }

    public int getProductDetailId() {
        return productDetailId;
    }

    public void setProductDetailId(int productDetailId) {
        this.productDetailId = productDetailId;
    }

    public int getQuantityOrdered() {
        return quantityOrdered;
    }

    public void setQuantityOrdered(int quantityOrdered) {
        this.quantityOrdered = quantityOrdered;
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
