package com.airline.manage.model;

import jakarta.persistence.*;

@Entity
@Table(name = "aeroport")
public class Aeroport {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false, length = 100)
    private String nom;

    @Column(name = "ville", nullable = false, length = 100)
    private String ville;

    // Constructeurs
    public Aeroport() {
    }

    public Aeroport(String nom, String ville) {
        this.nom = nom;
        this.ville = ville;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public String getVille() {
        return ville;
    }

    public void setVille(String ville) {
        this.ville = ville;
    }
}