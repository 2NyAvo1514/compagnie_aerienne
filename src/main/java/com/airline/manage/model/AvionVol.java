package com.airline.manage.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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

    public LocalDateTime getDateHeure() {
        return dateHeure;
    }

    public void setDateHeure(LocalDateTime dateHeure) {
        this.dateHeure = dateHeure;
    }

    // Méthode pour formater la date
    public String getDateHeureFormatted() {
        if (dateHeure == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");
        return dateHeure.format(formatter);
    }
    
    // Méthode pour savoir si le vol est passé
    public boolean isPasse() {
        if (dateHeure == null) return false;
        return dateHeure.isBefore(LocalDateTime.now());
    }
    
    // Méthode pour formater la date pour les inputs HTML
    public String getDateHeureForInput() {
        if (dateHeure == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        return dateHeure.format(formatter);
    }
    
    // Méthode pour formater l'heure pour les inputs HTML
    public String getHeureForInput() {
        if (dateHeure == null) return "";
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
        return dateHeure.format(formatter);
    }
}