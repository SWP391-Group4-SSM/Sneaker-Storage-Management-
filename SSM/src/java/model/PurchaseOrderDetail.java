package model;

import java.time.LocalDateTime;

public class PurchaseOrderDetail {
    private int purchaseOrderDetailID;
    private int purchaseOrderID;
    private int productDetailID;
    private int quantityOrdered;
    private double unitPrice;
    private double totalPrice;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public PurchaseOrderDetail() {}

    public PurchaseOrderDetail(int purchaseOrderDetailID, int purchaseOrderID, int productDetailID,
                               int quantityOrdered, double unitPrice, double totalPrice,
                               LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.purchaseOrderDetailID = purchaseOrderDetailID;
        this.purchaseOrderID = purchaseOrderID;
        this.productDetailID = productDetailID;
        this.quantityOrdered = quantityOrdered;
        this.unitPrice = unitPrice;
        this.totalPrice = totalPrice;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public int getPurchaseOrderDetailID() {
        return purchaseOrderDetailID;
    }

    public void setPurchaseOrderDetailID(int purchaseOrderDetailID) {
        this.purchaseOrderDetailID = purchaseOrderDetailID;
    }

    public int getPurchaseOrderID() {
        return purchaseOrderID;
    }

    public void setPurchaseOrderID(int purchaseOrderID) {
        this.purchaseOrderID = purchaseOrderID;
    }

    public int getProductDetailID() {
        return productDetailID;
    }

    public void setProductDetailID(int productDetailID) {
        this.productDetailID = productDetailID;
    }

    public int getQuantityOrdered() {
        return quantityOrdered;
    }

    public void setQuantityOrdered(int quantityOrdered) {
        this.quantityOrdered = quantityOrdered;
    }

    public double getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
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
