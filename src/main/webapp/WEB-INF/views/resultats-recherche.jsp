<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Résultats de recherche" />
<jsp:include page="fragments/navbar.jsp">
    <jsp:param name="menu" value="recherche"/>
</jsp:include>

<div class="row mb-4">
    <div class="col-12">
        <div class="card">
            <div class="card-header bg-info text-white">
                <h4 class="mb-0">
                    <i class="fas fa-plane me-2"></i>
                    Résultats pour : ${recherche.aeroportDepart} → ${recherche.aeroportArrivee}
                </h4>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-8">
                        <p class="mb-0">
                            <i class="fas fa-calendar-alt me-2"></i>
                            Date : ${recherche.date} à ${recherche.heure}h
                        </p>
                    </div>
                    <div class="col-md-4 text-end">
                        <a href="${pageContext.request.contextPath}/reservation/recherche" 
                           class="btn btn-outline-primary">
                            <i class="fas fa-redo me-2"></i>Nouvelle recherche
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${empty resultats}">
    <div class="alert alert-warning">
        <i class="fas fa-exclamation-triangle me-2"></i>
        Aucun vol trouvé pour cette recherche. Essayez avec d'autres critères.
    </div>
</c:if>

<c:forEach var="vol" items="${resultats}">
    <div class="card mb-3">
        <div class="card-body">
            <div class="row align-items-center">
                <div class="col-md-3">
                    <div class="text-center">
                        <h5 class="text-primary">
                            ${vol.formattedTime}
                        </h5>
                        <small class="text-muted">
                            ${vol.formattedDate}
                        </small>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="flight-info">
                        <h6>${vol.aeroportDepart}</h6>
                        <p class="text-muted small mb-0">${vol.villeDepart}</p>
                    </div>
                    <div class="text-center my-2">
                        <i class="fas fa-long-arrow-alt-right text-muted"></i>
                    </div>
                    <div class="flight-info">
                        <h6>${vol.aeroportArrivee}</h6>
                        <p class="text-muted small mb-0">${vol.villeArrivee}</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <h6>${vol.nomAvion}</h6>
                        <p class="text-muted small">${vol.modeleAvion}</p>
                        <p class="mb-0">
                            <span class="badge bg-secondary">${vol.capacite} places</span>
                        </p>
                    </div>
                </div>
                <div class="col-md-2">
                    <div class="text-center">
                        <c:choose>
                            <c:when test="${vol.placesDisponibles > 0}">
                                <h5 class="text-success">${vol.placesDisponibles}</h5>
                                <p class="small text-muted mb-2">places disponibles</p>
                                <a href="${pageContext.request.contextPath}/reservation/reserver/${vol.avionVolId}" 
                                   class="btn btn-primary btn-sm">
                                    Réserver
                                </a>
                            </c:when>
                            <c:otherwise>
                                <h5 class="text-danger">0</h5>
                                <p class="small text-muted mb-2">places disponibles</p>
                                <button class="btn btn-secondary btn-sm" disabled>
                                    Complet
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>
</c:forEach>

<%@ include file="fragments/footer.jsp" %>