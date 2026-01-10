<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Réservation</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      .container {
        max-width: 600px;
        margin: auto;
      }
      .form-group {
        margin-bottom: 15px;
      }
      label {
        display: block;
        margin-bottom: 5px;
      }
      input {
        width: 100%;
        padding: 8px;
      }
      button {
        background-color: #28a745;
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
      }
      button:hover {
        background-color: #218838;
      }
      .erreur {
        color: #dc3545;
        margin-top: 5px;
      }
      .btn-retour {
        background-color: #6c757d;
        color: white;
        padding: 10px 15px;
        text-decoration: none;
        display: inline-block;
        margin-top: 10px;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>Réservation de places</h1>

      <c:if test="${not empty erreur}">
        <div class="erreur">${erreur}</div>
      </c:if>

      <form
        action="${pageContext.request.contextPath}/reservation/confirmer"
        method="post"
      >
        <input
          type="hidden"
          name="avionVolId"
          value="${reservationDTO.avionVolId}"
        />

        <div class="form-group">
          <label for="nomClient">Nom complet:</label>
          <input
            type="text"
            id="nomClient"
            name="nomClient"
            value="${reservationDTO.nomClient}"
            required
          />
        </div>

        <div class="form-group">
          <label for="emailClient">Email:</label>
          <input
            type="email"
            id="emailClient"
            name="emailClient"
            value="${reservationDTO.emailClient}"
            required
          />
        </div>

        <div class="form-group">
          <label for="nbPlaces">Nombre de places:</label>
          <input
            type="number"
            id="nbPlaces"
            name="nbPlaces"
            min="1"
            value="${reservationDTO.nbPlaces}"
            required
          />
        </div>

        <button type="submit">Confirmer la réservation</button>
      </form>

      <a
        href="${pageContext.request.contextPath}/reservation/recherche"
        class="btn-retour"
      >
        Retour à la recherche
      </a>
    </div>
  </body>
</html>
