package com.airline.manage.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ResultatVolDTO {
    private Long avionVolId;
    private String aeroportDepart;
    private String aeroportArrivee;
    private String villeDepart;
    private String villeArrivee;
    private LocalDateTime dateHeure;
    private String nomAvion;
    private String modeleAvion;
    private Integer capacite;
    private Integer placesDisponibles;

    // Constructeurs
    public ResultatVolDTO() {
    }

    public ResultatVolDTO(Long avionVolId, String aeroportDepart, String aeroportArrivee,
            String villeDepart, String villeArrivee, LocalDateTime dateHeure,
            String nomAvion, String modeleAvion, Integer capacite,
            Integer placesDisponibles) {
        this.avionVolId = avionVolId;
        this.aeroportDepart = aeroportDepart != null ? aeroportDepart : "";
        this.aeroportArrivee = aeroportArrivee != null ? aeroportArrivee : "";
        this.villeDepart = villeDepart != null ? villeDepart : "";
        this.villeArrivee = villeArrivee != null ? villeArrivee : "";
        this.dateHeure = dateHeure;
        this.nomAvion = nomAvion != null ? nomAvion : "";
        this.modeleAvion = modeleAvion != null ? modeleAvion : "";
        this.capacite = capacite != null ? capacite : 0;
        this.placesDisponibles = placesDisponibles != null ? placesDisponibles : 0;
    }

    // Getters et Setters
    public Long getAvionVolId() {
        return avionVolId;
    }

    public void setAvionVolId(Long avionVolId) {
        this.avionVolId = avionVolId;
    }

    public String getAeroportDepart() {
        return aeroportDepart != null ? aeroportDepart : "";
    }

    public void setAeroportDepart(String aeroportDepart) {
        this.aeroportDepart = aeroportDepart != null ? aeroportDepart : "";
    }

    public String getAeroportArrivee() {
        return aeroportArrivee != null ? aeroportArrivee : "";
    }

    public void setAeroportArrivee(String aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee != null ? aeroportArrivee : "";
    }

    public String getVilleDepart() {
        return villeDepart != null ? villeDepart : "";
    }

    public void setVilleDepart(String villeDepart) {
        this.villeDepart = villeDepart != null ? villeDepart : "";
    }

    public String getVilleArrivee() {
        return villeArrivee != null ? villeArrivee : "";
    }

    public void setVilleArrivee(String villeArrivee) {
        this.villeArrivee = villeArrivee != null ? villeArrivee : "";
    }

    public LocalDateTime getDateHeure() {
        return dateHeure;
    }

    public void setDateHeure(LocalDateTime dateHeure) {
        this.dateHeure = dateHeure;
    }

    public String getNomAvion() {
        return nomAvion != null ? nomAvion : "";
    }

    public void setNomAvion(String nomAvion) {
        this.nomAvion = nomAvion != null ? nomAvion : "";
    }

    public String getModeleAvion() {
        return modeleAvion != null ? modeleAvion : "";
    }

    public void setModeleAvion(String modeleAvion) {
        this.modeleAvion = modeleAvion != null ? modeleAvion : "";
    }

    public Integer getCapacite() {
        return capacite != null ? capacite : 0;
    }

    public void setCapacite(Integer capacite) {
        this.capacite = capacite != null ? capacite : 0;
    }

    public Integer getPlacesDisponibles() {
        return placesDisponibles != null ? placesDisponibles : 0;
    }

    public void setPlacesDisponibles(Integer placesDisponibles) {
        this.placesDisponibles = placesDisponibles != null ? placesDisponibles : 0;
    }

    // Méthodes de formatage avec vérifications de null
    public String getFormattedTime() {
        if (dateHeure == null)
            return "N/A";
        try {
            return dateHeure.format(DateTimeFormatter.ofPattern("HH:mm"));
        } catch (Exception e) {
            return "N/A";
        }
    }

    public String getFormattedDate() {
        if (dateHeure == null)
            return "N/A";
        try {
            return dateHeure.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        } catch (Exception e) {
            return "N/A";
        }
    }

    public String getFormattedDateTime() {
        if (dateHeure == null)
            return "N/A";
        try {
            return dateHeure.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        } catch (Exception e) {
            return "N/A";
        }
    }

    public String getHtmlDate() {
        if (dateHeure == null)
            return "";
        try {
            return dateHeure.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
        } catch (Exception e) {
            return "";
        }
    }

    // Méthode pour vérifier si la date/heure existe
    public boolean hasDateHeure() {
        return dateHeure != null;
    }

    // Méthode pour comparer les dates en sécurité
    public boolean isBeforeNow() {
        if (dateHeure == null)
            return false;
        try {
            return dateHeure.isBefore(LocalDateTime.now());
        } catch (Exception e) {
            return false;
        }
    }

    public boolean isWithinNextHours(int hours) {
        if (dateHeure == null)
            return false;
        try {
            LocalDateTime now = LocalDateTime.now();
            LocalDateTime limit = now.plusHours(hours);
            return dateHeure.isAfter(now) && dateHeure.isBefore(limit);
        } catch (Exception e) {
            return false;
        }
    }
}