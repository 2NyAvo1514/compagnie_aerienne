<%@ page contentType="text/html;charset=UTF-8" language="java" %> <%@ taglib
prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Madagascar Airways - Compagnie Aérienne</title>
    <!-- Bootstrap CSS -->
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <!-- Font Awesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/style.css"
    />
    <style>
      :root {
        --primary-color: #0066cc;
        --secondary-color: #00a8ff;
        --accent-color: #ff6b6b;
        --light-bg: #f8f9fa;
        --dark-bg: #2c3e50;
      }

      body {
        font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
        background-color: #f8fafc;
      }

      .navbar-brand {
        font-weight: 800;
        font-size: 1.8rem;
        color: var(--primary-color) !important;
      }

      .nav-link {
        font-weight: 500;
        padding: 0.5rem 1rem;
        border-radius: 5px;
        transition: all 0.3s ease;
      }

      .nav-link:hover {
        background-color: rgba(0, 102, 204, 0.1);
        transform: translateY(-2px);
      }

      .navbar-toggler {
        border: none;
        padding: 0.5rem;
      }

      .navbar-toggler:focus {
        box-shadow: none;
      }

      .badge-notification {
        position: absolute;
        top: 5px;
        right: 5px;
        font-size: 0.6rem;
        padding: 2px 5px;
      }

      .dropdown-menu {
        border: none;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
        padding: 0.5rem 0;
        animation: fadeIn 0.3s ease;
      }

      .dropdown-item {
        padding: 0.75rem 1.5rem;
        transition: all 0.2s ease;
      }

      .dropdown-item:hover {
        background-color: rgba(0, 102, 204, 0.1);
        padding-left: 2rem;
      }

      @keyframes fadeIn {
        from {
          opacity: 0;
          transform: translateY(-10px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }

      @media (max-width: 991.98px) {
        .navbar-nav {
          padding: 1rem 0;
        }

        .nav-link {
          padding: 0.75rem 1rem;
        }
      }
    </style>
  </head>
  <body>
    <!-- Navigation Bar -->
    <nav
      class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top"
    >
      <div class="container">
        <!-- Logo -->
        <a
          class="navbar-brand d-flex align-items-center"
          href="${pageContext.request.contextPath}/"
        >
          <i class="fas fa-plane me-2 text-primary"></i>
          <span>Madagascar Airways</span>
        </a>

        <!-- Mobile Toggle Button -->
        <button
          class="navbar-toggler"
          type="button"
          data-bs-toggle="collapse"
          data-bs-target="#navbarContent"
        >
          <span class="navbar-toggler-icon"></span>
        </button>

        <!-- Navigation Links -->
        <div class="collapse navbar-collapse" id="navbarContent">
          <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
            <li class="nav-item">
              <a
                class="nav-link ${pageContext.request.requestURI.endsWith('index.jsp') ? 'active text-primary' : ''}"
                href="${pageContext.request.contextPath}/"
              >
                <i class="fas fa-search me-2"></i>Rechercher
              </a>
            </li>

            <li class="nav-item dropdown">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
              >
                <i class="fas fa-user me-2"></i>Mon Compte
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a class="dropdown-item" href="#"
                    ><i class="fas fa-ticket-alt me-2"></i>Mes Réservations</a
                  >
                </li>
                <li>
                  <a class="dropdown-item" href="#"
                    ><i class="fas fa-user-edit me-2"></i>Mon Profil</a
                  >
                </li>
                <li><hr class="dropdown-divider" /></li>
                <li>
                  <a class="dropdown-item" href="#"
                    ><i class="fas fa-sign-in-alt me-2"></i>Connexion</a
                  >
                </li>
              </ul>
            </li>

            <li class="nav-item">
              <a class="nav-link" href="#">
                <i class="fas fa-info-circle me-2"></i>Aide
              </a>
            </li>

            <li class="nav-item">
              <a class="nav-link position-relative" href="#">
                <i class="fas fa-shopping-cart me-2"></i>Panier
                <span class="badge bg-danger badge-notification">3</span>
              </a>
            </li>

            <!-- Language Selector -->
            <li class="nav-item dropdown ms-2">
              <a
                class="nav-link dropdown-toggle"
                href="#"
                role="button"
                data-bs-toggle="dropdown"
              >
                <i class="fas fa-globe me-2"></i>FR
              </a>
              <ul class="dropdown-menu">
                <li>
                  <a class="dropdown-item" href="#"
                    ><i class="flag-icon flag-icon-fr me-2"></i>Français</a
                  >
                </li>
                <li>
                  <a class="dropdown-item" href="#"
                    ><i class="flag-icon flag-icon-gb me-2"></i>English</a
                  >
                </li>
                <!-- Ajouter dans navbar.jsp -->
                <li class="nav-item dropdown">
                  <a
                    class="nav-link dropdown-toggle"
                    href="#"
                    id="statistiquesDropdown"
                    role="button"
                    data-bs-toggle="dropdown"
                  >
                    <i class="fas fa-chart-line me-1"></i> Statistiques
                  </a>
                  <ul class="dropdown-menu">
                    <li>
                      <a class="dropdown-item" href="/statistiques">
                        <i class="fas fa-plane me-2"></i>Par avion
                      </a>
                    </li>
                    <li>
                      <a class="dropdown-item" href="/statistiques/trajets">
                        <i class="fas fa-route me-2"></i>Par trajet
                      </a>
                    </li>
                    <li><hr class="dropdown-divider" /></li>
                    <li>
                      <a class="dropdown-item" href="/statistiques/par-periode">
                        <i class="fas fa-calendar-alt me-2"></i>Par période
                      </a>
                    </li>
                  </ul>
                </li>
              </ul>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      // Navbar scroll effect
      window.addEventListener("scroll", function () {
        const navbar = document.querySelector(".navbar");
        if (window.scrollY > 50) {
          navbar.classList.add("navbar-scrolled");
        } else {
          navbar.classList.remove("navbar-scrolled");
        }
      });

      // Initialize tooltips
      document.addEventListener("DOMContentLoaded", function () {
        var tooltipTriggerList = [].slice.call(
          document.querySelectorAll('[data-bs-toggle="tooltip"]')
        );
        var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
          return new bootstrap.Tooltip(tooltipTriggerEl);
        });
      });
    </script>
  </body>
</html>
