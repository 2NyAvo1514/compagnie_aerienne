package com.airline.manage.dto;

public class ReservationDTO {
    private Integer avionVolId;
    private String nomClient;
    private String emailClient;
    private Integer nbPlaces;

    // Constructeurs
    public ReservationDTO() {
    }

    public ReservationDTO(Integer avionVolId, String nomClient, String emailClient, Integer nbPlaces) {
        this.avionVolId = avionVolId;
        this.nomClient = nomClient;
        this.emailClient = emailClient;
        this.nbPlaces = nbPlaces;
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

    // Méthode toString pour le débogage
    @Override
    public String toString() {
        return "ReservationDTO{" +
                "avionVolId=" + avionVolId +
                ", nomClient='" + nomClient + '\'' +
                ", emailClient='" + emailClient + '\'' +
                ", nbPlaces=" + nbPlaces +
                '}';
    }
}