<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="text-primary"><i class="fas fa-chart-line me-2"></i>Statistiques</h1>
        <a href="/statistiques/par-periode" class="btn btn-outline-primary">
            <i class="fas fa-calendar-alt me-2"></i>Voir par période
        </a>
    </div>
    
    <!-- Cartes de synthèse -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center border-0 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-money-bill-wave fa-2x text-success mb-3"></i>
                    <h3>
                        <fmt:formatNumber value="${chiffreAffairesTotal}" 
                                        type="currency" 
                                        currencyCode="MGA"
                                        maxFractionDigits="0" />
                    </h3>
                    <p class="text-muted">Chiffre d'affaires total</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center border-0 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-ticket-alt fa-2x text-primary mb-3"></i>
                    <h3>${totalReservations}</h3>
                    <p class="text-muted">Réservations totales</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center border-0 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-users fa-2x text-warning mb-3"></i>
                    <h3>${totalPlacesVendues}</h3>
                    <p class="text-muted">Places vendues</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center border-0 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-plane fa-2x text-info mb-3"></i>
                    <h3>${chiffreAffaires.size()}</h3>
                    <p class="text-muted">Avions actifs</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Tableau des statistiques par avion -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-0">
            <h4 class="mb-0"><i class="fas fa-plane me-2 text-primary"></i>Chiffre d'affaires par avion</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead class="table-light">
                        <tr>
                            <th>Avion</th>
                            <th>Modèle</th>
                            <th>Réservations</th>
                            <th>Places vendues</th>
                            <th>Chiffre d'affaires</th>
                            <th>CA moyen/place</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${chiffreAffaires}" var="ca">
                            <tr>
                                <td>
                                    <strong>${ca.avionNom}</strong>
                                </td>
                                <td>${ca.avionModele}</td>
                                <td>
                                    <span class="badge bg-primary">${ca.nombreReservations}</span>
                                </td>
                                <td>
                                    <span class="badge bg-info">${ca.placesVendues}</span>
                                </td>
                                <td>
                                    <strong class="text-success">
                                        <fmt:formatNumber value="${ca.chiffreAffaires}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </strong>
                                </td>
                                <td>
                                    <c:if test="${ca.placesVendues > 0}">
                                        <fmt:formatNumber value="${ca.chiffreAffaires / ca.placesVendues}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </c:if>
                                    <c:if test="${ca.placesVendues == 0}">-</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot class="table-secondary">
                        <tr>
                            <td colspan="4" class="text-end fw-bold">TOTAL :</td>
                            <td class="fw-bold text-success">
                                <fmt:formatNumber value="${chiffreAffairesTotal}" 
                                                type="currency" 
                                                currencyCode="MGA"
                                                maxFractionDigits="0" />
                            </td>
                            <td>
                                <c:if test="${totalPlacesVendues > 0}">
                                    <fmt:formatNumber value="${chiffreAffairesTotal / totalPlacesVendues}" 
                                                    type="currency" 
                                                    currencyCode="MGA"
                                                    maxFractionDigits="0" />
                                </c:if>
                            </td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Graphique (simulé) -->
    <div class="card border-0 shadow-sm mt-4">
        <div class="card-header bg-white border-0">
            <h4 class="mb-0"><i class="fas fa-chart-bar me-2 text-primary"></i>Répartition du chiffre d'affaires</h4>
        </div>
        <div class="card-body">
            <div class="text-center py-4">
                <i class="fas fa-chart-pie fa-4x text-muted mb-3"></i>
                <p class="text-muted">Graphique de répartition du chiffre d'affaires par avion</p>
                <small class="text-muted">(Intégration avec une bibliothèque de graphiques recommandée)</small>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        border-radius: 10px;
        transition: transform 0.3s ease;
    }
    
    .card:hover {
        transform: translateY(-5px);
    }
    
    .table th {
        background-color: #f8f9fa;
    }
    
    .badge {
        font-size: 0.85em;
        padding: 0.4em 0.8em;
    }
</style>

</body>
</html>