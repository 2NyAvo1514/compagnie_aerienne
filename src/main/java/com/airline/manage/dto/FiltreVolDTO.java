package com.airline.manage.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class FiltreVolDTO {
    private Long aeroportDepartId;
    private Long aeroportArriveeId;
    private LocalDate date;
    private String heureMin;
    private String heureMax;
    private Integer placesMin;
    private String typeAvion;

    // Constructeurs
    public FiltreVolDTO() {
    }

    // Getters et Setters
    public Long getAeroportDepartId() {
        return aeroportDepartId;
    }

    public void setAeroportDepartId(Long aeroportDepartId) {
        this.aeroportDepartId = aeroportDepartId;
    }

    public Long getAeroportArriveeId() {
        return aeroportArriveeId;
    }

    public void setAeroportArriveeId(Long aeroportArriveeId) {
        this.aeroportArriveeId = aeroportArriveeId;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getHeureMin() {
        return heureMin;
    }

    public void setHeureMin(String heureMin) {
        this.heureMin = heureMin;
    }

    public String getHeureMax() {
        return heureMax;
    }

    public void setHeureMax(String heureMax) {
        this.heureMax = heureMax;
    }

    public Integer getPlacesMin() {
        return placesMin;
    }

    public void setPlacesMin(Integer placesMin) {
        this.placesMin = placesMin;
    }

    public String getTypeAvion() {
        return typeAvion;
    }

    public void setTypeAvion(String typeAvion) {
        this.typeAvion = typeAvion;
    }

    // Méthode de formatage pour l'input date HTML
    public String getFormattedDate() {
        if (date == null) {
            return LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        }
        return date.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
    }
}