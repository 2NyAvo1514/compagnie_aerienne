<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0"><i class="fas fa-calculator me-2"></i>Exemple: Valeur maximale Tana → Nosy Be</h3>
        </div>
        <div class="card-body">
            <h4 class="text-center mb-4">${exemple.trajet}</h4>
            
            <!-- Tableau des prix -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">Prix par type de place</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Type de place</th>
                                        <th>Prix</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${exemple.prixParType}" var="prix">
                                        <tr>
                                            <td><strong>${prix.key}</strong></td>
                                            <td class="text-success fw-bold">
                                                <fmt:formatNumber value="${prix.value}" 
                                                                type="currency" 
                                                                currencyCode="MGA"
                                                                maxFractionDigits="0" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card border-0 shadow-sm">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">Configuration avion exemple</h5>
                        </div>
                        <div class="card-body">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Type de place</th>
                                        <th>Nombre de places</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${exemple.placesParType}" var="places">
                                        <tr>
                                            <td><strong>${places.key}</strong></td>
                                            <td><span class="badge bg-primary">${places.value}</span></td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="table-secondary">
                                        <td><strong>TOTAL</strong></td>
                                        <td>
                                            <c:set var="totalPlaces" value="0" />
                                            <c:forEach items="${exemple.placesParType}" var="places">
                                                <c:set var="totalPlaces" value="${totalPlaces + places.value}" />
                                            </c:forEach>
                                            <span class="badge bg-success">${totalPlaces}</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Calcul détaillé -->
            <div class="card border-success mb-4">
                <div class="card-header bg-success text-white">
                    <h5 class="mb-0"><i class="fas fa-calculator me-2"></i>Calcul détaillé</h5>
                </div>
                <div class="card-body">
                    <table class="table table-bordered">
                        <thead class="table-light">
                            <tr>
                                <th>Type de place</th>
                                <th>Nombre de places</th>
                                <th>Prix unitaire</th>
                                <th>Valeur totale</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${exemple.valeursParType}" var="valeur">
                                <tr>
                                    <td><strong>${valeur.key}</strong></td>
                                    <td>
                                        <c:set var="type" value="${valeur.key}" />
                                        <span class="badge bg-primary">${exemple.placesParType[type]}</span>
                                    </td>
                                    <td class="text-success">
                                        <fmt:formatNumber value="${exemple.prixParType[type]}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </td>
                                    <td class="fw-bold text-primary">
                                        <fmt:formatNumber value="${valeur.value}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr class="table-success">
                                <td colspan="3" class="text-end fw-bold">VALEUR MAXIMALE TOTALE :</td>
                                <td class="fw-bold fs-5">
                                    <fmt:formatNumber value="${exemple.valeurTotale}" 
                                                    type="currency" 
                                                    currencyCode="MGA"
                                                    maxFractionDigits="0" />
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    
                    <!-- Formule mathématique -->
                    <div class="alert alert-info mt-3">
                        <h6><i class="fas fa-info-circle me-2"></i>Formule de calcul :</h6>
                        <p class="mb-0">
                            Valeur Maximale = Σ (Nombre de places × Prix unitaire) pour chaque type de place
                        </p>
                    </div>
                </div>
            </div>
            
            <!-- Graphique (simulé) -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Répartition de la valeur</h5>
                </div>
                <div class="card-body">
                    <div class="row">
                        <c:forEach items="${exemple.valeursParType}" var="valeur">
                            <div class="col-md-6 mb-3">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <strong>${valeur.key}</strong>
                                        <div class="text-muted small">
                                            <c:set var="type" value="${valeur.key}" />
                                            ${exemple.placesParType[type]} places × 
                                            <fmt:formatNumber value="${exemple.prixParType[type]}" 
                                                            type="currency" 
                                                            currencyCode="MGA"
                                                            maxFractionDigits="0" />
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div class="fw-bold text-success">
                                            <fmt:formatNumber value="${valeur.value}" 
                                                            type="currency" 
                                                            currencyCode="MGA"
                                                            maxFractionDigits="0" />
                                        </div>
                                        <div class="text-muted small">
                                            <fmt:formatNumber value="${valeur.value / exemple.valeurTotale * 100}" 
                                                            maxFractionDigits="1" />%
                                        </div>
                                    </div>
                                </div>
                                <div class="progress mt-2" style="height: 10px;">
                                    <div class="progress-bar bg-success" 
                                         style="width: ${valeur.value / exemple.valeurTotale * 100}%">
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
            
            <!-- Actions -->
            <div class="mt-4 text-center">
                <a href="/valeur-maximale/trajet?depart=Antananarivo&arrivee=Nosy+Be" 
                   class="btn btn-primary me-3">
                    <i class="fas fa-search me-2"></i>Voir les valeurs réelles
                </a>
                <a href="/statistiques" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Retour aux statistiques
                </a>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        border-radius: 10px;
    }
    
    .progress {
        border-radius: 10px;
    }
    
    .badge {
        font-size: 0.9em;
        padding: 0.5em 0.8em;
    }
</style>

</body>
</html>