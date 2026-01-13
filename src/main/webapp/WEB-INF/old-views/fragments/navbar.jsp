<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="sidebar">
    <div class="sidebar-sticky">
        <!-- Logo -->
        <div class="logo-area">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <i class="fas fa-plane"></i>
                <span class="logo-text">AirMad</span>
            </a>
        </div>
        
        <!-- Navigation principale -->
        <nav class="nav flex-column mb-3">
            <a class="nav-link ${param.menu == 'dashboard' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/">
                <i class="fas fa-home"></i>
                <span>Tableau de bord</span>
            </a>
            
            <a class="nav-link ${param.menu == 'vols' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/vols/liste">
                <i class="fas fa-plane-departure"></i>
                <span>Liste des vols</span>
            </a>
            
            <a class="nav-link ${param.menu == 'recherche' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/reservation/recherche">
                <i class="fas fa-search"></i>
                <span>Recherche de vol</span>
            </a>
            
            <a class="nav-link ${param.menu == 'recherche-avancee' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/vols/recherche-avancee">
                <i class="fas fa-filter"></i>
                <span>Recherche avancée</span>
            </a>
            
            <a class="nav-link ${param.menu == 'reservations' ? 'active' : ''}" 
               href="${pageContext.request.contextPath}/reservation/recherche">
                <i class="fas fa-ticket-alt"></i>
                <span>Mes réservations</span>
            </a>
        </nav>
        
        <!-- Section utilisateur -->
        <div class="mt-auto border-top border-light pt-3 mx-3">
            <div class="nav flex-column">
                <a class="nav-link" href="#">
                    <i class="fas fa-cog"></i>
                    <span>Paramètres</span>
                </a>
                
                <a class="nav-link" href="#">
                    <i class="fas fa-question-circle"></i>
                    <span>Aide</span>
                </a>
                
                <a class="nav-link" href="#">
                    <i class="fas fa-sign-out-alt"></i>
                    <span>Déconnexion</span>
                </a>
            </div>
        </div>
    </div>
</div>

<div class="main-content">
    <!-- Barre de navigation supérieure -->
    <nav class="navbar-top d-flex justify-content-between align-items-center">
        <h1 class="page-title">${pageTitle}</h1>
        
        <div class="user-info">
            <div class="user-avatar">
                <i class="fas fa-user"></i>
            </div>
            <div>
                <div class="fw-bold">${sessionScope.userName != null ? sessionScope.userName : 'Invité'}</div>
                <small class="text-muted">${sessionScope.userRole != null ? sessionScope.userRole : 'Client'}</small>
            </div>
        </div>
    </nav>
    
    <!-- Contenu principal -->
    <div class="content-wrapper">