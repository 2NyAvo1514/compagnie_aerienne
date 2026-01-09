<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="sidebar" style="width:250px; transition: width 0.3s; background-color:#2c3e50; color:white; height:100vh; float:left; overflow:hidden;">
    <button onclick="toggleSidebar()" style="width:100%; background:#34495e; color:white; border:none; padding:10px;">☰ Menu</button>
    <ul style="list-style:none; padding:0; margin:0;">
        <li><a href="/home" style="color:white; text-decoration:none; display:block; padding:10px;">Accueil</a></li>
        <li><a href="/reservation/chercher" style="color:white; text-decoration:none; display:block; padding:10px;">Réserver un vol</a></li>
        <li><a href="/avion/liste" style="color:white; text-decoration:none; display:block; padding:10px;">Avions</a></li>
        <li><a href="/vol/chercher" style="color:white; text-decoration:none; display:block; padding:10px;">Vols</a></li>
        <li><a href="/aeroport/liste" style="color:white; text-decoration:none; display:block; padding:10px;">Aéroports</a></li>
        <li><a href="/client/liste" style="color:white; text-decoration:none; display:block; padding:10px;">Clients</a></li>
        <li><a href="/reservation/list" style="color:white; text-decoration:none; display:block; padding:10px;">Réservations</a></li>
    </ul>
</div>

<script>
function toggleSidebar() {
    var sidebar = document.getElementById('sidebar');
    if (sidebar.style.width === '250px') {
        sidebar.style.width = '60px';
    } else {
        sidebar.style.width = '250px';
    }
}
</script>
