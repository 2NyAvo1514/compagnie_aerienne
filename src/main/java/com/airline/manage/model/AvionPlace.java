package com.airline.manage.model;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "avion_place")
public class AvionPlace {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_avion", nullable = false)
    private Avion avion;

    @ManyToOne
    @JoinColumn(name = "id_place", nullable = false)
    private Place place;

    @Column(name = "nombre", nullable = false)
    private Integer nombre;

    // Constructeurs
    public AvionPlace() {
    }

    public AvionPlace(Avion avion, Place place, Integer nombre) {
        this.avion = avion;
        this.place = place;
        this.nombre = nombre;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Avion getAvion() {
        return avion;
    }

    public void setAvion(Avion avion) {
        this.avion = avion;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public Integer getNombre() {
        return nombre;
    }

    public void setNombre(Integer nombre) {
        this.nombre = nombre;
    }

    // Méthode utilitaire pour calculer la valeur maximale
    public BigDecimal getValeurMaximale(BigDecimal prix) {
        if (prix == null || nombre == null) {
            return BigDecimal.ZERO;
        }
        return prix.multiply(BigDecimal.valueOf(nombre));
    }
}