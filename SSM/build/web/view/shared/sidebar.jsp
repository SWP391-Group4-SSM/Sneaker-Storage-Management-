<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar bg-dark text-white" id="sidebar">
    <div class="sidebar-header p-3">
        <h5 class="sidebar-title text-white mb-3">
            <i class="bi bi-gear-fill me-2"></i>
            Management System
        </h5>
        <div class="user-info mb-2">
            <i class="bi bi-person-circle"></i>
            <span class="ms-2">${currentUser}</span>
        </div>
        <div class="text-muted small">
            <i class="bi bi-clock"></i>
            <span class="ms-2">${currentDateTime}</span>
        </div>
    </div>
    
    <hr class="bg-light my-2">
    
    <ul class="nav flex-column">
        <li class="nav-item">
            <a class="nav-link text-white ${pageContext.request.servletPath.contains('/Product/productList.jsp') ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/productList">
                <i class="bi bi-box-seam me-2"></i>
                Products Management
            </a>
        </li>
        
        <li class="nav-item">
            <a class="nav-link text-white ${pageContext.request.servletPath.contains('/PurchaseOrder/purchaseOrderList.jsp') ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/purchaseOrder">
                <i class="bi bi-cart me-2"></i>
                Purchase Orders
            </a>
        </li>
        
        <li class="nav-item">
            <a class="nav-link text-white ${pageContext.request.servletPath.contains('/Stock/stockList.jsp') ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/stockList">
                <i class="bi bi-building me-2"></i>
                Stock Management
            </a>
        </li>
    </ul>
    
    <hr class="bg-light my-2">
    
    <div class="px-3 py-2">
        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light w-100">
            <i class="bi bi-box-arrow-right me-2"></i>
            Logout
        </a>
    </div>
</div>

<style>
    /* Sidebar styles */
    .sidebar {
        position: fixed;
        top: 0;
        left: 0;
        height: 100vh;
        width: 280px;
        z-index: 1000;
        overflow-y: auto;
    }
    
    /* Main content styles */
    .main-content {
        margin-left: 280px;
        padding: 20px;
        min-height: 100vh;
        background-color: #f8f9fa;
    }
    
    /* Navigation link styles */
    .sidebar .nav-link {
        padding: 0.8rem 1rem;
        border-radius: 4px;
        margin: 0.2rem 1rem;
        transition: all 0.3s;
    }
    
    .sidebar .nav-link:hover {
        background-color: rgba(255, 255, 255, 0.1);
    }
    
    .sidebar .nav-link.active {
        background-color: #0d6efd;
        font-weight: 500;
    }
    
    /* Header styles */
    .sidebar-header {
        padding: 1.5rem 1rem;
        background-color: rgba(0, 0, 0, 0.1);
    }
    
    .sidebar-title {
        font-size: 1.1rem;
        font-weight: 500;
        margin-bottom: 1rem;
    }
    
    /* Responsive styles */
    @media (max-width: 768px) {
        .sidebar {
            transform: translateX(-100%);
            transition: transform 0.3s ease-in-out;
        }
        
        .sidebar.show {
            transform: translateX(0);
        }
        
        .main-content {
            margin-left: 0;
        }
    }
</style>