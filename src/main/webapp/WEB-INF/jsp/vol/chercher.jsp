<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../layout/sidebar.jsp" %>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/footer.jsp" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Recherche de vols</title>
</head>
<body>

<h2>Rechercher un vol</h2>

<form method="get" action="/vols/chercher">
    Départ :
    <input type="text" name="depart" placeholder="Antananarivo">

    Arrivée :
    <input type="text" name="arrivee" placeholder="Nosy Be">

    Date :
    <input type="date" name="date">

    Heure (optionnel) :
    <input type="time" name="heure">

    <button type="submit">Rechercher</button>
</form>

<hr>

<h3>Résultats</h3>

<c:if test="${empty vols}">
    Aucun vol trouvé
</c:if>

<c:if test="${not empty vols}">
    <table border="1">
        <tr>
            <th>Avion</th>
            <th>Départ</th>
            <th>Arrivée</th>
            <th>Date & heure</th>
        </tr>

        <c:forEach var="v" items="${vols}">
            <tr>
                <td>${v.avion.nom} (${v.avion.modele})</td>
                <td>${v.vol.aeroportDepart.ville}</td>
                <td>${v.vol.aeroportArrivee.ville}</td>
                <td>${v.dateHeure}</td>
            </tr>
        </c:forEach>
    </table>
</c:if>

</body>
</html>
