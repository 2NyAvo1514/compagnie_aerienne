<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Tableau de bord" />

<%@ include file="fragments/header.jsp" %>

<jsp:include page="fragments/navbar.jsp">
    <jsp:param name="menu" value="dashboard"/>
</jsp:include>

<!-- Contenu principal -->
<div class="row mb-4">
    <div class="col-md-3">
        <div class="card text-center">
            <div class="card-body">
                <div class="text-primary mb-3">
                    <i class="fas fa-plane fa-3x"></i>
                </div>
                <h2 class="card-title">${prochainsVols != null ? prochainsVols.size() : 0}</h2>
                <p class="card-text text-muted">Vols aujourd'hui</p>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card text-center">
            <div class="card-body">
                <div class="text-success mb-3">
                    <i class="fas fa-users fa-3x"></i>
                </div>
                <h2 class="card-title">156</h2>
                <p class="card-text text-muted">Passagers</p>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card text-center">
            <div class="card-body">
                <div class="text-warning mb-3">
                    <i class="fas fa-percentage fa-3x"></i>
                </div>
                <h2 class="card-title">87%</h2>
                <p class="card-text text-muted">Taux d'occupation</p>
            </div>
        </div>
    </div>
    
    <div class="col-md-3">
        <div class="card text-center">
            <div class="card-body">
                <div class="text-info mb-3">
                    <i class="fas fa-clock fa-3x"></i>
                </div>
                <h2 class="card-title">95%</h2>
                <p class="card-text text-muted">Vols à l'heure</p>
            </div>
        </div>
    </div>
</div>

<div class="row">
    <div class="col-md-8">
        <div class="card">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0"><i class="fas fa-plane-departure me-2"></i>Prochains départs</h5>
                <a href="${pageContext.request.contextPath}/vols/liste" class="btn btn-sm btn-outline-primary">
                    Voir tous
                </a>
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${not empty prochainsVols}">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Vol</th>
                                        <th>Départ</th>
                                        <th>Destination</th>
                                        <th>Heure</th>
                                        <th>Disponibilité</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="vol" items="${prochainsVols}" begin="0" end="4">
                                        <tr>
                                            <td>
                                                <strong>${vol.nomAvion}</strong><br>
                                                <small class="text-muted">${vol.modeleAvion}</small>
                                            </td>
                                            <td>
                                                <strong>${vol.aeroportDepart}</strong><br>
                                                <small class="text-muted">${vol.villeDepart}</small>
                                            </td>
                                            <td>
                                                <strong>${vol.aeroportArrivee}</strong><br>
                                                <small class="text-muted">${vol.villeArrivee}</small>
                                            </td>
                                            <td>
                                                <strong>${vol.formattedTime}</strong><br>
                                                <small class="text-muted">${vol.formattedDate}</small>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${vol.placesDisponibles > 20}">
                                                        <span class="badge bg-success">${vol.placesDisponibles} places</span>
                                                    </c:when>
                                                    <c:when test="${vol.placesDisponibles > 5}">
                                                        <span class="badge bg-warning">${vol.placesDisponibles} places</span>
                                                    </c:when>
                                                    <c:when test="${vol.placesDisponibles > 0}">
                                                        <span class="badge bg-danger">${vol.placesDisponibles} places</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge bg-secondary">Complet</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:if test="${vol.placesDisponibles > 0}">
                                                    <a href="${pageContext.request.contextPath}/reservation/reserver/${vol.avionVolId}" 
                                                       class="btn btn-sm btn-primary">
                                                        Réserver
                                                    </a>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Aucun vol programmé pour aujourd'hui.
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
    
    <div class="col-md-4">
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Statistiques</h5>
            </div>
            <div class="card-body">
                <canvas id="statsChart" height="250"></canvas>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Actions rapides</h5>
            </div>
            <div class="card-body">
                <div class="d-grid gap-2">
                    <a href="${pageContext.request.contextPath}/reservation/recherche" 
                       class="btn btn-primary">
                        <i class="fas fa-search me-2"></i>Rechercher un vol
                    </a>
                    <a href="${pageContext.request.contextPath}/vols/liste" 
                       class="btn btn-outline-primary">
                        <i class="fas fa-list me-2"></i>Voir tous les vols
                    </a>
                    <a href="${pageContext.request.contextPath}/vols/recherche-avancee" 
                       class="btn btn-outline-primary">
                        <i class="fas fa-filter me-2"></i>Recherche avancée
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Script pour le graphique -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const ctx = document.getElementById('statsChart');
        if (ctx) {
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'],
                    datasets: [{
                        label: 'Vols programmés',
                        data: [12, 19, 15, 17, 22, 20, 18],
                        backgroundColor: 'rgba(13, 110, 253, 0.7)',
                        borderColor: 'rgba(13, 110, 253, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            ticks: {
                                stepSize: 5
                            }
                        }
                    }
                }
            });
        }
    });
</script>

<%@ include file="fragments/footer.jsp" %>