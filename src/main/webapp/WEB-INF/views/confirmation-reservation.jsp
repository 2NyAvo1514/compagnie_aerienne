<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Confirmation de Réservation</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      .container {
        max-width: 600px;
        margin: auto;
        text-align: center;
      }
      .success {
        color: #28a745;
        font-size: 24px;
        margin: 20px 0;
      }
      .details {
        text-align: left;
        margin: 20px 0;
        padding: 15px;
        background-color: #f8f9fa;
      }
      .btn {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        text-decoration: none;
        display: inline-block;
        margin: 10px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>Confirmation</h1>

      <div class="success">${message}</div>

      <div class="details">
        <p><strong>Nom du client:</strong> ${reservation.nomClient}</p>
        <p><strong>Email:</strong> ${reservation.emailClient}</p>
        <p><strong>Nombre de places:</strong> ${reservation.nbPlaces}</p>
      </div>

      <div>
        <a
          href="${pageContext.request.contextPath}/reservation/recherche"
          class="btn"
        >
          Faire une nouvelle réservation
        </a>
        <a href="${pageContext.request.contextPath}/" class="btn">
          Retour à l'accueil
        </a>
      </div>
    </div>
  </body>
</html>
