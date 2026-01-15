<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <!-- Hero Section -->
    <div class="hero-section bg-gradient-primary text-white rounded-3 p-5 mb-5 shadow">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h1 class="display-4 fw-bold mb-3">Trouvez votre vol idéal</h1>
                <p class="lead mb-4">Réservez vos billets d'avion en toute simplicité avec Madagascar Airways. 
                Des centaines de destinations à travers le monde vous attendent.</p>
                <div class="d-flex align-items-center">
                    <i class="fas fa-shield-alt fa-2x me-3"></i>
                    <div>
                        <small class="d-block">Paiement sécurisé</small>
                        <small class="d-block">Assistance 24/7</small>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 text-center">
                <i class="fas fa-plane fa-10x opacity-75"></i>
            </div>
        </div>
    </div>

    <!-- Messages d'alerte -->
    <c:if test="${not empty success}">
        <div class="alert alert-success alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
            <i class="fas fa-check-circle me-3 fa-2x"></i>
            <div class="flex-grow-1">${success}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center shadow-sm" role="alert">
            <i class="fas fa-exclamation-triangle me-3 fa-2x"></i>
            <div class="flex-grow-1">${error}</div>
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    </c:if>

    <!-- Search Form Card -->
    <div class="card border-0 shadow-lg mb-5">
        <div class="card-header bg-white border-0 pt-4">
            <h2 class="card-title text-primary mb-0">
                <i class="fas fa-search me-2"></i>Rechercher un vol
            </h2>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/rechercher" method="get" class="needs-validation" novalidate>
                <div class="row g-4">
                    <div class="col-md-3">
                        <label class="form-label fw-bold text-secondary">
                            <i class="fas fa-plane-departure me-2"></i>Ville de départ
                        </label>
                        <select name="depart" class="form-select form-select-lg shadow-sm" >
                            <option value="" selected disabled>Choisir une ville...</option>
                            <c:forEach items="${aeroports}" var="aeroport">
                                <option value="${aeroport.id}" 
                                    <c:if test="${criteres.aeroportDepartId == aeroport.id}">selected</c:if>>
                                    ${aeroport.ville} (${aeroport.nom})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="col-md-3">
                        <label class="form-label fw-bold text-secondary">
                            <i class="fas fa-plane-arrival me-2"></i>Ville d'arrivée
                        </label>
                        <select name="arrivee" class="form-select form-select-lg shadow-sm" >
                            <option value="" selected disabled>Choisir une ville...</option>
                            <c:forEach items="${aeroports}" var="aeroport">
                                <option value="${aeroport.id}"
                                    <c:if test="${criteres.aeroportArriveeId == aeroport.id}">selected</c:if>>
                                    ${aeroport.ville} (${aeroport.nom})
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="col-md-3">
                        <label class="form-label fw-bold text-secondary">
                            <i class="fas fa-calendar-alt me-2"></i>Date de départ
                        </label>
                        <input type="date" name="date" id="dateInput" 
                               class="form-control form-control-lg shadow-sm"
                               min="<fmt:formatDate value='<%= new java.util.Date() %>' pattern='yyyy-MM-dd' />">
                    </div>
                    
                    <div class="col-md-3">
                        <label class="form-label fw-bold text-secondary">
                            <i class="fas fa-clock me-2"></i>Heure
                        </label>
                        <input type="time" name="heure" id="heureInput" 
                               class="form-control form-control-lg shadow-sm">
                    </div>
                    
                    <div class="col-12 mt-3">
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm">
                                <i class="fas fa-search me-2"></i>Rechercher
                            </button>
                            <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary btn-lg px-5">
                                <i class="fas fa-redo me-2"></i>Réinitialiser
                            </a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <!-- Results Section -->
    <c:if test="${not empty vols}">
        <div class="card border-0 shadow-sm mb-4">
            <div class="card-header bg-white border-0">
                <h3 class="card-title mb-0">
                    <i class="fas fa-plane me-2 text-primary"></i>Vols disponibles
                    <span class="badge bg-primary ms-2">${vols.size()} résultats</span>
                </h3>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="py-3">
                                    <i class="fas fa-calendar me-2"></i>Date/Heure
                                </th>
                                <th class="py-3">
                                    <i class="fas fa-plane-departure me-2"></i>Départ
                                </th>
                                <th class="py-3">
                                    <i class="fas fa-plane-arrival me-2"></i>Arrivée
                                </th>
                                <th class="py-3">
                                    <i class="fas fa-plane me-2"></i>Avion
                                </th>
                                <th class="py-3">
                                    <i class="fas fa-users me-2"></i>Capacité
                                </th>
                                <th class="py-3">
                                    <i class="fas fa-cog me-2"></i>Actions
                                </th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${vols}" var="avionVol">
                                <tr class="align-middle ${avionVol.passe ? 'table-secondary' : ''}">
                                    <td class="py-3">
                                        <div class="fw-bold">${avionVol.dateHeureFormatted}</div>
                                        <c:if test="${avionVol.passe}">
                                            <small class="text-danger">
                                                <i class="fas fa-clock me-1"></i>Vol terminé
                                            </small>
                                        </c:if>
                                    </td>
                                    <td class="py-3">
                                        <div class="fw-bold">${avionVol.vol.aeroportDepart.ville}</div>
                                        <small class="text-muted">${avionVol.vol.aeroportDepart.nom}</small>
                                    </td>
                                    <td class="py-3">
                                        <div class="fw-bold">${avionVol.vol.aeroportArrivee.ville}</div>
                                        <small class="text-muted">${avionVol.vol.aeroportArrivee.nom}</small>
                                    </td>
                                    <td class="py-3">
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-plane text-primary me-2"></i>
                                            <div>
                                                <div class="fw-bold">${avionVol.avion.nom}</div>
                                                <small class="text-muted">${avionVol.avion.modele}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="py-3">
                                        <div class="progress" style="height: 10px;">
                                            <div class="progress-bar bg-success" style="width: ${avionVol.avion.capacite}%"></div>
                                        </div>
                                        <small class="text-muted">${avionVol.avion.capacite} places</small>
                                    </td>
                                    <td class="py-3">
                                        <div class="btn-group" role="group">
                                            <c:choose>
                                                <c:when test="${avionVol.passe}">
                                                    <button class="btn btn-outline-secondary disabled">
                                                        <i class="fas fa-ban me-1"></i>Indisponible
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/reserver?id=${avionVol.id}" 
                                                       class="btn btn-success btn-sm px-3">
                                                        <i class="fas fa-ticket-alt me-1"></i>Réserver
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                            <a href="${pageContext.request.contextPath}/details?id=${avionVol.id}" 
                                               class="btn btn-outline-primary btn-sm px-3">
                                                <i class="fas fa-info-circle me-1"></i>Détails
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:if>
    
    <c:if test="${empty vols and param.depart != null}">
        <div class="card border-0 shadow-sm">
            <div class="card-body text-center py-5">
                <i class="fas fa-plane-slash fa-4x text-muted mb-4"></i>
                <h4 class="text-muted mb-3">Aucun vol trouvé</h4>
                <p class="text-muted">Essayez de modifier vos critères de recherche</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                    <i class="fas fa-redo me-2"></i>Nouvelle recherche
                </a>
            </div>
        </div>
    </c:if>

    <!-- Features Section -->
    <div class="row mt-5">
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100 text-center hover-effect">
                <div class="card-body p-4">
                    <div class="icon-wrapper bg-primary bg-opacity-10 rounded-circle p-3 d-inline-block mb-3">
                        <i class="fas fa-shield-alt fa-2x text-primary"></i>
                    </div>
                    <h5 class="card-title">Paiement sécurisé</h5>
                    <p class="card-text text-muted">Transactions cryptées SSL pour la protection de vos données.</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100 text-center hover-effect">
                <div class="card-body p-4">
                    <div class="icon-wrapper bg-success bg-opacity-10 rounded-circle p-3 d-inline-block mb-3">
                        <i class="fas fa-headset fa-2x text-success"></i>
                    </div>
                    <h5 class="card-title">Support 24/7</h5>
                    <p class="card-text text-muted">Notre équipe est disponible à tout moment pour vous aider.</p>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="card border-0 shadow-sm h-100 text-center hover-effect">
                <div class="card-body p-4">
                    <div class="icon-wrapper bg-warning bg-opacity-10 rounded-circle p-3 d-inline-block mb-3">
                        <i class="fas fa-tag fa-2x text-warning"></i>
                    </div>
                    <h5 class="card-title">Meilleur prix garanti</h5>
                    <p class="card-text text-muted">Nous garantissons les tarifs les plus bas du marché.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-white py-5 mt-5">
    <div class="container">
        <div class="row">
            <div class="col-md-4 mb-4">
                <h4 class="mb-4">Madagascar Airways</h4>
                <p>Votre compagnie aérienne de confiance. Vols sécurisés et confortables vers des destinations mondiales.</p>
                <div class="social-icons mt-3">
                    <a href="#" class="text-white me-3"><i class="fab fa-facebook fa-2x"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-twitter fa-2x"></i></a>
                    <a href="#" class="text-white me-3"><i class="fab fa-instagram fa-2x"></i></a>
                    <a href="#" class="text-white"><i class="fab fa-linkedin fa-2x"></i></a>
                </div>
            </div>
            <div class="col-md-2 mb-4">
                <h5 class="mb-4">Navigation</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-white-50 text-decoration-none">Accueil</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Vols</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Réservations</a></li>
                    <li><a href="#" class="text-white-50 text-decoration-none">Contact</a></li>
                </ul>
            </div>
            <div class="col-md-3 mb-4">
                <h5 class="mb-4">Contact</h5>
                <p><i class="fas fa-phone me-2"></i> +261 20 22 222 22</p>
                <p><i class="fas fa-envelope me-2"></i> contact@Madagascar Airways.mg</p>
                <p><i class="fas fa-map-marker-alt me-2"></i> Antananarivo 101, Madagascar</p>
            </div>
            <div class="col-md-3 mb-4">
                <h5 class="mb-4">Newsletter</h5>
                <p class="text-white-50">Inscrivez-vous pour recevoir nos offres spéciales.</p>
                <div class="input-group">
                    <input type="email" class="form-control" placeholder="Votre email">
                    <button class="btn btn-primary" type="button">S'abonner</button>
                </div>
            </div>
        </div>
        <hr class="bg-white-50">
        <div class="row mt-4">
            <div class="col-md-6">
                <p class="mb-0">&copy; 2024 Madagascar Airways. Tous droits réservés.</p>
            </div>
            <div class="col-md-6 text-md-end">
                <a href="#" class="text-white-50 text-decoration-none me-3">Mentions légales</a>
                <a href="#" class="text-white-50 text-decoration-none me-3">Politique de confidentialité</a>
                <a href="#" class="text-white-50 text-decoration-none">Conditions générales</a>
            </div>
        </div>
    </div>
</footer>

<style>
    .hero-section {
        background: linear-gradient(135deg, #0066cc 0%, #00a8ff 100%);
    }
    
    .hover-effect {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    
    .hover-effect:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.1) !important;
    }
    
    .table-hover tbody tr:hover {
        background-color: rgba(0, 102, 204, 0.05);
    }
    
    .form-select, .form-control {
        border-radius: 10px;
        border: 1px solid #e0e0e0;
    }
    
    .form-select:focus, .form-control:focus {
        border-color: #0066cc;
        box-shadow: 0 0 0 0.25rem rgba(0, 102, 204, 0.25);
    }
    
    .btn {
        border-radius: 10px;
        transition: all 0.3s ease;
    }
    
    .btn:hover {
        transform: translateY(-2px);
    }
    
    .progress {
        border-radius: 10px;
    }
    
    .social-icons a {
        transition: opacity 0.3s ease;
    }
    
    .social-icons a:hover {
        opacity: 0.8;
    }
</style>

<script>
    // Set today's date by default
    document.addEventListener('DOMContentLoaded', function() {
        const dateInput = document.getElementById('dateInput');
        const timeInput = document.getElementById('heureInput');
        
        if (dateInput && !dateInput.value) {
            const today = new Date();
            dateInput.value = today.toISOString().split('T')[0];
        }
        
        if (timeInput && !timeInput.value) {
            const now = new Date();
            const hours = String(now.getHours()).padStart(2, '0');
            const minutes = String(now.getMinutes()).padStart(2, '0');
            timeInput.value = `${hours}:${minutes}`;
        }
        
        // Form validation
        const forms = document.querySelectorAll('.needs-validation');
        Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            }, false);
        });
    });
</script>
</body>
</html>