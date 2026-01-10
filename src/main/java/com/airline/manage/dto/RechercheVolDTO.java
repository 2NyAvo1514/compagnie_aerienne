package com.airline.manage.dto;

import java.time.LocalDate;

public class RechercheVolDTO {
    private String aeroportDepart;
    private String aeroportArrivee;
    private LocalDate date;
    private Integer heure;

    // Constructeurs
    public RechercheVolDTO() {
    }

    public RechercheVolDTO(String aeroportDepart, String aeroportArrivee, LocalDate date, Integer heure) {
        this.aeroportDepart = aeroportDepart;
        this.aeroportArrivee = aeroportArrivee;
        this.date = date;
        this.heure = heure;
    }

    // Getters et Setters
    public String getAeroportDepart() {
        return aeroportDepart;
    }

    public void setAeroportDepart(String aeroportDepart) {
        this.aeroportDepart = aeroportDepart;
    }

    public String getAeroportArrivee() {
        return aeroportArrivee;
    }

    public void setAeroportArrivee(String aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public Integer getHeure() {
        return heure;
    }

    public void setHeure(Integer heure) {
        this.heure = heure;
    }
}