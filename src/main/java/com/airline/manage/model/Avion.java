package com.airline.manage.model;

import jakarta.persistence.*;

@Entity
@Table(name = "avion")
public class Avion {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false, length = 100)
    private String nom;

    @Column(name = "modele", nullable = false, length = 100)
    private String modele;

    @Column(name = "capacite", nullable = false)
    private Integer capacite;

    // Constructeurs
    public Avion() {
    }

    public Avion(String nom, String modele, Integer capacite) {
        this.nom = nom;
        this.modele = modele;
        this.capacite = capacite;
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

    public String getModele() {
        return modele;
    }

    public void setModele(String modele) {
        this.modele = modele;
    }

    public Integer getCapacite() {
        return capacite;
    }

    public void setCapacite(Integer capacite) {
        this.capacite = capacite;
    }
}