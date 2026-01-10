<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Recherche Avancée" />

<%@ include file="fragments/header.jsp" %>

<jsp:include page="fragments/navbar.jsp">
    <jsp:param name="menu" value="recherche-avancee"/>
</jsp:include>

<div class="row">
    <div class="col-lg-8 mx-auto">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h5 class="mb-0"><i class="fas fa-search-plus me-2"></i>Recherche avancée de vols</h5>
            </div>
            <div class="card-body">
                <form action="${pageContext.request.contextPath}/vols/liste" method="get">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Aéroport de départ</label>
                                <select name="aeroportDepartId" class="form-select">
                                    <option value="">Sélectionnez un aéroport</option>
                                    <c:forEach var="aeroport" items="${aeroports}">
                                        <option value="${aeroport.id}">
                                            ${aeroport.nom} (${aeroport.ville})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Aéroport d'arrivée</label>
                                <select name="aeroportArriveeId" class="form-select">
                                    <option value="">Sélectionnez un aéroport</option>
                                    <c:forEach var="aeroport" items="${aeroports}">
                                        <option value="${aeroport.id}">
                                            ${aeroport.nom} (${aeroport.ville})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Date de départ</label>
                                <input type="date" name="date" class="form-control" 
                                       value="${filtre.date != null ? filtre.date : ''}">
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Plage horaire</label>
                                <div class="row g-2">
                                    <div class="col">
                                        <input type="time" name="heureMin" class="form-control" placeholder="De">
                                    </div>
                                    <div class="col">
                                        <input type="time" name="heureMax" class="form-control" placeholder="À">
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Places minimum</label>
                                <input type="number" name="placesMin" class="form-control" min="1" value="1">
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Type d'avion</label>
                                <input type="text" name="typeAvion" class="form-control" placeholder="A320, B737...">
                            </div>
                        </div>
                        
                        <div class="col-md-4">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Classe</label>
                                <select name="classe" class="form-select">
                                    <option value="">Toutes classes</option>
                                    <option value="economy">Économique</option>
                                    <option value="business">Affaires</option>
                                    <option value="first">Première</option>
                                </select>
                            </div>
                        </div>
                        
                        <div class="col-12">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                Laissez les champs vides pour ignorer certains critères de recherche.
                            </div>
                            
                            <div class="d-flex justify-content-between">
                                <a href="${pageContext.request.contextPath}/vols/liste" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Retour à la liste
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Lancer la recherche
                                </button>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        
        <div class="card mt-4">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Conseils de recherche</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="text-center p-3">
                            <div class="text-primary mb-3">
                                <i class="fas fa-calendar-alt fa-2x"></i>
                            </div>
                            <h6>Planifiez à l'avance</h6>
                            <p class="small text-muted">
                                Réservez vos vols plusieurs jours à l'avance pour obtenir les meilleurs tarifs.
                            </p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-center p-3">
                            <div class="text-primary mb-3">
                                <i class="fas fa-clock fa-2x"></i>
                            </div>
                            <h6>Horaires flexibles</h6>
                            <p class="small text-muted">
                                Les vols tôt le matin ou tard le soir sont souvent moins chers.
                            </p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-center p-3">
                            <div class="text-primary mb-3">
                                <i class="fas fa-filter fa-2x"></i>
                            </div>
                            <h6>Filtres précis</h6>
                            <p class="small text-muted">
                                Utilisez les filtres avancés pour trouver exactement ce que vous cherchez.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Définir la date d'aujourd'hui comme placeholder
        const today = new Date().toISOString().split('T')[0];
        const dateInput = document.querySelector('input[name="date"]');
        if (dateInput && !dateInput.value) {
            dateInput.placeholder = today;
        }
        
        // Validation des heures
        const heureMinInput = document.querySelector('input[name="heureMin"]');
        const heureMaxInput = document.querySelector('input[name="heureMax"]');
        
        if (heureMinInput && heureMaxInput) {
            heureMinInput.addEventListener('change', function() {
                if (heureMaxInput.value && this.value > heureMaxInput.value) {
                    alert("L'heure de début doit être avant l'heure de fin");
                    this.value = '';
                }
            });
            
            heureMaxInput.addEventListener('change', function() {
                if (heureMinInput.value && this.value < heureMinInput.value) {
                    alert("L'heure de fin doit être après l'heure de début");
                    this.value = '';
                }
            });
        }
    });
</script>

<%@ include file="fragments/footer.jsp" %>