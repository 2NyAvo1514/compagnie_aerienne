<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-light p-3 rounded">
            <li class="breadcrumb-item"><a href="/statistiques" class="text-decoration-none">Statistiques</a></li>
            <li class="breadcrumb-item"><a href="/statistiques/trajets" class="text-decoration-none">Par trajet</a></li>
            <li class="breadcrumb-item active">Détail trajet</li>
        </ol>
    </nav>
    
    <!-- En-tête du trajet -->
    <div class="card border-primary mb-4">
        <div class="card-header bg-primary text-white">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="mb-0"><i class="fas fa-route me-2"></i>${trajet.trajetComplet}</h3>
                    <p class="mb-0">${trajet.aeroportsComplets}</p>
                </div>
                <div class="text-end">
                    <span class="badge bg-light text-primary fs-6">ID: ${trajet.trajetId}</span>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="row text-center">
                <div class="col-md-3">
                    <h4 class="text-success">
                        <fmt:formatNumber value="${trajet.chiffreAffaires}" 
                                        type="currency" 
                                        currencyCode="MGA"
                                        maxFractionDigits="0" />
                    </h4>
                    <p class="text-muted mb-0">Chiffre d'affaires</p>
                </div>
                <div class="col-md-2">
                    <h4>${trajet.nombreVols}</h4>
                    <p class="text-muted mb-0">Vols programmés</p>
                </div>
                <div class="col-md-2">
                    <h4>${trajet.nombreReservations}</h4>
                    <p class="text-muted mb-0">Réservations</p>
                </div>
                <div class="col-md-2">
                    <h4>${trajet.placesVendues}</h4>
                    <p class="text-muted mb-0">Passagers</p>
                </div>
                <div class="col-md-3">
                    <h4 class="text-dark">
                        <fmt:formatNumber value="${trajet.prixMoyen}" 
                                        type="currency" 
                                        currencyCode="MGA"
                                        maxFractionDigits="0" />
                    </h4>
                    <p class="text-muted mb-0">Prix moyen</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Détails -->
    <div class="row">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Informations détaillées</h5>
                </div>
                <div class="card-body">
                    <table class="table table-borderless">
                        <tr>
                            <td><strong>Aéroport de départ:</strong></td>
                            <td>${trajet.aeroportDepart} (${trajet.villeDepart})</td>
                        </tr>
                        <tr>
                            <td><strong>Aéroport d'arrivée:</strong></td>
                            <td>${trajet.aeroportArrivee} (${trajet.villeArrivee})</td>
                        </tr>
                        <tr>
                            <td><strong>Distance estimée:</strong></td>
                            <td>--- km</td>
                        </tr>
                        <tr>
                            <td><strong>Durée estimée:</strong></td>
                            <td>--- h -- min</td>
                        </tr>
                        <tr>
                            <td><strong>Premier vol:</strong></td>
                            <td>---</td>
                        </tr>
                        <tr>
                            <td><strong>Dernier vol:</strong></td>
                            <td>---</td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2 text-success"></i>Performance</h5>
                </div>
                <div class="card-body">
                    <div class="text-center">
                        <div class="mb-4">
                            <h6>Taux d'occupation estimé</h6>
                            <div class="progress" style="height: 30px;">
                                <div class="progress-bar bg-success" style="width: 75%">
                                    75%
                                </div>
                            </div>
                            <small class="text-muted">Basé sur ${trajet.placesVendues} places vendues</small>
                        </div>
                        
                        <div class="mb-4">
                            <h6>Rentabilité</h6>
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Faible</span>
                                <span class="text-muted">Moyenne</span>
                                <span class="text-muted">Élevée</span>
                            </div>
                            <div class="progress" style="height: 10px;">
                                <div class="progress-bar bg-warning" style="width: 60%"></div>
                            </div>
                        </div>
                        
                        <div>
                            <h6>Satisfaction client</h6>
                            <div class="stars">
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star text-warning"></i>
                                <i class="fas fa-star-half-alt text-warning"></i>
                                <span class="ms-2">4.5/5</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Évolution temporelle -->
    <div class="card border-0 shadow-sm mt-4">
        <div class="card-header bg-white border-0">
            <h5 class="mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Évolution du trajet</h5>
        </div>
        <div class="card-body">
            <div class="text-center py-4">
                <i class="fas fa-chart-line fa-4x text-muted mb-3"></i>
                <p class="text-muted">Graphique d'évolution du chiffre d'affaires mensuel</p>
                <small class="text-muted">(Données historiques)</small>
                
                <div class="row mt-4">
                    <c:forEach items="${historique}" var="h" end="5">
                        <div class="col-md-2">
                            <div class="card border-0 bg-light">
                                <div class="card-body p-2">
                                    <small class="text-muted">${h.trajetComplet}</small>
                                    <div class="fw-bold text-success">
                                        <fmt:formatNumber value="${h.chiffreAffaires}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Actions -->
    <div class="mt-4">
        <div class="d-flex justify-content-between">
            <a href="/statistiques/trajets" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Retour à la liste
            </a>
            <div class="d-flex gap-2">
                <button class="btn btn-primary" onclick="window.print()">
                    <i class="fas fa-print me-2"></i>Imprimer
                </button>
                <a href="#" class="btn btn-success">
                    <i class="fas fa-edit me-2"></i>Modifier le trajet
                </a>
                <a href="#" class="btn btn-warning">
                    <i class="fas fa-chart-line me-2"></i>Analyser en détail
                </a>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        border-radius: 10px;
    }
    
    .breadcrumb {
        background-color: #f8f9fa;
    }
    
    .progress {
        border-radius: 10px;
    }
    
    .stars {
        font-size: 1.5rem;
    }
    
    .table-borderless tr {
        border-bottom: 1px solid #f0f0f0;
    }
    
    .table-borderless tr:last-child {
        border-bottom: none;
    }
</style>

</body>
</html>