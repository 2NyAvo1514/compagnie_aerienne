package com.airline.manage.dto;

import java.math.BigDecimal;

public class ChiffreAffairesDTO {
    private Integer avionId;
    private String avionNom;
    private String avionModele;
    private Integer nombreReservations;
    private Integer placesVendues;
    private BigDecimal chiffreAffaires;

    // Constructeurs
    public ChiffreAffairesDTO() {
    }

    public ChiffreAffairesDTO(Integer avionId, String avionNom, String avionModele,
            Integer nombreReservations, Integer placesVendues,
            BigDecimal chiffreAffaires) {
        this.avionId = avionId;
        this.avionNom = avionNom;
        this.avionModele = avionModele;
        this.nombreReservations = nombreReservations;
        this.placesVendues = placesVendues;
        this.chiffreAffaires = chiffreAffaires;
    }

    // Getters et Setters
    public Integer getAvionId() {
        return avionId;
    }

    public void setAvionId(Integer avionId) {
        this.avionId = avionId;
    }

    public String getAvionNom() {
        return avionNom;
    }

    public void setAvionNom(String avionNom) {
        this.avionNom = avionNom;
    }

    public String getAvionModele() {
        return avionModele;
    }

    public void setAvionModele(String avionModele) {
        this.avionModele = avionModele;
    }

    public Integer getNombreReservations() {
        return nombreReservations;
    }

    public void setNombreReservations(Integer nombreReservations) {
        this.nombreReservations = nombreReservations;
    }

    public Integer getPlacesVendues() {
        return placesVendues;
    }

    public void setPlacesVendues(Integer placesVendues) {
        this.placesVendues = placesVendues;
    }

    public BigDecimal getChiffreAffaires() {
        return chiffreAffaires;
    }

    public void setChiffreAffaires(BigDecimal chiffreAffaires) {
        this.chiffreAffaires = chiffreAffaires;
    }

    // Méthode pour formater le chiffre d'affaires
    public String getChiffreAffairesFormatted() {
        if (chiffreAffaires == null)
            return "0.00 Ar";
        return String.format("%,.2f Ar", chiffreAffaires);
    }
}
