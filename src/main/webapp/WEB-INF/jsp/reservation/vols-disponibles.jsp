<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="../layout/sidebar.jsp" %>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/footer.jsp" %>

<div style="margin-left:260px; padding:20px;">
    <h2>Vols disponibles</h2>

    <c:forEach var="vol" items="${vols}">
        <form method="post" action="/reservation/reserver">
            <p>
                Vol ID: ${vol.id} <br/>
                Avion: ${vol.avion.nom} (${vol.avion.modele}) <br/>
                Date & Heure: ${vol.dateHeure} <br/>
                Nombre de places: <input type="number" name="nbPlaces" min="1" value="1"/>
            </p>
            <input type="hidden" name="avionVolId" value="${vol.id}"/>
            <input type="submit" value="Réserver"/>
        </form>
        <hr/>
    </c:forEach>
</div>
