<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <!-- Header avec filtre -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-white border-0">
            <div class="d-flex justify-content-between align-items-center">
                <h1 class="text-primary mb-0"><i class="fas fa-calendar-alt me-2"></i>Statistiques par période</h1>
                <a href="/statistiques" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Retour aux statistiques générales
                </a>
            </div>
        </div>
        <div class="card-body">
            <form action="${pageContext.request.contextPath}/statistiques/par-periode" method="get" class="row g-3">
                <div class="col-md-3">
                    <label for="dateDebut" class="form-label fw-bold">Date de début</label>
                    <input type="date" class="form-control" id="dateDebut" name="dateDebut" 
                           value="${dateDebut}" required>
                </div>
                <div class="col-md-3">
                    <label for="dateFin" class="form-label fw-bold">Date de fin</label>
                    <input type="date" class="form-control" id="dateFin" name="dateFin" 
                           value="${dateFin}" required>
                </div>
                <div class="col-md-6 d-flex align-items-end">
                    <div class="d-flex gap-2">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-filter me-2"></i>Filtrer
                        </button>
                        <button type="button" class="btn btn-outline-secondary" onclick="setDefaultPeriod('today')">
                            Aujourd'hui
                        </button>
                        <button type="button" class="btn btn-outline-secondary" onclick="setDefaultPeriod('week')">
                            Cette semaine
                        </button>
                        <button type="button" class="btn btn-outline-secondary" onclick="setDefaultPeriod('month')">
                            Ce mois
                        </button>
                    </div>
                </div>
            </form>
            
            <!-- Périodes rapides -->
            <div class="mt-3">
                <small class="text-muted">Périodes rapides : </small>
                <c:forEach var="periode" items="${periodesRapides}">
                    <a href="${pageContext.request.contextPath}/statistiques/par-periode?dateDebut=${periode.debut}&dateFin=${periode.fin}" 
                       class="btn btn-sm btn-outline-info ms-2">
                        ${periode.nom}
                    </a>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <!-- Résumé de la période -->
    <div class="row mb-4">
        <div class="col-md-12">
            <div class="card border-primary">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2"></i>Résumé de la période</h5>
                </div>
                <div class="card-body">
                    <div class="row text-center">
                        <div class="col-md-3">
                            <h3 class="text-success">
                                <fmt:formatNumber value="${chiffreAffairesTotal}" 
                                                type="currency" 
                                                currencyCode="MGA"
                                                maxFractionDigits="0" />
                            </h3>
                            <p class="text-muted mb-0">Chiffre d'affaires</p>
                        </div>
                        <div class="col-md-3">
                            <h3>${chiffreAffaires.size()}</h3>
                            <p class="text-muted mb-0">Avions actifs</p>
                        </div>
                        <div class="col-md-3">
                            <h3>${nombreReservations != null ? nombreReservations : 0}</h3>
                            <p class="text-muted mb-0">Réservations</p>
                        </div>
                        <div class="col-md-3">
                            <h3>${placesVendues != null ? placesVendues : 0}</h3>
                            <p class="text-muted mb-0">Places vendues</p>
                        </div>
                    </div>
                    <div class="mt-3 text-center">
                        <small class="text-muted">
                            Période du 
                            <fmt:parseDate value="${dateDebut}" pattern="yyyy-MM-dd" var="parsedDebut" />
                            <fmt:formatDate value="${parsedDebut}" pattern="dd/MM/yyyy" />
                            au 
                            <fmt:parseDate value="${dateFin}" pattern="yyyy-MM-dd" var="parsedFin" />
                            <fmt:formatDate value="${parsedFin}" pattern="dd/MM/yyyy" />
                        </small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Détails par avion -->
    <c:choose>
        <c:when test="${not empty chiffreAffaires}">
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-white border-0">
                    <h4 class="mb-0"><i class="fas fa-plane me-2 text-primary"></i>Détails par avion</h4>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>Avion</th>
                                    <th>Modèle</th>
                                    <th>Chiffre d'affaires</th>
                                    <th>% du total</th>
                                    <th>Performance</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach items="${chiffreAffaires}" var="ca" varStatus="status">
                                    <tr>
                                        <td>
                                            <strong>${ca.avionNom}</strong>
                                            <div class="text-muted small">ID: ${ca.avionId}</div>
                                        </td>
                                        <td>${ca.avionModele}</td>
                                        <td>
                                            <strong class="text-success">
                                                <fmt:formatNumber value="${ca.chiffreAffaires}" 
                                                                type="currency" 
                                                                currencyCode="MGA"
                                                                maxFractionDigits="0" />
                                            </strong>
                                        </td>
                                        <td>
                                            <c:if test="${chiffreAffairesTotal > 0}">
                                                <fmt:formatNumber value="${(ca.chiffreAffaires / chiffreAffairesTotal) * 100}" 
                                                                maxFractionDigits="1" />%
                                                <div class="progress mt-1" style="height: 5px;">
                                                    <div class="progress-bar bg-success" 
                                                         style="width: ${(ca.chiffreAffaires / chiffreAffairesTotal) * 100}%">
                                                    </div>
                                                </div>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${status.index < 3}">
                                                    <span class="badge bg-success">Excellent</span>
                                                </c:when>
                                                <c:when test="${status.index < chiffreAffaires.size() / 2}">
                                                    <span class="badge bg-warning">Moyen</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-danger">À améliorer</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            
            <!-- Graphique de répartition -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0">
                    <h4 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Répartition du chiffre d'affaires</h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-8">
                            <!-- Graphique (simulé) -->
                            <div class="text-center py-4 border rounded bg-light">
                                <i class="fas fa-chart-pie fa-4x text-muted mb-3"></i>
                                <h5 class="text-muted">Graphique circulaire</h5>
                                <p class="text-muted small">
                                    Répartition du CA par avion<br>
                                    ${chiffreAffaires.size()} avions
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <!-- Légende -->
                            <div class="card border-0">
                                <div class="card-body">
                                    <h6 class="mb-3">Top 3 des avions</h6>
                                    <c:forEach items="${chiffreAffaires}" var="ca" varStatus="status" end="2">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <div>
                                                <strong>${ca.avionNom}</strong>
                                                <div class="text-muted small">${ca.avionModele}</div>
                                            </div>
                                            <div class="text-end">
                                                <strong class="text-success">
                                                    <fmt:formatNumber value="${ca.chiffreAffaires}" 
                                                                    type="currency" 
                                                                    currencyCode="MGA"
                                                                    maxFractionDigits="0" />
                                                </strong>
                                                <div class="text-muted small">
                                                    <fmt:formatNumber value="${(ca.chiffreAffaires / chiffreAffairesTotal) * 100}" 
                                                                    maxFractionDigits="1" />%
                                                </div>
                                            </div>
                                        </div>
                                        <c:if test="${!status.last}"><hr class="my-2"></c:if>
                                    </c:forEach>
                                    
                                    <!-- Total autres -->
                                    <c:if test="${chiffreAffaires.size() > 3}">
                                        <hr class="my-3">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <strong>Autres avions</strong>
                                                <div class="text-muted small">${chiffreAffaires.size() - 3} avions</div>
                                            </div>
                                            <div class="text-end">
                                                <c:set var="totalAutres" value="0" />
                                                <c:forEach items="${chiffreAffaires}" var="ca" begin="3">
                                                    <c:set var="totalAutres" value="${totalAutres + ca.chiffreAffaires}" />
                                                </c:forEach>
                                                <strong class="text-secondary">
                                                    <fmt:formatNumber value="${totalAutres}" 
                                                                    type="currency" 
                                                                    currencyCode="MGA"
                                                                    maxFractionDigits="0" />
                                                </strong>
                                                <div class="text-muted small">
                                                    <fmt:formatNumber value="${(totalAutres / chiffreAffairesTotal) * 100}" 
                                                                    maxFractionDigits="1" />%
                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Tendance temporelle -->
            <div class="card border-0 shadow-sm mt-4">
                <div class="card-header bg-white border-0">
                    <h4 class="mb-0"><i class="fas fa-chart-line me-2 text-primary"></i>Tendance quotidienne</h4>
                </div>
                <div class="card-body">
                    <div class="text-center py-4 border rounded bg-light">
                        <i class="fas fa-chart-line fa-4x text-muted mb-3"></i>
                        <h5 class="text-muted">Graphique de tendance</h5>
                        <p class="text-muted small">
                            Évolution du chiffre d'affaires par jour<br>
                            Période: ${dateDebut} à ${dateFin}
                        </p>
                        <div class="mt-3">
                            <a href="#" class="btn btn-sm btn-outline-primary">
                                <i class="fas fa-download me-1"></i>Exporter les données
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Aucune donnée -->
            <div class="card border-0 shadow-sm">
                <div class="card-body text-center py-5">
                    <i class="fas fa-chart-bar fa-4x text-muted mb-4"></i>
                    <h4 class="text-muted mb-3">Aucune donnée pour cette période</h4>
                    <p class="text-muted mb-4">
                        Aucune réservation n'a été enregistrée pendant la période sélectionnée.
                    </p>
                    <div class="d-flex justify-content-center gap-3">
                        <a href="${pageContext.request.contextPath}/statistiques" class="btn btn-primary">
                            <i class="fas fa-redo me-2"></i>Voir toutes les statistiques
                        </a>
                        <button onclick="setDefaultPeriod('month')" class="btn btn-outline-secondary">
                            <i class="fas fa-calendar me-2"></i>Voir ce mois
                        </button>
                    </div>
                </div>
            </div>
        </c:otherwise>
    </c:choose>
    
    <!-- Actions -->
    <div class="mt-4">
        <div class="card border-0 shadow-sm">
            <div class="card-body">
                <h5 class="mb-3"><i class="fas fa-cogs me-2"></i>Actions</h5>
                <div class="d-flex flex-wrap gap-2">
                    <button class="btn btn-outline-primary" onclick="window.print()">
                        <i class="fas fa-print me-2"></i>Imprimer le rapport
                    </button>
                    <button class="btn btn-outline-success" onclick="exportToExcel()">
                        <i class="fas fa-file-excel me-2"></i>Exporter en Excel
                    </button>
                    <button class="btn btn-outline-info" onclick="showEmailModal()">
                        <i class="fas fa-envelope me-2"></i>Envoyer par email
                    </button>
                    <a href="${pageContext.request.contextPath}/statistiques/export/pdf?dateDebut=${dateDebut}&dateFin=${dateFin}" 
                       class="btn btn-outline-danger">
                        <i class="fas fa-file-pdf me-2"></i>Exporter en PDF
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal pour envoyer par email -->
<div class="modal fade" id="emailModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Envoyer le rapport par email</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="emailForm">
                    <div class="mb-3">
                        <label for="emailDestinataire" class="form-label">Adresse email</label>
                        <input type="email" class="form-control" id="emailDestinataire" 
                               placeholder="destinataire@example.com" required>
                    </div>
                    <div class="mb-3">
                        <label for="emailSujet" class="form-label">Sujet</label>
                        <input type="text" class="form-control" id="emailSujet" 
                               value="Rapport statistiques ${dateDebut} à ${dateFin}" required>
                    </div>
                    <div class="mb-3">
                        <label for="emailMessage" class="form-label">Message</label>
                        <textarea class="form-control" id="emailMessage" rows="3">
Rapport statistiques pour la période du ${dateDebut} au ${dateFin}.

Chiffre d'affaires total: ${chiffreAffairesTotal} Ar
Nombre d'avions actifs: ${chiffreAffaires.size()}

Veuillez trouver ci-joint le rapport détaillé.
                        </textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="sendEmailReport()">Envoyer</button>
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
        font-size: 0.8em;
        padding: 0.4em 0.8em;
    }
    
    .modal-content {
        border-radius: 10px;
    }
    
    .btn {
        border-radius: 5px;
    }
</style>

<script>
    // Fonctions pour les périodes rapides
    function setDefaultPeriod(period) {
        const today = new Date();
        let dateDebut = new Date();
        let dateFin = new Date();
        
        switch(period) {
            case 'today':
                // Aujourd'hui
                break;
            case 'week':
                // Cette semaine (lundi à dimanche)
                const day = today.getDay();
                const diff = today.getDate() - day + (day === 0 ? -6 : 1); // Lundi
                dateDebut = new Date(today.setDate(diff));
                dateFin = new Date(dateDebut);
                dateFin.setDate(dateFin.getDate() + 6);
                break;
            case 'month':
                // Ce mois
                dateDebut = new Date(today.getFullYear(), today.getMonth(), 1);
                dateFin = new Date(today.getFullYear(), today.getMonth() + 1, 0);
                break;
            case 'year':
                // Cette année
                dateDebut = new Date(today.getFullYear(), 0, 1);
                dateFin = new Date(today.getFullYear(), 11, 31);
                break;
        }
        
        // Formater les dates au format YYYY-MM-DD
        function formatDate(date) {
            const yyyy = date.getFullYear();
            const mm = String(date.getMonth() + 1).padStart(2, '0');
            const dd = String(date.getDate()).padStart(2, '0');
            return yyyy + '-' + mm + '-' + dd;
        }
        
        // Mettre à jour les champs de formulaire
        document.getElementById('dateDebut').value = formatDate(dateDebut);
        document.getElementById('dateFin').value = formatDate(dateFin);
        
        // Soumettre automatiquement le formulaire
        document.querySelector('form').submit();
    }
    
    // Validation des dates
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        form.addEventListener('submit', function(e) {
            const dateDebut = new Date(document.getElementById('dateDebut').value);
            const dateFin = new Date(document.getElementById('dateFin').value);
            
            if (dateDebut > dateFin) {
                e.preventDefault();
                alert('La date de début doit être antérieure à la date de fin.');
                return false;
            }
            
            // Limiter à 1 an maximum
            const diffTime = Math.abs(dateFin - dateDebut);
            const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
            
            if (diffDays > 365) {
                e.preventDefault();
                alert('La période ne peut pas dépasser 365 jours.');
                return false;
            }
        });
        
        // Initialiser la date de fin à aujourd'hui si vide
        const dateFinInput = document.getElementById('dateFin');
        if (!dateFinInput.value) {
            const today = new Date();
            const yyyy = today.getFullYear();
            const mm = String(today.getMonth() + 1).padStart(2, '0');
            const dd = String(today.getDate()).padStart(2, '0');
            dateFinInput.value = yyyy + '-' + mm + '-' + dd;
        }
        
        // Initialiser la date de début à 30 jours avant si vide
        const dateDebutInput = document.getElementById('dateDebut');
        if (!dateDebutInput.value) {
            const today = new Date();
            const thirtyDaysAgo = new Date(today);
            thirtyDaysAgo.setDate(today.getDate() - 30);
            const yyyy = thirtyDaysAgo.getFullYear();
            const mm = String(thirtyDaysAgo.getMonth() + 1).padStart(2, '0');
            const dd = String(thirtyDaysAgo.getDate()).padStart(2, '0');
            dateDebutInput.value = yyyy + '-' + mm + '-' + dd;
        }
    });
    
    // Fonctions pour les actions
    function showEmailModal() {
        const modal = new bootstrap.Modal(document.getElementById('emailModal'));
        modal.show();
    }
    
    function sendEmailReport() {
        const email = document.getElementById('emailDestinataire').value;
        const sujet = document.getElementById('emailSujet').value;
        const message = document.getElementById('emailMessage').value;
        
        // Simulation d'envoi d'email
        alert(`Rapport envoyé à ${email}\nSujet: ${sujet}`);
        
        // Fermer le modal
        const modal = bootstrap.Modal.getInstance(document.getElementById('emailModal'));
        modal.hide();
    }
    
    function exportToExcel() {
        // Simulation d'export Excel
        alert('Exportation vers Excel en cours...\nLe fichier sera téléchargé automatiquement.');
        
        // En production, rediriger vers une URL qui génère le fichier Excel
        // window.location.href = '/statistiques/export/excel?dateDebut=${dateDebut}&dateFin=${dateFin}';
    }
</script>

</body>
</html>