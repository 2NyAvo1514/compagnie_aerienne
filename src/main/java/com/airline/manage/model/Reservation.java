package com.airline.manage.model;

import jakarta.persistence.*;

@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "avion_vol_id", nullable = false)
    private AvionVol avionVol;

    @ManyToOne
    @JoinColumn(name = "client_id", nullable = false)
    private Client client;

    @Column(name = "nb_places", nullable = false)
    private Integer nbPlaces;

    // Constructeurs
    public Reservation() {
    }

    public Reservation(AvionVol avionVol, Client client, Integer nbPlaces) {
        this.avionVol = avionVol;
        this.client = client;
        this.nbPlaces = nbPlaces;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public AvionVol getAvionVol() {
        return avionVol;
    }

    public void setAvionVol(AvionVol avionVol) {
        this.avionVol = avionVol;
    }

    public Client getClient() {
        return client;
    }

    public void setClient(Client client) {
        this.client = client;
    }

    public Integer getNbPlaces() {
        return nbPlaces;
    }

    public void setNbPlaces(Integer nbPlaces) {
        this.nbPlaces = nbPlaces;
    }
}