package com.airline.manage.dto;

import java.math.BigDecimal;

public class ChiffreAffairesTrajetDTO {
    private Integer trajetId;
    private String aeroportDepart;
    private String villeDepart;
    private String aeroportArrivee;
    private String villeArrivee;
    private Long nombreVols;          // Changé de Integer à Long
    private Long nombreReservations;  // Changé de Integer à Long
    private Long placesVendues;       // Changé de Integer à Long
    private BigDecimal chiffreAffaires;
    private BigDecimal prixMoyen;
    
    // Constructeurs
    public ChiffreAffairesTrajetDTO() {}
    
    public ChiffreAffairesTrajetDTO(Integer trajetId, String aeroportDepart, String villeDepart, 
                                   String aeroportArrivee, String villeArrivee, 
                                   Long nombreVols, Long nombreReservations, 
                                   Long placesVendues, BigDecimal chiffreAffaires, 
                                   BigDecimal prixMoyen) {
        this.trajetId = trajetId;
        this.aeroportDepart = aeroportDepart;
        this.villeDepart = villeDepart;
        this.aeroportArrivee = aeroportArrivee;
        this.villeArrivee = villeArrivee;
        this.nombreVols = nombreVols;
        this.nombreReservations = nombreReservations;
        this.placesVendues = placesVendues;
        this.chiffreAffaires = chiffreAffaires;
        this.prixMoyen = prixMoyen;
    }
    
    // Constructeur alternatif avec des types primitifs
    public ChiffreAffairesTrajetDTO(Integer trajetId, String aeroportDepart, String villeDepart, 
                                   String aeroportArrivee, String villeArrivee, 
                                   long nombreVols, long nombreReservations, 
                                   long placesVendues, BigDecimal chiffreAffaires, 
                                   BigDecimal prixMoyen) {
        this(trajetId, aeroportDepart, villeDepart, aeroportArrivee, villeArrivee,
             Long.valueOf(nombreVols), Long.valueOf(nombreReservations), 
             Long.valueOf(placesVendues), chiffreAffaires, prixMoyen);
    }
    
    // Getters et Setters
    public Integer getTrajetId() {
        return trajetId;
    }
    
    public void setTrajetId(Integer trajetId) {
        this.trajetId = trajetId;
    }
    
    public String getAeroportDepart() {
        return aeroportDepart;
    }
    
    public void setAeroportDepart(String aeroportDepart) {
        this.aeroportDepart = aeroportDepart;
    }
    
    public String getVilleDepart() {
        return villeDepart;
    }
    
    public void setVilleDepart(String villeDepart) {
        this.villeDepart = villeDepart;
    }
    
    public String getAeroportArrivee() {
        return aeroportArrivee;
    }
    
    public void setAeroportArrivee(String aeroportArrivee) {
        this.aeroportArrivee = aeroportArrivee;
    }
    
    public String getVilleArrivee() {
        return villeArrivee;
    }
    
    public void setVilleArrivee(String villeArrivee) {
        this.villeArrivee = villeArrivee;
    }
    
    public Long getNombreVols() {
        return nombreVols != null ? nombreVols : 0L;
    }
    
    public void setNombreVols(Long nombreVols) {
        this.nombreVols = nombreVols;
    }
    
    public Long getNombreReservations() {
        return nombreReservations != null ? nombreReservations : 0L;
    }
    
    public void setNombreReservations(Long nombreReservations) {
        this.nombreReservations = nombreReservations;
    }
    
    public Long getPlacesVendues() {
        return placesVendues != null ? placesVendues : 0L;
    }
    
    public void setPlacesVendues(Long placesVendues) {
        this.placesVendues = placesVendues;
    }
    
    public BigDecimal getChiffreAffaires() {
        return chiffreAffaires != null ? chiffreAffaires : BigDecimal.ZERO;
    }
    
    public void setChiffreAffaires(BigDecimal chiffreAffaires) {
        this.chiffreAffaires = chiffreAffaires;
    }
    
    public BigDecimal getPrixMoyen() {
        return prixMoyen != null ? prixMoyen : BigDecimal.ZERO;
    }
    
    public void setPrixMoyen(BigDecimal prixMoyen) {
        this.prixMoyen = prixMoyen;
    }
    
    // Méthodes utilitaires pour JSP
    public String getTrajetComplet() {
        return (villeDepart != null ? villeDepart : "") + " → " + (villeArrivee != null ? villeArrivee : "");
    }
    
    public String getAeroportsComplets() {
        return (aeroportDepart != null ? aeroportDepart : "") + " → " + (aeroportArrivee != null ? aeroportArrivee : "");
    }
    
    public String getChiffreAffairesFormatted() {
        return String.format("%,.2f Ar", getChiffreAffaires());
    }
    
    public String getPrixMoyenFormatted() {
        return String.format("%,.2f Ar", getPrixMoyen());
    }
    
    public Integer getNombreVolsInt() {
        return getNombreVols().intValue();
    }
    
    public Integer getNombreReservationsInt() {
        return getNombreReservations().intValue();
    }
    
    public Integer getPlacesVenduesInt() {
        return getPlacesVendues().intValue();
    }
    
    public BigDecimal getTauxRemplissage(Long capaciteTotale) {
        if (capaciteTotale == null || capaciteTotale == 0) return BigDecimal.ZERO;
        if (getPlacesVendues() == 0) return BigDecimal.ZERO;
        
        return BigDecimal.valueOf(getPlacesVendues())
                .multiply(BigDecimal.valueOf(100))
                .divide(BigDecimal.valueOf(capaciteTotale), 2, BigDecimal.ROUND_HALF_UP);
    }
}