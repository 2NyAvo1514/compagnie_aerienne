<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="navbar.jsp" />

<div class="container mt-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb bg-light p-3 rounded shadow-sm">
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/" class="text-decoration-none text-primary">
                    <i class="fas fa-home me-1"></i>Accueil
                </a>
            </li>
            <li class="breadcrumb-item">
                <a href="${pageContext.request.contextPath}/details?id=${vol.id}" class="text-decoration-none text-primary">
                    <i class="fas fa-info-circle me-1"></i>Détails
                </a>
            </li>
            <li class="breadcrumb-item active" aria-current="page">
                <i class="fas fa-ticket-alt me-1"></i>Réservation
            </li>
        </ol>
    </nav>
    
    <div class="row">
        <div class="col-lg-8">
            <!-- Flight Summary Card -->
            <div class="card border-0 shadow-sm mb-4">
                <div class="card-header bg-primary text-white border-0">
                    <h4 class="mb-0">
                        <i class="fas fa-plane me-2"></i>Résumé du vol
                    </h4>
                </div>
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="flight-info p-3 bg-light rounded">
                                <h6 class="text-primary mb-3">
                                    <i class="fas fa-plane-departure me-2"></i>Départ
                                </h6>
                                <div class="d-flex align-items-center mb-2">
                                    <div class="flight-icon">
                                        <i class="fas fa-calendar-alt text-primary me-3"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Date & Heure</small>
                                        <strong class="fs-5">
                                            <fmt:parseDate value="${vol.dateHeure}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" />
                                            <fmt:formatDate value="${parsedDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                        </strong>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-2">
                                    <div class="flight-icon">
                                        <i class="fas fa-map-marker-alt text-primary me-3"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Aéroport</small>
                                        <strong>${vol.vol.aeroportDepart.ville}</strong>
                                        <div class="text-muted small">${vol.vol.aeroportDepart.nom}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="flight-info p-3 bg-light rounded">
                                <h6 class="text-success mb-3">
                                    <i class="fas fa-plane-arrival me-2"></i>Arrivée
                                </h6>
                                <div class="d-flex align-items-center mb-2">
                                    <div class="flight-icon">
                                        <i class="fas fa-calendar-alt text-success me-3"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Date & Heure estimée</small>
                                        <strong class="fs-5">
                                            <fmt:parseDate value="${vol.dateHeure}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDateTime" />
                                            <fmt:formatDate value="${parsedDateTime}" pattern="dd/MM/yyyy HH:mm" />
                                        </strong>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-2">
                                    <div class="flight-icon">
                                        <i class="fas fa-map-marker-alt text-success me-3"></i>
                                    </div>
                                    <div>
                                        <small class="text-muted d-block">Aéroport</small>
                                        <strong>${vol.vol.aeroportArrivee.ville}</strong>
                                        <div class="text-muted small">${vol.vol.aeroportArrivee.nom}</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Plane Info -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <h6 class="text-primary mb-3">
                                        <i class="fas fa-plane me-2"></i>Informations avion
                                    </h6>
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="aircraft-icon bg-primary bg-opacity-10 p-3 rounded-circle me-3">
                                            <i class="fas fa-plane fa-2x text-primary"></i>
                                        </div>
                                        <div>
                                            <h5 class="mb-1">${vol.avion.nom}</h5>
                                            <small class="text-muted">${vol.avion.modele}</small>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-6">
                                            <div class="mb-2">
                                                <small class="text-muted d-block">Capacité totale</small>
                                                <strong class="fs-5">${vol.avion.capacite} places</strong>
                                            </div>
                                        </div>
                                        <div class="col-6">
                                            <div class="mb-2">
                                                <small class="text-muted d-block">Places restantes</small>
                                                <strong class="fs-5 text-success">${placesDisponibles} places</strong>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="card border-0 shadow-sm h-100">
                                <div class="card-body">
                                    <h6 class="text-success mb-3">
                                        <i class="fas fa-ticket-alt me-2"></i>Disponibilité
                                    </h6>
                                    <div class="availability-chart mb-3">
                                        <div class="d-flex justify-content-between mb-2">
                                            <small>Places occupées</small>
                                            <small>${vol.avion.capacite - placesDisponibles}/${vol.avion.capacite}</small>
                                        </div>
                                        <div class="progress" style="height: 15px;">
                                            <div class="progress-bar bg-success" 
                                                 style="width: ${(placesDisponibles / vol.avion.capacite) * 100}%">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="alert alert-info border-0">
                                        <i class="fas fa-info-circle me-2"></i>
                                        <small>Il reste ${placesDisponibles} places disponibles pour ce vol.</small>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Reservation Form -->
            <div class="card border-0 shadow-sm">
                <div class="card-header bg-white border-0">
                    <h4 class="mb-0">
                        <i class="fas fa-user-check me-2 text-primary"></i>Informations passager
                    </h4>
                </div>
                <div class="card-body">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show d-flex align-items-center" role="alert">
                            <i class="fas fa-exclamation-triangle me-3 fa-lg"></i>
                            <div>${error}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <form:form action="${pageContext.request.contextPath}/reserver" method="post" 
                               modelAttribute="reservationDTO" class="needs-validation" >
                        <form:hidden path="avionVolId" value="${vol.id}" />
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-user me-2 text-primary"></i>Nom complet
                                </label>
                                <form:input path="nomClient" class="form-control form-control-lg shadow-sm" 
                                           placeholder="Ex: Jean Dupont" required="true" />
                                <div class="invalid-feedback">
                                    Veuillez saisir votre nom complet.
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-envelope me-2 text-primary"></i>Adresse email
                                </label>
                                <form:input path="emailClient" type="email" 
                                           class="form-control form-control-lg shadow-sm" 
                                           placeholder="exemple@email.com" required="true" />
                                <div class="invalid-feedback">
                                    Veuillez saisir une adresse email valide.
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-users me-2 text-primary"></i>Nombre de places
                                </label>
                                <form:input path="nbPlaces" type="number" 
                                           class="form-control form-control-lg shadow-sm" 
                                           min="1" max="${placesDisponibles}" 
                                           value="1" required="true" />
                                <small class="text-muted">Maximum: ${placesDisponibles} places disponibles</small>
                                <div class="invalid-feedback">
                                    Veuillez saisir un nombre de places valide.
                                </div>
                            </div>
                            
                            <div class="col-md-6">
                                <label class="form-label fw-bold">
                                    <i class="fas fa-phone me-2 text-primary"></i>Téléphone
                                </label>
                                <input type="tel" class="form-control form-control-lg shadow-sm" 
                                       placeholder="+261 34 00 000 00" required>
                                <div class="invalid-feedback">
                                    Veuillez saisir votre numéro de téléphone.
                                </div>
                            </div>
                            
                            <!-- Additional Options -->
                            <div class="col-12 mt-4">
                                <h5 class="mb-3">
                                    <i class="fas fa-cogs me-2 text-primary"></i>Options supplémentaires
                                </h5>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <div class="form-check card border p-3 h-100">
                                            <input class="form-check-input" type="checkbox" id="assurance">
                                            <label class="form-check-label" for="assurance">
                                                <h6 class="mb-1">Assurance voyage</h6>
                                                <small class="text-muted">+ 50 000 Ar</small>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="form-check card border p-3 h-100">
                                            <input class="form-check-input" type="checkbox" id="baggage">
                                            <label class="form-check-label" for="baggage">
                                                <h6 class="mb-1">Bagage supplémentaire</h6>
                                                <small class="text-muted">+ 20 000 Ar</small>
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <div class="form-check card border p-3 h-100">
                                            <input class="form-check-input" type="checkbox" id="repas">
                                            <label class="form-check-label" for="repas">
                                                <h6 class="mb-1">Repas à bord</h6>
                                                <small class="text-muted">+ 15 000 Ar</small>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Terms and Conditions -->
                            <div class="col-12">
                                <div class="form-check">
                                    <input class="form-check-input" type="checkbox" id="terms" required>
                                    <label class="form-check-label" for="terms">
                                        J'accepte les <a href="#" class="text-primary">conditions générales</a> et la 
                                        <a href="#" class="text-primary">politique de confidentialité</a>
                                    </label>
                                    <div class="invalid-feedback">
                                        Vous devez accepter les conditions générales.
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Action Buttons -->
                            <div class="col-12 mt-4">
                                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                    <button type="submit" class="btn btn-primary btn-lg px-5 shadow-sm">
                                        <i class="fas fa-lock me-2"></i>Payer maintenant
                                    </button>
                                    <a href="${pageContext.request.contextPath}/details?id=${vol.id}" 
                                       class="btn btn-outline-secondary btn-lg px-5">
                                        <i class="fas fa-arrow-left me-2"></i>Retour
                                    </a>
                                </div>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
        
        <!-- Sidebar -->
        <div class="col-lg-4">
            <!-- Price Summary -->
            <div class="card border-0 shadow-sm sticky-top" style="top: 20px;">
                <div class="card-header bg-primary text-white border-0">
                    <h4 class="mb-0">
                        <i class="fas fa-receipt me-2"></i>Récapitulatif
                    </h4>
                </div>
                <div class="card-body">
                    <div class="price-breakdown">
                        <div class="d-flex justify-content-between mb-2">
                            <span>Prix par personne</span>
                            <span class="fw-bold">250 000 Ar</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Nombre de personnes</span>
                            <span id="personCount">1</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Sous-total</span>
                            <span id="subtotal">250 000 Ar</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Taxes et frais</span>
                            <span>25 000 Ar</span>
                        </div>
                        <div class="d-flex justify-content-between mb-2">
                            <span>Options</span>
                            <span id="optionsTotal">0 Ar</span>
                        </div>
                        <hr>
                        <div class="d-flex justify-content-between mb-3">
                            <h5 class="mb-0">Total</h5>
                            <h4 class="text-primary fw-bold" id="totalPrice">275 000 Ar</h4>
                        </div>
                        <small class="text-muted d-block mb-3">
                            <i class="fas fa-info-circle me-1"></i>
                            Prix final TTC
                        </small>
                        
                        <!-- Payment Methods -->
                        <div class="payment-methods mb-4">
                            <h6 class="mb-3">Moyens de paiement</h6>
                            <div class="row g-2">
                                <div class="col-3">
                                    <div class="payment-icon text-center p-2 border rounded">
                                        <i class="fab fa-cc-visa fa-2x text-primary"></i>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="payment-icon text-center p-2 border rounded">
                                        <i class="fab fa-cc-mastercard fa-2x text-danger"></i>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="payment-icon text-center p-2 border rounded">
                                        <i class="fab fa-cc-paypal fa-2x text-info"></i>
                                    </div>
                                </div>
                                <div class="col-3">
                                    <div class="payment-icon text-center p-2 border rounded">
                                        <i class="fas fa-mobile-alt fa-2x text-success"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Security Info -->
                        <div class="alert alert-success border-0">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-shield-alt fa-2x me-3"></i>
                                <div>
                                    <h6 class="mb-1">Paiement sécurisé</h6>
                                    <small class="text-muted">Cryptage SSL 256-bit</small>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Contact Support -->
            <div class="card border-0 shadow-sm mt-4">
                <div class="card-body text-center">
                    <i class="fas fa-headset fa-3x text-primary mb-3"></i>
                    <h5>Besoin d'aide ?</h5>
                    <p class="text-muted small">Notre équipe est disponible 24h/24</p>
                    <a href="tel:+261202222222" class="btn btn-outline-primary btn-sm">
                        <i class="fas fa-phone me-2"></i>Appeler le support
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
    .breadcrumb {
        background-color: #f8f9fa;
        border-radius: 10px;
    }
    
    .flight-icon {
        width: 40px;
        text-align: center;
    }
    
    .aircraft-icon {
        width: 70px;
        height: 70px;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .availability-chart .progress {
        border-radius: 10px;
        background-color: #e9ecef;
    }
    
    .payment-icon {
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .payment-icon:hover {
        transform: translateY(-3px);
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    
    .form-check .card {
        transition: all 0.3s ease;
        cursor: pointer;
    }
    
    .form-check .card:hover {
        border-color: #0066cc !important;
        transform: translateY(-2px);
    }
    
    .form-check-input:checked ~ .card {
        border-color: #0066cc !important;
        background-color: rgba(0, 102, 204, 0.05);
    }
    
    .sticky-top {
        z-index: 999;
    }
</style>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Price calculation
        const pricePerPerson = 250000;
        const nbPlacesInput = document.getElementById('nbPlaces');
        const personCountSpan = document.getElementById('personCount');
        const subtotalSpan = document.getElementById('subtotal');
        const optionsTotalSpan = document.getElementById('optionsTotal');
        const totalPriceSpan = document.getElementById('totalPrice');
        const taxes = 25000;
        
        // Calculate options total
        let optionsTotal = 0;
        const optionCheckboxes = document.querySelectorAll('.form-check-input[type="checkbox"]:not(#terms)');
        
        function calculateTotal() {
            const nbPlaces = parseInt(nbPlacesInput.value) || 1;
            const subtotal = pricePerPerson * nbPlaces;
            const total = subtotal + taxes + optionsTotal;
            
            personCountSpan.textContent = nbPlaces;
            subtotalSpan.textContent = subtotal.toLocaleString() + ' Ar';
            totalPriceSpan.textContent = total.toLocaleString() + ' Ar';
        }
        
        // Update options total and recalculate
        optionCheckboxes.forEach(checkbox => {
            checkbox.addEventListener('change', function() {
                optionsTotal = 0;
                optionCheckboxes.forEach(cb => {
                    if (cb.checked) {
                        const priceText = cb.parentElement.querySelector('small').textContent;
                        const price = parseInt(priceText.match(/\d+/g)[0]) * 1000;
                        optionsTotal += price;
                    }
                });
                optionsTotalSpan.textContent = optionsTotal.toLocaleString() + ' Ar';
                calculateTotal();
            });
        });
        
        // Update when number of places changes
        nbPlacesInput.addEventListener('input', calculateTotal);
        
        // Initial calculation
        calculateTotal();
        
        // Form validation
        const form = document.querySelector('.needs-validation');
        form.addEventListener('submit', function(event) {
            if (!form.checkValidity()) {
                event.preventDefault();
                event.stopPropagation();
            }
            form.classList.add('was-validated');
        }, false);
    });
</script>
</body>
</html>