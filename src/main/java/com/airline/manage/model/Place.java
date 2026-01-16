package com.airline.manage.model;

import jakarta.persistence.*;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "place")
public class Place {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id_place")
    private Integer id;

    @Column(name = "type", nullable = false, unique = true, length = 20)
    private String type;

    @OneToMany(mappedBy = "place", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<AvionPlace> avionPlaces = new HashSet<>();

    @OneToMany(mappedBy = "place", cascade = CascadeType.ALL, orphanRemoval = true)
    private Set<PrixVol> prixVols = new HashSet<>();

    // Constructeurs
    public Place() {
    }

    public Place(String type) {
        this.type = type;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Set<AvionPlace> getAvionPlaces() {
        return avionPlaces;
    }

    public void setAvionPlaces(Set<AvionPlace> avionPlaces) {
        this.avionPlaces = avionPlaces;
    }

    public Set<PrixVol> getPrixVols() {
        return prixVols;
    }

    public void setPrixVols(Set<PrixVol> prixVols) {
        this.prixVols = prixVols;
    }

    @Override
    public String toString() {
        return type;
    }
}