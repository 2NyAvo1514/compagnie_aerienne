<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="fragments/header.jsp" %>
<jsp:include page="fragments/navbar.jsp">
    <jsp:param name="menu" value="vols"/>
</jsp:include>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liste des Vols - Compagnie Aérienne</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        /* CSS simplifié pour éviter les erreurs */
        body { font-family: Arial, sans-serif; margin: 0; padding: 20px; background: #f5f5f5; }
        .container { max-width: 1200px; margin: 0 auto; background: white; padding: 20px; border-radius: 5px; }
        .table { width: 100%; border-collapse: collapse; }
        .table th, .table td { padding: 10px; border: 1px solid #ddd; }
        .table th { background: #007bff; color: white; }
        .btn { padding: 5px 10px; margin: 2px; }
        .badge { padding: 5px 10px; border-radius: 3px; }
        .bg-success { background: #28a745; }
        .bg-warning { background: #ffc107; }
        .bg-danger { background: #dc3545; }
        .bg-secondary { background: #6c757d; }
    </style>
</head>
<body>
    <div class="container">
        <h1>Liste des Vols</h1>
        
        <!-- Message de débogage -->
        <div class="alert alert-info">
            Nombre de vols trouvés: <strong>${vols.size()}</strong>
        </div>
        
        <c:choose>
            <c:when test="${not empty vols}">
                <table class="table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Départ</th>
                            <th>Arrivée</th>
                            <th>Date & Heure</th>
                            <th>Avion</th>
                            <th>Places</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="vol" items="${vols}" varStatus="status">
                            <tr>
                                <td>${status.index + 1}</td>
                                <td>
                                    <strong>${vol.aeroportDepart}</strong><br>
                                    <small>${vol.villeDepart}</small>
                                </td>
                                <td>
                                    <strong>${vol.aeroportArrivee}</strong><br>
                                    <small>${vol.villeArrivee}</small>
                                </td>
                                <td>
                                    <strong>${vol.formattedTime}</strong><br>
                                    <small>${vol.formattedDate}</small>
                                </td>
                                <td>
                                    ${vol.nomAvion}<br>
                                    <small>${vol.modeleAvion}</small>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${vol.placesDisponibles > 20}">
                                            <span class="badge bg-success">${vol.placesDisponibles} places</span>
                                        </c:when>
                                        <c:when test="${vol.placesDisponibles > 10}">
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
                                           class="btn btn-primary btn-sm">
                                            Réserver
                                        </a>
                                    </c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:when>
            <c:otherwise>
                <div class="alert alert-warning">
                    Aucun vol trouvé.
                </div>
            </c:otherwise>
        </c:choose>
        
        <!-- Retour à l'accueil -->
        <div class="mt-3">
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                Retour à l'accueil
            </a>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <%@ include file="fragments/footer.jsp" %>
</body>
</html>