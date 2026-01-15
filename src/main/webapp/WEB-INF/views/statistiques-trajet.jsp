<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1 class="text-primary"><i class="fas fa-route me-2"></i>Statistiques par trajet</h1>
        <div class="d-flex gap-2">
            <a href="/statistiques/trajets/par-periode" class="btn btn-outline-primary">
                <i class="fas fa-calendar-alt me-2"></i>Filtrer par période
            </a>
            <a href="/statistiques" class="btn btn-outline-secondary">
                <i class="fas fa-arrow-left me-2"></i>Retour aux statistiques
            </a>
        </div>
    </div>
    
    <!-- Cartes de synthèse -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-center border-0 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-route fa-2x text-primary mb-3"></i>
                    <h3>${trajets.size()}</h3>
                    <p class="text-muted">Trajets différents</p>
                </div>
            </div>
        </div>
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
                    <i class="fas fa-ticket-alt fa-2x text-warning mb-3"></i>
                    <h3>${totalReservations}</h3>
                    <p class="text-muted">Réservations totales</p>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-center border-0 shadow-sm">
                <div class="card-body">
                    <i class="fas fa-users fa-2x text-info mb-3"></i>
                    <h3>${totalPlacesVendues}</h3>
                    <p class="text-muted">Passagers transportés</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Top 5 des trajets -->
    <div class="card border-0 shadow-sm mb-4">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0"><i class="fas fa-trophy me-2"></i>Top 5 des trajets les plus rentables</h4>
        </div>
        <div class="card-body">
            <div class="row">
                <c:forEach items="${topTrajets}" var="trajet" varStatus="status">
                    <div class="col-md-12 mb-3">
                        <div class="card border-0 bg-light">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-center">
                                    <div>
                                        <span class="badge bg-primary fs-6 me-3">#${status.index + 1}</span>
                                        <strong class="fs-5">${trajet.trajetComplet}</strong>
                                        <div class="text-muted small mt-1">
                                            ${trajet.aeroportsComplets} | 
                                            <fmt:formatNumber value="${trajet.chiffreAffaires}" 
                                                            type="currency" 
                                                            currencyCode="MGA"
                                                            maxFractionDigits="0" />
                                        </div>
                                    </div>
                                    <div class="text-end">
                                        <div class="text-success fw-bold">
                                            <fmt:formatNumber value="${trajet.chiffreAffaires}" 
                                                            type="currency" 
                                                            currencyCode="MGA"
                                                            maxFractionDigits="0" />
                                        </div>
                                        <div class="text-muted small">
                                            ${trajet.nombreReservations} réservations
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
    
    <!-- Tableau détaillé -->
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white border-0">
            <div class="d-flex justify-content-between align-items-center">
                <h4 class="mb-0"><i class="fas fa-list me-2 text-primary"></i>Tous les trajets</h4>
                <div class="d-flex gap-2">
                    <button class="btn btn-sm btn-outline-secondary" onclick="sortTable('trajet')">
                        <i class="fas fa-sort-alpha-down me-1"></i>Trier par trajet
                    </button>
                    <button class="btn btn-sm btn-outline-secondary" onclick="sortTable('ca')">
                        <i class="fas fa-sort-amount-down me-1"></i>Trier par CA
                    </button>
                </div>
            </div>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover" id="trajetsTable">
                    <thead class="table-light">
                        <tr>
                            <th>#</th>
                            <th>Trajet</th>
                            <th>Aéroports</th>
                            <th>Vols</th>
                            <th>Réservations</th>
                            <th>Passagers</th>
                            <th>Prix moyen</th>
                            <th>Chiffre d'affaires</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${trajets}" var="trajet" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <strong>${trajet.trajetComplet}</strong>
                                    <div class="text-muted small">ID: ${trajet.trajetId}</div>
                                </td>
                                <td>
                                    <small>${trajet.aeroportsComplets}</small>
                                </td>
                                <td>
                                    <span class="badge bg-info">${trajet.nombreVols}</span>
                                </td>
                                <td>
                                    <span class="badge bg-primary">${trajet.nombreReservations}</span>
                                </td>
                                <td>
                                    <span class="badge bg-success">${trajet.placesVendues}</span>
                                </td>
                                <td>
                                    <strong class="text-dark">
                                        <fmt:formatNumber value="${trajet.prixMoyen}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </strong>
                                </td>
                                <td>
                                    <strong class="text-success">
                                        <fmt:formatNumber value="${trajet.chiffreAffaires}" 
                                                        type="currency" 
                                                        currencyCode="MGA"
                                                        maxFractionDigits="0" />
                                    </strong>
                                    <div class="progress mt-1" style="height: 5px;">
                                        <c:if test="${chiffreAffairesTotal > 0}">
                                            <div class="progress-bar bg-success" 
                                                 style="width: ${(trajet.chiffreAffaires / chiffreAffairesTotal) * 100}%">
                                            </div>
                                        </c:if>
                                    </div>
                                </td>
                                <td>
                                    <a href="/statistiques/trajets/detail?trajetId=${trajet.trajetId}" 
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-eye me-1"></i>Détails
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                    <tfoot class="table-secondary">
                        <tr>
                            <td colspan="3" class="text-end fw-bold">TOTAUX :</td>
                            <td>
                                <c:set var="totalVols" value="0" />
                                <c:forEach items="${trajets}" var="trajet">
                                    <c:set var="totalVols" value="${totalVols + trajet.nombreVols}" />
                                </c:forEach>
                                <span class="badge bg-info">${totalVols}</span>
                            </td>
                            <td><span class="badge bg-primary">${totalReservations}</span></td>
                            <td><span class="badge bg-success">${totalPlacesVendues}</span></td>
                            <td></td>
                            <td class="fw-bold text-success">
                                <fmt:formatNumber value="${chiffreAffairesTotal}" 
                                                type="currency" 
                                                currencyCode="MGA"
                                                maxFractionDigits="0" />
                            </td>
                            <td></td>
                        </tr>
                    </tfoot>
                </table>
            </div>
        </div>
    </div>
    
    <!-- Graphique de répartition -->
    <div class="row mt-4">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fas fa-chart-pie me-2 text-primary"></i>Répartition du CA par trajet</h5>
                </div>
                <div class="card-body">
                    <div class="text-center py-4">
                        <i class="fas fa-chart-pie fa-4x text-muted mb-3"></i>
                        <p class="text-muted">Graphique de répartition du chiffre d'affaires par trajet</p>
                        <div class="mt-3">
                            <div class="row text-start">
                                <c:forEach items="${topTrajets}" var="trajet" end="2">
                                    <div class="col-12 mb-2">
                                        <div class="d-flex justify-content-between">
                                            <span>${trajet.trajetComplet}</span>
                                            <span class="fw-bold">
                                                <fmt:formatNumber value="${(trajet.chiffreAffaires / chiffreAffairesTotal) * 100}" 
                                                                maxFractionDigits="1" />%
                                            </span>
                                        </div>
                                        <div class="progress" style="height: 8px;">
                                            <div class="progress-bar bg-success" 
                                                 style="width: ${(trajet.chiffreAffaires / chiffreAffairesTotal) * 100}%">
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="card border-0 shadow-sm h-100">
                <div class="card-header bg-white border-0">
                    <h5 class="mb-0"><i class="fas fa-chart-bar me-2 text-primary"></i>Trajets les plus fréquentés</h5>
                </div>
                <div class="card-body">
                    <div class="text-center py-4">
                        <i class="fas fa-chart-bar fa-4x text-muted mb-3"></i>
                        <p class="text-muted">Nombre de vols par trajet</p>
                        <div class="mt-3">
                            <c:forEach items="${trajets}" var="trajet" end="4">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div class="text-start" style="width: 40%;">
                                        <small class="text-truncate d-block">${trajet.trajetComplet}</small>
                                    </div>
                                    <div class="flex-grow-1 px-3">
                                        <div class="progress" style="height: 20px;">
                                            <c:set var="maxVols" value="0" />
                                            <c:forEach items="${trajets}" var="t">
                                                <c:if test="${t.nombreVols > maxVols}">
                                                    <c:set var="maxVols" value="${t.nombreVols}" />
                                                </c:if>
                                            </c:forEach>
                                            <div class="progress-bar bg-info" 
                                                 style="width: ${(trajet.nombreVols / maxVols) * 100}%">
                                                ${trajet.nombreVols} vols
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
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
                    <a href="/statistiques/trajets/export/pdf" class="btn btn-outline-danger">
                        <i class="fas fa-file-pdf me-2"></i>Exporter en PDF
                    </a>
                    <a href="/statistiques/trajets/export/csv" class="btn btn-outline-secondary">
                        <i class="fas fa-file-csv me-2"></i>Exporter en CSV
                    </a>
                </div>
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
        font-size: 0.85em;
        padding: 0.4em 0.8em;
    }
    
    .table th {
        background-color: #f8f9fa;
    }
    
    .table tbody tr:hover {
        background-color: #f8f9fa;
    }
</style>

<script>
    // Tri du tableau
    let currentSort = 'ca';
    let ascending = false;
    
    function sortTable(sortBy) {
        const table = document.getElementById('trajetsTable');
        const tbody = table.querySelector('tbody');
        const rows = Array.from(tbody.querySelectorAll('tr'));
        
        if (currentSort === sortBy) {
            ascending = !ascending;
        } else {
            currentSort = sortBy;
            ascending = true;
        }
        
        rows.sort((a, b) => {
            let aValue, bValue;
            
            switch(sortBy) {
                case 'trajet':
                    aValue = a.cells[1].querySelector('strong').textContent;
                    bValue = b.cells[1].querySelector('strong').textContent;
                    return ascending ? aValue.localeCompare(bValue) : bValue.localeCompare(aValue);
                    
                case 'ca':
                    aValue = parseFloat(a.cells[7].querySelector('strong').textContent
                        .replace(/[^\d,.-]/g, '')
                        .replace(',', ''));
                    bValue = parseFloat(b.cells[7].querySelector('strong').textContent
                        .replace(/[^\d,.-]/g, '')
                        .replace(',', ''));
                    return ascending ? bValue - aValue : aValue - bValue;
                    
                default:
                    return 0;
            }
        });
        
        // Réorganiser les numéros
        rows.forEach((row, index) => {
            row.cells[0].textContent = index + 1;
            tbody.appendChild(row);
        });
        
        // Mettre à jour les boutons
        document.querySelectorAll('button[onclick^="sortTable"]').forEach(btn => {
            btn.classList.remove('btn-primary');
            btn.classList.add('btn-outline-secondary');
        });
        
        const activeBtn = document.querySelector(`button[onclick="sortTable('${sortBy}')"]`);
        activeBtn.classList.remove('btn-outline-secondary');
        activeBtn.classList.add('btn-primary');
        
        // Changer l'icône
        const icon = activeBtn.querySelector('i');
        if (ascending) {
            icon.className = icon.className.replace('down', 'up');
        } else {
            icon.className = icon.className.replace('up', 'down');
        }
    }
    
    function exportToExcel() {
        alert('Exportation vers Excel en cours...');
        // window.location.href = '/statistiques/trajets/export/excel';
    }
    
    // Recherche dans le tableau
    document.addEventListener('DOMContentLoaded', function() {
        const searchInput = document.createElement('input');
        searchInput.type = 'text';
        searchInput.className = 'form-control mb-3';
        searchInput.placeholder = 'Rechercher un trajet...';
        searchInput.style.maxWidth = '300px';
        
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('#trajetsTable tbody tr');
            
            rows.forEach(row => {
                const trajetText = row.cells[1].textContent.toLowerCase();
                const aeroportText = row.cells[2].textContent.toLowerCase();
                
                if (trajetText.includes(searchTerm) || aeroportText.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
        
        // Insérer la barre de recherche
        const tableContainer = document.querySelector('.table-responsive');
        tableContainer.parentNode.insertBefore(searchInput, tableContainer);
    });
</script>

</body>
</html>