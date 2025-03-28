<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- Common header content START -->
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${param.title}</title>
        <!-- Common CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
        <!-- Common styles -->
        <style>
            .stock-badge {
                font-size: 0.875rem;
                padding: 0.35em 0.65em;
            }
            .stock-low { background-color: #dc3545 !important; }
            .stock-medium { background-color: #ffc107 !important; color: #000 !important; }
            .stock-high { background-color: #198754 !important; }
            
            .action-buttons .btn {
                margin: 0 2px;
            }
        </style>
    </head>
    <body class="bg-light">
        <!-- Include Sidebar -->
        <jsp:include page="sidebar.jsp"/>
        
        <!-- Main Content START -->
        <div class="main-content">
            <div class="container-fluid">
                <!-- Debug Info START -->
                
                <!-- Debug Info END -->
<!-- Common header content END -->