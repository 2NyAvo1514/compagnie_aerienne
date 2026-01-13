<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="pageTitle" value="Tableau de bord" />
<jsp:include page="fragments/navbar.jsp">
  <jsp:param name="menu" value="dashboard" />
</jsp:include>

<div class="row mb-4">
  <div class="col-12">
    <div class="card">
      <div class="card-body">
        <h4 class="card-title">Bienvenue dans votre espace client</h4>
        <p class="card-text">
          Gérez vos réservations, recherchez des vols et planifiez vos voyages
          en toute simplicité.
        </p>
      </div>
    </div>
  </div>
</div>

<div class="row">
  <div class="col-md-8">
    <div class="card">
      <div class="card-header">
        <h5 class="mb-0">Mes réservations récentes</h5>
      </div>
      <div class="card-body">
        <div class="alert alert-info">
          <i class="fas fa-info-circle me-2"></i>
          Vous n'avez aucune réservation récente.
          <a
            href="${pageContext.request.contextPath}/reservation/recherche"
            class="alert-link"
          >
            Cliquez ici pour réserver un vol.
          </a>
        </div>
      </div>
    </div>
  </div>

  <div class="col-md-4">
    <div class="card">
      <div class="card-header">
        <h5 class="mb-0">Actions rapides</h5>
      </div>
      <div class="card-body">
        <div class="list-group">
          <a
            href="${pageContext.request.contextPath}/reservation/recherche"
            class="list-group-item list-group-item-action"
          >
            <i class="fas fa-search me-2"></i>Rechercher un vol
          </a>
          <a
            href="${pageContext.request.contextPath}/vols/liste"
            class="list-group-item list-group-item-action"
          >
            <i class="fas fa-plane me-2"></i>Voir tous les vols
          </a>
          <a
            href="${pageContext.request.contextPath}/vols/recherche-avancee"
            class="list-group-item list-group-item-action"
          >
            <i class="fas fa-filter me-2"></i>Recherche avancée
          </a>
          <a href="#" class="list-group-item list-group-item-action">
            <i class="fas fa-user me-2"></i>Mon profil
          </a>
          <a href="#" class="list-group-item list-group-item-action">
            <i class="fas fa-question-circle me-2"></i>Aide
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<%@ include file="fragments/footer.jsp" %>
