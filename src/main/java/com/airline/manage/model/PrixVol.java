package com.airline.manage.model;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "prix_vol")
public class PrixVol {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_avion_vol", nullable = false)
    private AvionVol avionVol;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_place", nullable = false)
    private Place place;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "id_categoriepassager", nullable = false)
    private CategoriePassager categoriePassager;

    @Column(name = "prix", nullable = false, precision = 12, scale = 2)
    private BigDecimal prix;

    // Constructeurs
    public PrixVol() {
    }

    public PrixVol(AvionVol avionVol,
                   Place place,
                   CategoriePassager categoriePassager,
                   BigDecimal prix) {
        this.avionVol = avionVol;
        this.place = place;
        this.categoriePassager = categoriePassager;
        this.prix = prix;
    }

    // Getters et Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public AvionVol getAvionVol() {
        return avionVol;
    }

    public void setAvionVol(AvionVol avionVol) {
        this.avionVol = avionVol;
    }

    public Place getPlace() {
        return place;
    }

    public void setPlace(Place place) {
        this.place = place;
    }

    public CategoriePassager getCategoriePassager() {
        return categoriePassager;
    }

    public void setCategoriePassager(CategoriePassager categoriePassager) {
        this.categoriePassager = categoriePassager;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }

    // Méthode utilitaire pour formater le prix
    public String getPrixFormatted() {
        return String.format("%,.2f Ar", prix);
    }

    @Override
    public String toString() {
        return "PrixVol{" +
                "id=" + id +
                ", avionVol=" + (avionVol != null ? avionVol.getId() : null) +
                ", place=" + (place != null ? place.getId() : null) +
                ", categoriePassager=" + (categoriePassager != null ? categoriePassager.getId() : null) +
                ", prix=" + prix +
                '}';
    }
}
