<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../layout/sidebar.jsp" %>
<%@ include file="../layout/header.jsp" %>
<%@ include file="../layout/footer.jsp" %>

<div style="margin-left:260px; padding:20px;">
    <h2>Rechercher un vol</h2>

    <form method="post" action="/reservation/chercher">
        Départ : <input type="text" name="depart" value="TNR"/><br/><br/>
        Arrivée : <input type="text" name="arrivee" value="Nosy Be"/><br/><br/>
        Date & Heure : <input type="datetime-local" name="dateHeure" value="2026-01-12T12:00"/><br/><br/>
        <input type="submit" value="Chercher"/>
    </form>
</div>
