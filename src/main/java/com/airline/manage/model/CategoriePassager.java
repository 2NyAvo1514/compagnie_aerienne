package com.airline.manage.model;

import jakarta.persistence.*;

@Entity
@Table(name = "categorie")
public class CategoriePassager {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_categorie")
    private Long id;

    @Column(name = "nom", nullable = false, unique = true, length = 20)
    private String nom;

    // Constructeurs
    public CategoriePassager() {
    }

    public CategoriePassager(String nom) {
        this.nom = nom;
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

    @Override
    public String toString() {
        return "CategoriePassager{" +
                "id=" + id +
                ", nom='" + nom + '\'' +
                '}';
    }
}
