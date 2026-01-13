<%@ page contentType="text/html;charset=UTF-8" %>
    </div> <!-- Fin de content-wrapper -->
    
    <!-- Pied de page -->
    <footer class="border-top mt-5 py-4">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-6">
                    <h5 class="mb-2"><i class="fas fa-plane me-2"></i>AirMad Airlines</h5>
                    <p class="text-muted mb-0">Votre compagnie aérienne de confiance depuis 2024</p>
                </div>
                <div class="col-md-6 text-md-end">
                    <p class="text-muted mb-0">
                        &copy; 2024 AirMad Airlines. Tous droits réservés.
                    </p>
                    <p class="text-muted small">
                        <a href="#" class="text-decoration-none text-muted me-3">Mentions légales</a>
                        <a href="#" class="text-decoration-none text-muted me-3">Contact</a>
                        <a href="#" class="text-decoration-none text-muted">Confidentialité</a>
                    </p>
                </div>
            </div>
        </div>
    </footer>
</div> <!-- Fin de main-content -->

<!-- Bootstrap JS Bundle avec Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Scripts personnalisés -->
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Activer les tooltips Bootstrap
        var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
            return new bootstrap.Tooltip(tooltipTriggerEl);
        });
        
        // Activer les popovers
        var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'));
        var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
            return new bootstrap.Popover(popoverTriggerEl);
        });
        
        // Tri des tables
        document.querySelectorAll('.table th[data-sort]').forEach(function(th) {
            th.style.cursor = 'pointer';
            th.addEventListener('click', function() {
                var table = this.closest('table');
                var tbody = table.querySelector('tbody');
                var rows = Array.from(tbody.querySelectorAll('tr'));
                var colIndex = Array.from(this.parentNode.children).indexOf(this);
                var isAsc = this.classList.contains('sort-asc');
                
                // Trier les lignes
                rows.sort(function(a, b) {
                    var aText = a.children[colIndex].textContent.trim();
                    var bText = b.children[colIndex].textContent.trim();
                    
                    // Essayer de convertir en nombre
                    var aNum = parseFloat(aText.replace(/[^0-9.-]+/g, ""));
                    var bNum = parseFloat(bText.replace(/[^0-9.-]+/g, ""));
                    
                    if (!isNaN(aNum) && !isNaN(bNum)) {
                        return isAsc ? aNum - bNum : bNum - aNum;
                    }
                    
                    // Sinon tri alphabétique
                    return isAsc ? aText.localeCompare(bText) : bText.localeCompare(aText);
                });
                
                // Réorganiser les lignes
                rows.forEach(function(row) {
                    tbody.appendChild(row);
                });
                
                // Mettre à jour les classes de tri
                table.querySelectorAll('th').forEach(function(header) {
                    header.classList.remove('sort-asc', 'sort-desc');
                });
                
                this.classList.add(isAsc ? 'sort-desc' : 'sort-asc');
            });
        });
        
        // Confirmation des actions importantes
        document.querySelectorAll('.btn-danger, .btn-warning').forEach(function(button) {
            button.addEventListener('click', function(e) {
                if (!confirm('Êtes-vous sûr de vouloir effectuer cette action ?')) {
                    e.preventDefault();
                }
            });
        });
        
        // Auto-dismiss des alertes après 5 secondes
        setTimeout(function() {
            document.querySelectorAll('.alert:not(.alert-permanent)').forEach(function(alert) {
                var bsAlert = new bootstrap.Alert(alert);
                bsAlert.close();
            });
        }, 5000);
        
        // Gestion des modales
        document.querySelectorAll('.modal').forEach(function(modal) {
            modal.addEventListener('shown.bs.modal', function() {
                // Focus sur le premier champ input dans la modale
                var input = modal.querySelector('input, select, textarea');
                if (input) {
                    setTimeout(function() {
                        input.focus();
                    }, 100);
                }
            });
        });
        
        // Validation des formulaires
        document.querySelectorAll('form').forEach(function(form) {
            form.addEventListener('submit', function(e) {
                var requiredFields = form.querySelectorAll('[required]');
                var isValid = true;
                
                requiredFields.forEach(function(field) {
                    if (!field.value.trim()) {
                        field.classList.add('is-invalid');
                        isValid = false;
                    } else {
                        field.classList.remove('is-invalid');
                    }
                });
                
                if (!isValid) {
                    e.preventDefault();
                    // Afficher un message d'erreur
                    var errorDiv = form.querySelector('.form-error') || document.createElement('div');
                    errorDiv.className = 'alert alert-danger mt-2 form-error';
                    errorDiv.textContent = 'Veuillez remplir tous les champs obligatoires.';
                    if (!form.querySelector('.form-error')) {
                        form.appendChild(errorDiv);
                    }
                }
            });
        });
    });
    
    // Fonctions utilitaires
    function formatDate(dateString) {
        if (!dateString) return '';
        var date = new Date(dateString);
        return date.toLocaleDateString('fr-FR', {
            day: '2-digit',
            month: '2-digit',
            year: 'numeric'
        });
    }
    
    function formatTime(dateString) {
        if (!dateString) return '';
        var date = new Date(dateString);
        return date.toLocaleTimeString('fr-FR', {
            hour: '2-digit',
            minute: '2-digit'
        });
    }
    
    function formatCurrency(amount) {
        return new Intl.NumberFormat('fr-FR', {
            style: 'currency',
            currency: 'EUR'
        }).format(amount);
    }
</script>
</body>
</html>