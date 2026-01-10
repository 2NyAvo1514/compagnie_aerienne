<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>Recherche de Vols</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 20px;
      }
      .container {
        max-width: 800px;
        margin: auto;
      }
      .form-group {
        margin-bottom: 15px;
      }
      label {
        display: block;
        margin-bottom: 5px;
      }
      input,
      select {
        width: 100%;
        padding: 8px;
      }
      button {
        background-color: #007bff;
        color: white;
        padding: 10px 20px;
        border: none;
        cursor: pointer;
      }
      button:hover {
        background-color: #0056b3;
      }
      .vol-card {
        border: 1px solid #ddd;
        padding: 15px;
        margin-bottom: 10px;
        border-radius: 5px;
      }
      .btn-reserver {
        background-color: #28a745;
        color: white;
        padding: 5px 10px;
        text-decoration: none;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>Rechercher un vol</h1>

      <form
        action="${pageContext.request.contextPath}/reservation/rechercher"
        method="post"
      >
        <div class="form-group">
          <label for="aeroportDepart">Aéroport de départ:</label>
          <input
            type="text"
            id="aeroportDepart"
            name="aeroportDepart"
            value="Aéroport d'Ivato"
            required
          />
        </div>

        <div class="form-group">
          <label for="aeroportArrivee">Aéroport d'arrivée:</label>
          <input
            type="text"
            id="aeroportArrivee"
            name="aeroportArrivee"
            value="Aéroport de Fascène"
            required
          />
        </div>

        <div class="form-group">
          <label for="date">Date:</label>
          <input
            type="date"
            id="date"
            name="date"
            value="2024-01-12"
            required
          />
        </div>

        <div class="form-group">
          <label for="heure">Heure:</label>
          <input
            type="number"
            id="heure"
            name="heure"
            min="0"
            max="23"
            value="12"
            required
          />
        </div>

        <button type="submit">Rechercher</button>
      </form>
    </div>
  </body>
</html>
