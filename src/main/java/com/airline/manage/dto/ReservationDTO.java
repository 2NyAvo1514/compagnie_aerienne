package com.airline.manage.dto;

public class ReservationDTO {
    private Long avionVolId;
    private String nomClient;
    private String emailClient;
    private Integer nbPlaces;

    // Constructeurs
    public ReservationDTO() {
    }

    public ReservationDTO(Long avionVolId, String nomClient, String emailClient, Integer nbPlaces) {
        this.avionVolId = avionVolId;
        this.nomClient = nomClient;
        this.emailClient = emailClient;
        this.nbPlaces = nbPlaces;
    }

    // Getters et Setters
    public Long getAvionVolId() {
        return avionVolId;
    }

    public void setAvionVolId(Long avionVolId) {
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
}