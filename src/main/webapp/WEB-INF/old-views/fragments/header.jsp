<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${pageTitle != null ? pageTitle : 'AirMad Airlines'}</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <!-- Styles personnalisés -->
    <style>
        :root {
            --primary-color: #0d6efd;
            --secondary-color: #6c757d;
            --success-color: #198754;
            --info-color: #0dcaf0;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --light-color: #f8f9fa;
            --dark-color: #212529;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
            color: #333;
        }
        
        /* Sidebar */
        .sidebar {
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            width: 250px;
            background: linear-gradient(180deg, var(--primary-color) 0%, #0a58ca 100%);
            color: white;
            z-index: 1000;
            box-shadow: 2px 0 5px rgba(0,0,0,0.1);
            overflow-y: auto;
        }
        
        .sidebar-sticky {
            position: relative;
            height: 100%;
            padding-top: 0;
        }
        
        .logo-area {
            padding: 20px 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 20px;
            background: rgba(0,0,0,0.1);
        }
        
        .logo {
            color: white;
            text-decoration: none;
            font-size: 1.5rem;
            font-weight: bold;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }
        
        .logo i {
            color: #ffd700;
        }
        
        .nav-link {
            color: rgba(255,255,255,0.85);
            padding: 12px 20px;
            margin: 2px 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .nav-link:hover {
            color: white;
            background: rgba(255,255,255,0.1);
            text-decoration: none;
        }
        
        .nav-link.active {
            color: white;
            background: rgba(255,255,255,0.2);
            font-weight: 500;
        }
        
        .nav-link i {
            width: 20px;
            text-align: center;
        }
        
        /* Main content */
        .main-content {
            margin-left: 250px;
            min-height: 100vh;
        }
        
        .navbar-top {
            background: white;
            padding: 15px 25px;
            border-bottom: 1px solid #dee2e6;
            box-shadow: 0 2px 4px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 999;
        }
        
        .page-title {
            font-size: 1.5rem;
            color: var(--primary-color);
            margin: 0;
            font-weight: 600;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: var(--light-color);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
        }
        
        .content-wrapper {
            padding: 25px;
        }
        
        /* Cards */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            margin-bottom: 20px;
            transition: transform 0.2s ease;
        }
        
        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
        }
        
        .card-header {
            background: white;
            border-bottom: 2px solid var(--light-color);
            padding: 15px 20px;
            font-weight: 600;
            color: var(--primary-color);
            border-radius: 10px 10px 0 0 !important;
        }
        
        /* Buttons */
        .btn {
            border-radius: 6px;
            font-weight: 500;
            padding: 8px 16px;
        }
        
        .btn-primary {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }
        
        .btn-primary:hover {
            background: #0b5ed7;
            border-color: #0a58ca;
        }
        
        /* Tables */
        .table {
            margin-bottom: 0;
        }
        
        .table th {
            background: var(--light-color);
            color: var(--dark-color);
            font-weight: 600;
            border-bottom: 2px solid #dee2e6;
            padding: 12px 15px;
        }
        
        .table td {
            padding: 12px 15px;
            vertical-align: middle;
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(13, 110, 253, 0.05);
        }
        
        /* Badges */
        .badge {
            padding: 6px 10px;
            font-weight: 500;
            border-radius: 20px;
        }
        
        /* Responsive */
        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
            }
            
            .logo-text, .nav-link span {
                display: none !important;
            }
            
            .logo {
                justify-content: center;
            }
            
            .logo i {
                margin: 0;
            }
            
            .nav-link {
                justify-content: center;
                padding: 12px;
                margin: 2px 5px;
            }
            
            .nav-link i {
                margin: 0;
                font-size: 1.2rem;
            }
            
            .main-content {
                margin-left: 70px;
            }
            
            .content-wrapper {
                padding: 15px;
            }
        }
        
        @media (max-width: 576px) {
            .navbar-top {
                flex-direction: column;
                gap: 10px;
                padding: 10px 15px;
            }
            
            .page-title {
                font-size: 1.2rem;
            }
            
            .content-wrapper {
                padding: 10px;
            }
        }
    </style>
</head>
<body>