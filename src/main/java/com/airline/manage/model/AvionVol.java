package com.airline.manage.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "avion_vol")
public class AvionVol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "avion_id", nullable = false)
    private Avion avion;

    @ManyToOne
    @JoinColumn(name = "vol_id", nullable = false)
    private Vol vol;

    @Column(name = "date_heure", nullable = false)
    private LocalDateTime dateHeure;

    // Constructeurs
    public AvionVol() {
    }

    public AvionVol(Avion avion, Vol vol, LocalDateTime dateHeure) {
        this.avion = avion;
        this.vol = vol;
        this.dateHeure = dateHeure;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Avion getAvion() {
        return avion;
    }

    public void setAvion(Avion avion) {
        this.avion = avion;
    }

    public Vol getVol() {
        return vol;
    }

    public void setVol(Vol vol) {
        this.vol = vol;
    }

    public LocalDateTime getDateHeure() {
        return dateHeure;
    }

    public void setDateHeure(LocalDateTime dateHeure) {
        this.dateHeure = dateHeure;
    }
}