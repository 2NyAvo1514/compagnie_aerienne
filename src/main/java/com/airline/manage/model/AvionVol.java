package com.airline.manage.model;

import jakarta.persistence.*;
import java.time.OffsetDateTime;

@Entity
@Table(name = "avion_vol")
public class AvionVol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "avion_id", nullable = false)
    private Avion avion;

    @ManyToOne
    @JoinColumn(name = "vol_id", nullable = false)
    private Vol vol;

    @Column(name = "date_heure", nullable = false)
    private OffsetDateTime dateHeure;

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

    public Vol getVol() {
        return vol;
    }

    public void setVol(Vol vol) {
        this.vol = vol;
    }

    public OffsetDateTime getDateHeure() {
        return dateHeure;
    }

    public void setDateHeure(OffsetDateTime dateHeure) {
        this.dateHeure = dateHeure;
    }
}
