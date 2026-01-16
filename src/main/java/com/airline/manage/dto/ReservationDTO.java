package com.airline.manage.dto;

public class ReservationDTO {

    private Integer avionVolId;
    private String nomClient;
    private String emailClient;
    private Integer nbPlaces;

    private Integer idCategoriePassager;
    private Integer idPlace;

    // Constructeurs
    public ReservationDTO() {
    }

    public ReservationDTO(Integer avionVolId,
                          String nomClient,
                          String emailClient,
                          Integer nbPlaces,
                          Integer idCategoriePassager,
                          Integer idPlace) {
        this.avionVolId = avionVolId;
        this.nomClient = nomClient;
        this.emailClient = emailClient;
        this.nbPlaces = nbPlaces;
        this.idCategoriePassager = idCategoriePassager;
        this.idPlace = idPlace;
    }

    // Getters et Setters
    public Integer getAvionVolId() {
        return avionVolId;
    }

    public void setAvionVolId(Integer avionVolId) {
        this.avionVolId = avionVolId;
    }

    public String getNomClient() {
        return nomClient;
    }

    public void setNomClient(String nomClient) {
        this.nomClient = nomClient;
    }

    public String getEmailClient() {
        return emailClient;
    }

    public void setEmailClient(String emailClient) {
        this.emailClient = emailClient;
    }

    public Integer getNbPlaces() {
        return nbPlaces;
    }

    public void setNbPlaces(Integer nbPlaces) {
        this.nbPlaces = nbPlaces;
    }

    public Integer getIdCategoriePassager() {
        return idCategoriePassager;
    }

    public void setIdCategoriePassager(Integer idCategoriePassager) {
        this.idCategoriePassager = idCategoriePassager;
    }

    public Integer getIdPlace() {
        return idPlace;
    }

    public void setIdPlace(Integer idPlace) {
        this.idPlace = idPlace;
    }

    @Override
    public String toString() {
        return "ReservationDTO{" +
                "avionVolId=" + avionVolId +
                ", nomClient='" + nomClient + '\'' +
                ", emailClient='" + emailClient + '\'' +
                ", nbPlaces=" + nbPlaces +
                ", idCategoriePassager=" + idCategoriePassager +
                ", idPlace=" + idPlace +
                '}';
    }
}
