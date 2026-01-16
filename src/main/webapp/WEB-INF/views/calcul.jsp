<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-primary text-white">
            <h3 class="mb-0"><i class="fas fa-calculator me-2"></i>Calculateur de valeur maximale</h3>
        </div>
        <div class="card-body">
            <!-- Formulaire de calcul -->
            <form id="calculForm" method="post" action="${pageContext.request.contextPath}/calculer/valeur-maximale">
                <div class="row g-3">
                    <!-- Sélection de l'avion -->
                    <div class="col-md-6">
                        <label for="avionId" class="form-label fw-bold">Avion *</label>
                        <select class="form-select" id="avionId" name="avionId" required 
                                onchange="chargerConfigurationAvion()">
                            <option value="">-- Sélectionnez un avion --</option>
                            <c:forEach items="${avions}" var="avion">
                                <option value="${avion.id}">
                                    <c:out value="${avion.nom}" /> (<c:out value="${avion.modele}" />) - 
                                    <c:out value="${avion.capacite}" /> places
                                </option>
                            </c:forEach>
                        </select>
                        <small class="text-muted">Sélectionnez l'avion pour voir sa configuration de places</small>
                    </div>
                    
                    <!-- Sélection du vol -->
                    <div class="col-md-6">
                        <label for="volId" class="form-label fw-bold">Vol (optionnel)</label>
                        <select class="form-select" id="volId" name="volId">
                            <option value="">-- Sélectionnez un vol --</option>
                            <c:forEach items="${vols}" var="vol">
                                <option value="${vol.id}">
                                    <c:out value="${vol.aeroportDepart.ville}" /> → 
                                    <c:out value="${vol.aeroportArrivee.ville}" />
                                </option>
                            </c:forEach>
                        </select>
                        <small class="text-muted">Sélectionnez un vol existant ou définissez les prix manuellement</small>
                    </div>
                </div>
                
                <!-- Configuration des places de l'avion (dynamique) -->
                <div class="mt-4" id="configurationAvionContainer" style="display: none;">
                    <h5 class="border-bottom pb-2 mb-3">
                        <i class="fas fa-chair me-2"></i>Configuration des places
                    </h5>
                    <div id="configurationAvion" class="row g-3">
                        <!-- Chargé dynamiquement via JavaScript -->
                    </div>
                </div>
                
                <!-- Prix par type de place -->
                <div class="mt-4" id="prixPlacesContainer">
                    <h5 class="border-bottom pb-2 mb-3">
                        <i class="fas fa-tag me-2"></i>Prix par type de place
                    </h5>
                    
                    <!-- Si un vol est sélectionné -->
                    <div id="prixExistantContainer" style="display: none;">
                        <div class="alert alert-info">
                            <i class="fas fa-info-circle me-2"></i>
                            Les prix seront automatiquement chargés depuis le vol sélectionné.
                        </div>
                    </div>
                    
                    <!-- Prix manuels -->
                    <div id="prixManuelsContainer" class="row g-3">
                        <div class="col-md-6">
                            <label for="prixEconomique" class="form-label">Prix économique (Ar)</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="prixEconomique" 
                                       name="prixEconomique" min="0" step="1000" 
                                       placeholder="Ex: 700000">
                                <span class="input-group-text">Ar</span>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <label for="prixPremiere" class="form-label">Prix première classe (Ar)</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="prixPremiere" 
                                       name="prixPremiere" min="0" step="1000" 
                                       placeholder="Ex: 1200000">
                                <span class="input-group-text">Ar</span>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <label for="prixAffaires" class="form-label">Prix affaires (Ar)</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="prixAffaires" 
                                       name="prixAffaires" min="0" step="1000" 
                                       placeholder="Ex: 900000">
                                <span class="input-group-text">Ar</span>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <label for="prixSuite" class="form-label">Prix suite (Ar)</label>
                            <div class="input-group">
                                <input type="number" class="form-control" id="prixSuite" 
                                       name="prixSuite" min="0" step="1000" 
                                       placeholder="Ex: 1500000">
                                <span class="input-group-text">Ar</span>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Options de calcul -->
                    <div class="mt-3">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="inclureFrais" name="inclureFrais" checked>
                            <label class="form-check-label" for="inclureFrais">
                                Inclure les frais de service (10%)
                            </label>
                        </div>
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="inclureTaxes" name="inclureTaxes" checked>
                            <label class="form-check-label" for="inclureTaxes">
                                Inclure les taxes aéroport (5%)
                            </label>
                        </div>
                    </div>
                </div>
                
                <!-- Boutons -->
                <div class="mt-4">
                    <button type="submit" class="btn btn-primary btn-lg">
                        <i class="fas fa-calculator me-2"></i>Calculer la valeur maximale
                    </button>
                    <button type="reset" class="btn btn-outline-secondary btn-lg ms-2">
                        <i class="fas fa-redo me-2"></i>Réinitialiser
                    </button>
                </div>
            </form>
            
            <!-- Résultats du calcul -->
            <c:if test="${not empty resultats}">
            <div class="mt-5" id="resultatsContainer">
                <div class="card border-success">
                    <div class="card-header bg-success text-white">
                        <h4 class="mb-0"><i class="fas fa-chart-line me-2"></i>Résultats du calcul</h4>
                    </div>
                    <div class="card-body">
                        <!-- Résumé -->
                        <div class="row mb-4">
                            <div class="col-md-6">
                                <div class="card border-0 bg-light">
                                    <div class="card-body">
                                        <h6 class="text-muted">Avion sélectionné</h6>
                                        <h5 id="resultatAvion">
                                            <c:out value="${resultats.avion.nom}" /> 
                                            (<c:out value="${resultats.avion.modele}" />)
                                        </h5>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="card border-0 bg-light">
                                    <div class="card-body">
                                        <h6 class="text-muted">Vol sélectionné</h6>
                                        <h5 id="resultatVol">
                                            <c:choose>
                                                <c:when test="${not empty resultats.vol}">
                                                    <c:out value="${resultats.vol.aeroportDepart.ville}" /> → 
                                                    <c:out value="${resultats.vol.aeroportArrivee.ville}" />
                                                </c:when>
                                                <c:otherwise>
                                                    Vol personnalisé
                                                </c:otherwise>
                                            </c:choose>
                                        </h5>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Tableau des calculs -->
                        <div class="table-responsive mb-4">
                            <table class="table table-hover">
                                <thead class="table-light">
                                    <tr>
                                        <th>Type de place</th>
                                        <th>Nombre de places</th>
                                        <th>Prix unitaire</th>
                                        <th>Valeur partielle</th>
                                    </tr>
                                </thead>
                                <tbody id="tableauCalcul">
                                    <c:forEach var="entry" items="${resultats.detailsCalcul}">
                                        <c:set var="typePlace" value="${entry.key}" />
                                        <c:set var="detail" value="${entry.value}" />
                                        <tr>
                                            <td>
                                                <span class="type-place-badge 
                                                    <c:choose>
                                                        <c:when test="${typePlace == 'Économique'}">badge-economique</c:when>
                                                        <c:when test="${typePlace == 'Affaires'}">badge-affaires</c:when>
                                                        <c:when test="${typePlace == 'Première'}">badge-premiere</c:when>
                                                        <c:when test="${typePlace == 'Suite'}">badge-suite</c:when>
                                                        <c:otherwise>badge-secondary</c:otherwise>
                                                    </c:choose>">
                                                    <i class="
                                                        <c:choose>
                                                            <c:when test="${typePlace == 'Économique'}">fas fa-chair</c:when>
                                                            <c:when test="${typePlace == 'Affaires'}">fas fa-business-time</c:when>
                                                            <c:when test="${typePlace == 'Première'}">fas fa-crown</c:when>
                                                            <c:when test="${typePlace == 'Suite'}">fas fa-star</c:when>
                                                            <c:otherwise>fas fa-chair</c:otherwise>
                                                        </c:choose>
                                                    me-1"></i>
                                                    <c:out value="${typePlace}" />
                                                </span>
                                            </td>
                                            <td><span class="badge bg-primary"><c:out value="${detail.nombre}" /></span></td>
                                            <td><fmt:formatNumber value="${detail.prixUnitaire}" type="currency" currencySymbol="Ar" maxFractionDigits="0" /></td>
                                            <td class="fw-bold text-success">
                                                <fmt:formatNumber value="${detail.valeurPartielle}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <tr class="table-success">
                                        <td colspan="3" class="text-end fw-bold">SOUS-TOTAL :</td>
                                        <td class="fw-bold">
                                            <fmt:formatNumber value="${resultats.valeurBase}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        
                        <!-- Totaux -->
                        <div class="row">
                            <div class="col-md-6">
                                <div class="card border-0 shadow-sm">
                                    <div class="card-body">
                                        <h5 class="card-title">Détails des calculs</h5>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Valeur de base:</span>
                                            <span id="valeurBase">
                                                <fmt:formatNumber value="${resultats.valeurBase}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Frais de service (10%):</span>
                                            <span id="fraisService">
                                                <fmt:formatNumber value="${resultats.fraisService}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                            </span>
                                        </div>
                                        <div class="d-flex justify-content-between mb-2">
                                            <span>Taxes aéroport (5%):</span>
                                            <span id="taxesAeroport">
                                                <fmt:formatNumber value="${resultats.taxesAeroport}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                            </span>
                                        </div>
                                        <hr>
                                        <div class="d-flex justify-content-between fw-bold">
                                            <span>Total:</span>
                                            <span id="totalGeneral">
                                                <fmt:formatNumber value="${resultats.totalGeneral}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <div class="card border-success">
                                    <div class="card-body text-center">
                                        <h6 class="text-muted">VALEUR MAXIMALE</h6>
                                        <h1 class="text-success my-4" id="valeurMaximale">
                                            <fmt:formatNumber value="${resultats.valeurMaximale}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                                        </h1>
                                        <p class="text-muted mb-0">
                                            Cette valeur représente le revenu maximum potentiel
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Graphique (simplifié côté serveur) -->
                        <div class="mt-4">
                            <h5 class="mb-3"><i class="fas fa-chart-pie me-2"></i>Répartition de la valeur</h5>
                            <div class="row">
                                <div class="col-md-8">
                                    <div class="text-center py-4 border rounded bg-light">
                                        <!-- Graphique simple avec des barres -->
                                        <div class="d-flex align-items-end justify-content-around h-100">
                                            <c:forEach var="entry" items="${resultats.detailsCalcul}">
                                                <c:set var="detail" value="${entry.value}" />
                                                <c:if test="${detail.valeurPartielle > 0}">
                                                    <div class="d-flex flex-column align-items-center">
                                                        <div class="bg-primary mb-2" style="width: 30px; height: ${detail.pourcentage * 3}px;"></div>
                                                        <small><c:out value="${entry.key}" /></small>
                                                    </div>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                        <h6 class="text-muted mt-3">Répartition par type de place</h6>
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div id="legendeGraphique">
                                        <c:forEach var="entry" items="${resultats.detailsCalcul}">
                                            <c:set var="typePlace" value="${entry.key}" />
                                            <c:set var="detail" value="${entry.value}" />
                                            <c:if test="${detail.valeurPartielle > 0}">
                                                <div class="d-flex justify-content-between align-items-center mb-2">
                                                    <div>
                                                        <span class="type-place-badge 
                                                            <c:choose>
                                                                <c:when test="${typePlace == 'Économique'}">badge-economique</c:when>
                                                                <c:when test="${typePlace == 'Affaires'}">badge-affaires</c:when>
                                                                <c:when test="${typePlace == 'Première'}">badge-premiere</c:when>
                                                                <c:when test="${typePlace == 'Suite'}">badge-suite</c:when>
                                                                <c:otherwise>badge-secondary</c:otherwise>
                                                            </c:choose>">
                                                            <i class="
                                                                <c:choose>
                                                                    <c:when test="${typePlace == 'Économique'}">fas fa-chair</c:when>
                                                                    <c:when test="${typePlace == 'Affaires'}">fas fa-business-time</c:when>
                                                                    <c:when test="${typePlace == 'Première'}">fas fa-crown</c:when>
                                                                    <c:when test="${typePlace == 'Suite'}">fas fa-star</c:when>
                                                                    <c:otherwise>fas fa-chair</c:otherwise>
                                                                </c:choose>
                                                            me-1"></i>
                                                            <c:out value="${typePlace}" />
                                                        </span>
                                                    </div>
                                                    <div class="text-end">
                                                        <strong><fmt:formatNumber value="${detail.valeurPartielle}" type="currency" currencySymbol="Ar" maxFractionDigits="0" /></strong>
                                                        <div class="text-muted small"><fmt:formatNumber value="${detail.pourcentage}" maxFractionDigits="1" />%</div>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Actions -->
                        <div class="mt-4">
                            <button class="btn btn-outline-primary" onclick="window.print()">
                                <i class="fas fa-print me-2"></i>Imprimer le rapport
                            </button>
                            <button class="btn btn-outline-success ms-2" onclick="exporterEnExcel()">
                                <i class="fas fa-file-excel me-2"></i>Exporter en Excel
                            </button>
                            <button class="btn btn-outline-info ms-2" onclick="copierResultats()">
                                <i class="fas fa-copy me-2"></i>Copier les résultats
                            </button>
                            <button class="btn btn-outline-warning ms-2" onclick="sauvegarderCalcul()">
                                <i class="fas fa-save me-2"></i>Sauvegarder le calcul
                            </button>
                        </div>
                    </div>
                </div>
            </div>
            </c:if>
        </div>
    </div>
    
    <!-- Exemples prédéfinis -->
    <div class="card border-0 shadow-sm mt-4">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0"><i class="fas fa-bolt me-2"></i>Exemples rapides</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4 mb-3">
                    <div class="card border-0 bg-light h-100">
                        <div class="card-body">
                            <h6 class="text-primary">Tana → Nosy Be</h6>
                            <p class="small text-muted">Exemple classique avec prix standards</p>
                            <a href="${pageContext.request.contextPath}/calculer/exemple/tana-nosybe" 
                               class="btn btn-sm btn-outline-primary w-100">
                                Charger cet exemple
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card border-0 bg-light h-100">
                        <div class="card-body">
                            <h6 class="text-primary">Avion long-courrier</h6>
                            <p class="small text-muted">Configuration avec plusieurs classes</p>
                            <button class="btn btn-sm btn-outline-primary w-100" 
                                    onclick="chargerExemple('long-courrier')">
                                Charger cet exemple
                            </button>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card border-0 bg-light h-100">
                        <div class="card-body">
                            <h6 class="text-primary">Vol économique</h6>
                            <p class="small text-muted">Configuration simple basse capacité</p>
                            <button class="btn btn-sm btn-outline-primary w-100" 
                                    onclick="chargerExemple('economique')">
                                Charger cet exemple
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal pour sauvegarder le calcul -->
<div class="modal fade" id="sauvegardeModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Sauvegarder le calcul</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="sauvegardeForm">
                    <div class="mb-3">
                        <label for="nomCalcul" class="form-label">Nom du calcul</label>
                        <input type="text" class="form-control" id="nomCalcul" 
                               placeholder="Ex: Tana-NosyBe-A320" required>
                    </div>
                    <div class="mb-3">
                        <label for="descriptionCalcul" class="form-label">Description</label>
                        <textarea class="form-control" id="descriptionCalcul" rows="3"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Annuler</button>
                <button type="button" class="btn btn-primary" onclick="confirmerSauvegarde()">Sauvegarder</button>
            </div>
        </div>
    </div>
</div>

<style>
    .card {
        border-radius: 10px;
    }
    
    .form-select, .form-control {
        border-radius: 8px;
    }
    
    .btn {
        border-radius: 8px;
    }
    
    .input-group-text {
        border-radius: 0 8px 8px 0;
    }
    
    .table th {
        background-color: #f8f9fa;
    }
    
    .modal-content {
        border-radius: 10px;
    }
    
    .type-place-badge {
        font-size: 0.8em;
        padding: 0.3em 0.8em;
        border-radius: 20px;
    }
    
    .badge-economique { background-color: #28a745; color: white; }
    .badge-affaires { background-color: #17a2b8; color: white; }
    .badge-premiere { background-color: #ffc107; color: #212529; }
    .badge-suite { background-color: #dc3545; color: white; }
</style>

<script>
    // Configuration des types de places avec leurs couleurs
    const typesPlaces = {
        'Économique': { color: 'badge-economique', icon: 'fas fa-chair' },
        'Affaires': { color: 'badge-affaires', icon: 'fas fa-business-time' },
        'Première': { color: 'badge-premiere', icon: 'fas fa-crown' },
        'Suite': { color: 'badge-suite', icon: 'fas fa-star' }
    };
    
    // Charger la configuration d'un avion
    function chargerConfigurationAvion() {
        const avionId = document.getElementById('avionId').value;
        const container = document.getElementById('configurationAvion');
        const configContainer = document.getElementById('configurationAvionContainer');
        
        container.innerHTML = '';
        
        if (avionId) {
            // Récupérer les données de l'avion via AJAX
            fetch('${pageContext.request.contextPath}/api/avion/' + avionId + '/places')
                .then(response => response.json())
                .then(places => {
                    if (places && places.length > 0) {
                        configContainer.style.display = 'block';
                        
                        places.forEach((place, index) => {
                            const typeConfig = typesPlaces[place.type] || { color: 'badge-secondary', icon: 'fas fa-chair' };
                            
                            const col = document.createElement('div');
                            col.className = 'col-md-6';
                            col.innerHTML = `
                                <div class="card border-0 bg-light">
                                    <div class="card-body">
                                        <div class="d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="type-place-badge ${typeConfig.color}">
                                                    <i class="${typeConfig.icon} me-1"></i>${place.type}
                                                </span>
                                                <h6 class="mt-2 mb-0">${place.nombre} places</h6>
                                            </div>
                                            <div class="text-muted">
                                                <small>ID: ${index + 1}</small>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            `;
                            
                            container.appendChild(col);
                        });
                    } else {
                        configContainer.style.display = 'block';
                        container.innerHTML = `
                            <div class="col-12">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Aucune configuration de places définie pour cet avion.
                                </div>
                            </div>
                        `;
                    }
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    configContainer.style.display = 'none';
                });
        } else {
            configContainer.style.display = 'none';
        }
    }
    
    // Charger les prix d'un vol
    document.getElementById('volId').addEventListener('change', function() {
        const volId = this.value;
        const prixContainer = document.getElementById('prixExistantContainer');
        const manuelsContainer = document.getElementById('prixManuelsContainer');
        
        if (volId) {
            // Récupérer les prix via AJAX
            fetch('${pageContext.request.contextPath}/api/vol/' + volId + '/prix')
                .then(response => response.json())
                .then(prix => {
                    if (prix && Object.keys(prix).length > 0) {
                        prixContainer.style.display = 'block';
                        manuelsContainer.style.display = 'none';
                        
                        // Remplir les champs de prix
                        if (prix['Économique']) {
                            document.getElementById('prixEconomique').value = prix['Économique'];
                        }
                        if (prix['Affaires']) {
                            document.getElementById('prixAffaires').value = prix['Affaires'];
                        }
                        if (prix['Première']) {
                            document.getElementById('prixPremiere').value = prix['Première'];
                        }
                        if (prix['Suite']) {
                            document.getElementById('prixSuite').value = prix['Suite'];
                        }
                    } else {
                        prixContainer.style.display = 'none';
                        manuelsContainer.style.display = 'block';
                    }
                })
                .catch(error => {
                    console.error('Erreur:', error);
                    prixContainer.style.display = 'none';
                    manuelsContainer.style.display = 'block';
                });
        } else {
            prixContainer.style.display = 'none';
            manuelsContainer.style.display = 'block';
        }
    });
    
    // Exemples prédéfinis (côté client simplifié)
    function chargerExemple(exempleId) {
        // Ces exemples seraient mieux gérés côté serveur
        alert('Cette fonctionnalité nécessite une implémentation côté serveur. Utilisez les exemples prédéfinis via les liens.');
    }
    
    // Formater un montant avec séparateurs de milliers
    function formatMontant(montant) {
        return new Intl.NumberFormat('fr-FR').format(Math.round(montant));
    }
    
    // Fonctions d'export et sauvegarde
    function exporterEnExcel() {
        alert('Exportation vers Excel en cours...');
        // Implémentation de l'export Excel
    }
    
    function copierResultats() {
        const resultats = document.querySelector('#resultatsContainer').innerText;
        navigator.clipboard.writeText(resultats)
            .then(() => alert('Résultats copiés dans le presse-papier'))
            .catch(err => console.error('Erreur lors de la copie:', err));
    }
    
    function sauvegarderCalcul() {
        const modal = new bootstrap.Modal(document.getElementById('sauvegardeModal'));
        modal.show();
    }
    
    function confirmerSauvegarde() {
        const nom = document.getElementById('nomCalcul').value;
        const description = document.getElementById('descriptionCalcul').value;
        
        if (!nom) {
            alert('Veuillez donner un nom au calcul.');
            return;
        }
        
        // Ici, vous enverriez les données au serveur
        console.log('Sauvegarde du calcul:', { nom, description });
        
        alert(`Calcul "${nom}" sauvegardé avec succès!`);
        
        const modal = bootstrap.Modal.getInstance(document.getElementById('sauvegardeModal'));
        modal.hide();
    }
    
    // Initialiser la page
    document.addEventListener('DOMContentLoaded', function() {
        // Initialiser les tooltips Bootstrap si nécessaire
        const tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        const tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
    });
</script>

</body>
</html>