<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-light p-3 rounded">
            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/" class="text-decoration-none">Accueil</a></li>
            <li class="breadcrumb-item active">Détails du vol</li>
        </ol>
    </nav>
    
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white border-0 d-flex justify-content-between align-items-center">
            <h3 class="mb-0"><i class="fas fa-info-circle me-2 text-primary"></i>Détails du vol</h3>
            <span class="badge ${vol.passe ? 'bg-secondary' : 'bg-success'} fs-6">
                ${vol.passe ? 'TERMINÉ' : 'DISPONIBLE'}
            </span>
        </div>
        <div class="card-body">
            <!-- Flight Information -->
            <div class="row mb-4">
                <div class="col-md-12">
                    <div class="flight-info bg-light p-4 rounded">
                        <div class="row align-items-center">
                            <div class="col-md-5 text-center">
                                <div class="mb-3">
                                    <h5 class="text-primary mb-2"><i class="fas fa-plane-departure me-2"></i>DÉPART</h5>
                                    <h4 class="fw-bold">${vol.vol.aeroportDepart.ville}</h4>
                                    <p class="text-muted mb-0">${vol.vol.aeroportDepart.nom}</p>
                                </div>
                                <div class="flight-time">
                                    <h3 class="fw-bold">${vol.dateHeureFormatted}</h3>
                                </div>
                            </div>
                            
                            <div class="col-md-2 text-center">
                                <div class="position-relative">
                                    <i class="fas fa-plane fa-2x text-primary"></i>
                                    <div class="mt-3">
                                        <span class="badge bg-info">1h30</span>
                                        <div class="text-muted mt-1">Durée</div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-5 text-center">
                                <div class="mb-3">
                                    <h5 class="text-success mb-2"><i class="fas fa-plane-arrival me-2"></i>ARRIVÉE</h5>
                                    <h4 class="fw-bold">${vol.vol.aeroportArrivee.ville}</h4>
                                    <p class="text-muted mb-0">${vol.vol.aeroportArrivee.nom}</p>
                                </div>
                                <div class="flight-time">
                                    <h3 class="fw-bold">${vol.dateHeureFormatted}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Detailed Information -->
            <div class="row">
                <div class="col-md-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-header bg-light">
                            <h5 class="mb-0"><i class="fas fa-plane me-2 text-primary"></i>Informations avion</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <td><strong>Avion:</strong></td>
                                    <td>${vol.avion.nom}</td>
                                </tr>
                                <tr>
                                    <td><strong>Modèle:</strong></td>
                                    <td>${vol.avion.modele}</td>
                                </tr>
                                <tr>
                                    <td><strong>Capacité:</strong></td>
                                    <td>${vol.avion.capacite} places</td>
                                </tr>
                                <tr>
                                    <td><strong>Référence:</strong></td>
                                    <td>MD${vol.id}</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6 mb-3">
                    <div class="card h-100 border-0 shadow-sm">
                        <div class="card-header bg-light">
                            <h5 class="mb-0"><i class="fas fa-map-marked-alt me-2 text-success"></i>Informations vol</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-borderless">
                                <tr>
                                    <td><strong>Type de vol:</strong></td>
                                    <td>Direct</td>
                                </tr>
                                <tr>
                                    <td><strong>Classe:</strong></td>
                                    <td>Économique</td>
                                </tr>
                                <tr>
                                    <td><strong>Bagage soute:</strong></td>
                                    <td>20kg inclus</td>
                                </tr>
                                <tr>
                                    <td><strong>Bagage main:</strong></td>
                                    <td>7kg inclus</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="text-center mt-4">
                <c:if test="${not vol.passe}">
                    <c:set var="placesDispo" value="${reservationService.getPlacesDisponibles(vol.id)}" />
                    <c:if test="${placesDispo > 0}">
                        <a href="${pageContext.request.contextPath}/reserver?id=${vol.id}" 
                           class="btn btn-primary btn-lg me-3">
                            <i class="fas fa-ticket-alt me-2"></i> Réserver ce vol
                        </a>
                    </c:if>
                </c:if>
                <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-lg">
                    <i class="fas fa-arrow-left me-2"></i> Retour à la recherche
                </a>
            </div>
        </div>
    </div>
    
    <!-- Important Information -->
    <div class="row">
        <div class="col-md-4 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-calculator me-2"></i> Tarifs</h5>
                </div>
                <div class="card-body">
                    <div class="d-flex justify-content-between mb-2">
                        <span>Prix adulte:</span>
                        <span class="fw-bold">250 000 Ar</span>
                    </div>
                    <div class="d-flex justify-content-between mb-2">
                        <span>Prix enfant:</span>
                        <span class="fw-bold">200 000 Ar</span>
                    </div>
                    <div class="d-flex justify-content-between mb-3">
                        <span>Prix bébé:</span>
                        <span class="fw-bold">50 000 Ar</span>
                    </div>
                    <hr>
                    <div class="text-center">
                        <small class="text-muted d-block mb-2">À partir de</small>
                        <h4 class="text-primary fw-bold">250 000 Ar</h4>
                        <small class="text-muted">par personne</small>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-8 mb-3">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-info text-white">
                    <h5 class="mb-0"><i class="fas fa-exclamation-circle me-2"></i> Informations importantes</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="alert alert-warning border-0 h-100">
                                <h6><i class="fas fa-clock me-2"></i> Horaires</h6>
                                <p class="mb-0">Présentez-vous 2h avant le décollage.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="alert alert-info border-0 h-100">
                                <h6><i class="fas fa-passport me-2"></i> Documents</h6>
                                <p class="mb-0">Pièce d'identité obligatoire.</p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="alert alert-success border-0 h-100">
                                <h6><i class="fas fa-suitcase-rolling me-2"></i> Bagages</h6>
                                <p class="mb-0">Bagage en soute: 20kg max.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .flight-info {
        background: linear-gradient(135deg, #f8f9fa, #e9ecef);
        border-radius: 10px;
    }
    
    .flight-time h3 {
        color: #2c3e50;
    }
    
    .breadcrumb {
        background-color: #f8f9fa;
    }
    
    .card {
        border-radius: 10px;
    }
    
    .table-borderless tr {
        border-bottom: 1px solid #f0f0f0;
    }
    
    .table-borderless tr:last-child {
        border-bottom: none;
    }
    
    .btn-lg {
        padding: 0.75rem 2rem;
    }
</style>

</body>
</html>