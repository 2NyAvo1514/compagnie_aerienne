package com.airline.manage.dto;

import java.time.LocalDateTime;

public class RechercheVolDTO {
    private Integer aeroportDepartId;
    private Integer aeroportArriveeId;
    private LocalDateTime dateDebut;
    private LocalDateTime dateFin;

    // Constructeurs
    public RechercheVolDTO() {
    }

    public RechercheVolDTO(Integer aeroportDepartId, Integer aeroportArriveeId,
            LocalDateTime dateDebut, LocalDateTime dateFin) {
        this.aeroportDepartId = aeroportDepartId;
        this.aeroportArriveeId = aeroportArriveeId;
        this.dateDebut = dateDebut;
        this.dateFin = dateFin;
    }

    // Getters et Setters
    public Integer getAeroportDepartId() {
        return aeroportDepartId;
    }

    public void setAeroportDepartId(Integer aeroportDepartId) {
        this.aeroportDepartId = aeroportDepartId;
    }

    public Integer getAeroportArriveeId() {
        return aeroportArriveeId;
    }

    public void setAeroportArriveeId(Integer aeroportArriveeId) {
        this.aeroportArriveeId = aeroportArriveeId;
    }

    public LocalDateTime getDateDebut() {
        return dateDebut;
    }

    public void setDateDebut(LocalDateTime dateDebut) {
        this.dateDebut = dateDebut;
    }

    public LocalDateTime getDateFin() {
        return dateFin;
    }

    public void setDateFin(LocalDateTime dateFin) {
        this.dateFin = dateFin;
    }

    // Méthode toString pour le débogage
    @Override
    public String toString() {
        return "RechercheVolDTO{" +
                "aeroportDepartId=" + aeroportDepartId +
                ", aeroportArriveeId=" + aeroportArriveeId +
                ", dateDebut=" + dateDebut +
                ", dateFin=" + dateFin +
                '}';
    }
}