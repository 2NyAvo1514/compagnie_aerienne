package com.airline.manage.model;

import jakarta.persistence.*;

@Entity
@Table(name = "vol")
public class Vol {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "aeroport_depart_id", nullable = false)
    private Aeroport aeroportDepart;

    @ManyToOne
    @JoinColumn(name = "aeroport_arrivee_id", nullable = false)
    private Aeroport aeroportArrivee;

    // Constructeurs
    public Vol() {
    }

    public Vol(Aeroport aeroportDepart, Aeroport aeroportArrivee) {
        this.aeroportDepart = aeroportDepart;
        this.aeroportArrivee = aeroportArrivee;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Aeroport getAeroportDepart() {
        return aeroportDepart;
    }

    public void setAeroportDepart(Aeroport aeroportDepart) {
        this.aeroportDepart = aeroportDepart;
    }

    public Aeroport getAeroportArrivee() {
        return aeroportArrivee;
    }

    public void setAeroportArrivee(Aeroport aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee;
    }
}