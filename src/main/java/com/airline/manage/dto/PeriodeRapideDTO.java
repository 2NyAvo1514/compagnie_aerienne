package com.airline.manage.dto;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class PeriodeRapideDTO {
    private String nom;
    private LocalDate debut;
    private LocalDate fin;
    private String code;

    // Constructeurs
    public PeriodeRapideDTO() {
    }

    public PeriodeRapideDTO(String nom, LocalDate debut, LocalDate fin) {
        this.nom = nom;
        this.debut = debut;
        this.fin = fin;
    }

    public PeriodeRapideDTO(String nom, LocalDate debut, LocalDate fin, String code) {
        this.nom = nom;
        this.debut = debut;
        this.fin = fin;
        this.code = code;
    }

    // Getters et Setters
    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public LocalDate getDebut() {
        return debut;
    }

    public void setDebut(LocalDate debut) {
        this.debut = debut;
    }

    public LocalDate getFin() {
        return fin;
    }

    public void setFin(LocalDate fin) {
        this.fin = fin;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    // Méthodes utilitaires pour les formats de date

    public String getDebutFormatISO() {
        if (debut == null)
            return "";
        return debut.format(DateTimeFormatter.ISO_DATE);
    }

    public String getFinFormatISO() {
        if (fin == null)
            return "";
        return fin.format(DateTimeFormatter.ISO_DATE);
    }

    public String getDebutFormatFR() {
        if (debut == null)
            return "";
        return debut.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getFinFormatFR() {
        if (fin == null)
            return "";
        return fin.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
    }

    public String getPeriodeFormattee() {
        if (debut == null || fin == null)
            return "";
        return getDebutFormatFR() + " au " + getFinFormatFR();
    }

    public int getNombreJours() {
        if (debut == null || fin == null)
            return 0;
        return (int) java.time.temporal.ChronoUnit.DAYS.between(debut, fin) + 1;
    }

    // Méthode pour vérifier si une date est dans la période
    public boolean contientDate(LocalDate date) {
        if (debut == null || fin == null || date == null)
            return false;
        return !date.isBefore(debut) && !date.isAfter(fin);
    }

    // Méthode pour créer des périodes rapides prédéfinies
    public static PeriodeRapideDTO aujourdhui() {
        LocalDate aujourdhui = LocalDate.now();
        return new PeriodeRapideDTO("Aujourd'hui", aujourdhui, aujourdhui, "TODAY");
    }

    public static PeriodeRapideDTO hier() {
        LocalDate hier = LocalDate.now().minusDays(1);
        return new PeriodeRapideDTO("Hier", hier, hier, "YESTERDAY");
    }

    public static PeriodeRapideDTO cetteSemaine() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate debutSemaine = aujourdhui.minusDays(aujourdhui.getDayOfWeek().getValue() - 1);
        return new PeriodeRapideDTO("Cette semaine", debutSemaine, aujourdhui, "THIS_WEEK");
    }

    public static PeriodeRapideDTO semaineDerniere() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate debutSemaineDerniere = aujourdhui.minusDays(aujourdhui.getDayOfWeek().getValue() + 6);
        LocalDate finSemaineDerniere = aujourdhui.minusDays(aujourdhui.getDayOfWeek().getValue());
        return new PeriodeRapideDTO("Semaine dernière", debutSemaineDerniere, finSemaineDerniere, "LAST_WEEK");
    }

    public static PeriodeRapideDTO ceMois() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate debutMois = aujourdhui.withDayOfMonth(1);
        return new PeriodeRapideDTO("Ce mois", debutMois, aujourdhui, "THIS_MONTH");
    }

    public static PeriodeRapideDTO moisDernier() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate debutMoisDernier = aujourdhui.minusMonths(1).withDayOfMonth(1);
        LocalDate finMoisDernier = aujourdhui.withDayOfMonth(1).minusDays(1);
        return new PeriodeRapideDTO("Mois dernier", debutMoisDernier, finMoisDernier, "LAST_MONTH");
    }

    public static PeriodeRapideDTO cetteAnnee() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate debutAnnee = LocalDate.of(aujourdhui.getYear(), 1, 1);
        return new PeriodeRapideDTO("Cette année", debutAnnee, aujourdhui, "THIS_YEAR");
    }

    public static PeriodeRapideDTO anneeDerniere() {
        LocalDate aujourdhui = LocalDate.now();
        int anneeDerniere = aujourdhui.getYear() - 1;
        LocalDate debutAnneeDerniere = LocalDate.of(anneeDerniere, 1, 1);
        LocalDate finAnneeDerniere = LocalDate.of(anneeDerniere, 12, 31);
        return new PeriodeRapideDTO("Année dernière", debutAnneeDerniere, finAnneeDerniere, "LAST_YEAR");
    }

    public static PeriodeRapideDTO dernieres24Heures() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate hier = aujourdhui.minusDays(1);
        return new PeriodeRapideDTO("Dernières 24h", hier, aujourdhui, "LAST_24H");
    }

    public static PeriodeRapideDTO derniers7Jours() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate ilYA7Jours = aujourdhui.minusDays(6); // Inclut aujourd'hui
        return new PeriodeRapideDTO("7 derniers jours", ilYA7Jours, aujourdhui, "LAST_7D");
    }

    public static PeriodeRapideDTO derniers30Jours() {
        LocalDate aujourdhui = LocalDate.now();
        LocalDate ilYA30Jours = aujourdhui.minusDays(29); // Inclut aujourd'hui
        return new PeriodeRapideDTO("30 derniers jours", ilYA30Jours, aujourdhui, "LAST_30D");
    }

    public static PeriodeRapideDTO trimestreEnCours() {
        LocalDate aujourdhui = LocalDate.now();
        int mois = aujourdhui.getMonthValue();
        int trimestre = (mois - 1) / 3 + 1;
        int moisDebut = (trimestre - 1) * 3 + 1;

        LocalDate debutTrimestre = LocalDate.of(aujourdhui.getYear(), moisDebut, 1);
        LocalDate finTrimestre = debutTrimestre.plusMonths(3).minusDays(1);
        if (finTrimestre.isAfter(aujourdhui)) {
            finTrimestre = aujourdhui;
        }

        return new PeriodeRapideDTO("Trimestre en cours", debutTrimestre, finTrimestre, "CURRENT_QUARTER");
    }

    // Méthode pour obtenir toutes les périodes rapides
    public static java.util.List<PeriodeRapideDTO> toutesLesPeriodesRapides() {
        java.util.List<PeriodeRapideDTO> periodes = new java.util.ArrayList<>();

        periodes.add(aujourdhui());
        periodes.add(hier());
        periodes.add(dernieres24Heures());
        periodes.add(derniers7Jours());
        periodes.add(derniers30Jours());
        periodes.add(cetteSemaine());
        periodes.add(semaineDerniere());
        periodes.add(ceMois());
        periodes.add(moisDernier());
        periodes.add(trimestreEnCours());
        periodes.add(cetteAnnee());
        periodes.add(anneeDerniere());

        return periodes;
    }

    // Méthode pour trouver une période par son code
    public static PeriodeRapideDTO parCode(String code) {
        for (PeriodeRapideDTO periode : toutesLesPeriodesRapides()) {
            if (periode.getCode() != null && periode.getCode().equals(code)) {
                return periode;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return "PeriodeRapideDTO{" +
                "nom='" + nom + '\'' +
                ", debut=" + debut +
                ", fin=" + fin +
                ", code='" + code + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o)
            return true;
        if (o == null || getClass() != o.getClass())
            return false;

        PeriodeRapideDTO that = (PeriodeRapideDTO) o;

        if (debut != null ? !debut.equals(that.debut) : that.debut != null)
            return false;
        if (fin != null ? !fin.equals(that.fin) : that.fin != null)
            return false;
        return code != null ? code.equals(that.code) : that.code == null;
    }

    @Override
    public int hashCode() {
        int result = debut != null ? debut.hashCode() : 0;
        result = 31 * result + (fin != null ? fin.hashCode() : 0);
        result = 31 * result + (code != null ? code.hashCode() : 0);
        return result;
    }
}
