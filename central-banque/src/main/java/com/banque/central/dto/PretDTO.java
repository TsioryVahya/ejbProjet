package com.banque.central.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

@JsonIgnoreProperties(ignoreUnknown = true, value = {"tauxPret", "compte", "remboursements"})
public class PretDTO implements Serializable {
    private Long idPret;
    private Integer duree;
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    private LocalDateTime datePret;
    private BigDecimal montantInitial;
    private BigDecimal montantRestant;
    private String statut;
    @JsonIgnore
    private BigDecimal tauxPret;
    private BigDecimal tauxPourcentage; // Nouveau champ pour le taux depuis l'API
    private Long idTaux;
    private Long idCompte;
    private String numeroCompte;
    private String nomClient;
    private String prenomClient;
    private BigDecimal mensualite;
    private BigDecimal montantTotal;
    private BigDecimal interetsTotal;
    private Integer nombreRemboursementsEffectues;
    private Integer remboursementsRestants;
    
    // Constructeurs
    public PretDTO() {}
    
    public PretDTO(Long idPret, Integer duree, LocalDateTime datePret, BigDecimal montantInitial, 
                  BigDecimal montantRestant, String statut, BigDecimal tauxPret, Long idCompte, String numeroCompte) {
        this.idPret = idPret;
        this.duree = duree;
        this.datePret = datePret;
        this.montantInitial = montantInitial;
        this.montantRestant = montantRestant;
        this.statut = statut;
        this.tauxPret = tauxPret;
        this.idCompte = idCompte;
        this.numeroCompte = numeroCompte;
    }
    
    // Getters et Setters
    public Long getIdPret() { return idPret; }
    public void setIdPret(Long idPret) { this.idPret = idPret; }
    
    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }
    
    public LocalDateTime getDatePret() { return datePret; }
    public void setDatePret(LocalDateTime datePret) { this.datePret = datePret; }
    
    public BigDecimal getMontantInitial() { return montantInitial; }
    public void setMontantInitial(BigDecimal montantInitial) { this.montantInitial = montantInitial; }
    
    public BigDecimal getMontantRestant() { return montantRestant; }
    public void setMontantRestant(BigDecimal montantRestant) { this.montantRestant = montantRestant; }
    
    public String getStatut() { return statut; }
    public void setStatut(String statut) { this.statut = statut; }
    
    public BigDecimal getTauxPret() { return tauxPret; }
    public void setTauxPret(BigDecimal tauxPret) { this.tauxPret = tauxPret; }
    
    public Long getIdTaux() { return idTaux; }
    public void setIdTaux(Long idTaux) { this.idTaux = idTaux; }
    
    public Long getIdCompte() { return idCompte; }
    public void setIdCompte(Long idCompte) { this.idCompte = idCompte; }
    
    public String getNumeroCompte() { return numeroCompte; }
    public void setNumeroCompte(String numeroCompte) { this.numeroCompte = numeroCompte; }
    
    public BigDecimal getTauxPourcentage() { return tauxPourcentage; }
    public void setTauxPourcentage(BigDecimal tauxPourcentage) { this.tauxPourcentage = tauxPourcentage; }
    
    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }
    
    public String getPrenomClient() { return prenomClient; }
    public void setPrenomClient(String prenomClient) { this.prenomClient = prenomClient; }
    
    public BigDecimal getMensualite() { return mensualite; }
    public void setMensualite(BigDecimal mensualite) { this.mensualite = mensualite; }
    
    public BigDecimal getMontantTotal() { return montantTotal; }
    public void setMontantTotal(BigDecimal montantTotal) { this.montantTotal = montantTotal; }
    
    public BigDecimal getInteretsTotal() { return interetsTotal; }
    public void setInteretsTotal(BigDecimal interetsTotal) { this.interetsTotal = interetsTotal; }
    
    public Integer getNombreRemboursementsEffectues() { return nombreRemboursementsEffectues; }
    public void setNombreRemboursementsEffectues(Integer nombreRemboursementsEffectues) { this.nombreRemboursementsEffectues = nombreRemboursementsEffectues; }
    
    public Integer getRemboursementsRestants() { return remboursementsRestants; }
    public void setRemboursementsRestants(Integer remboursementsRestants) { this.remboursementsRestants = remboursementsRestants; }
    
    // Méthodes utilitaires
    public boolean isActif() {
        return "ACTIF".equals(statut);
    }
    
    public boolean isRembourse() {
        return "REMBOURSE".equals(statut);
    }
    
    public BigDecimal getPourcentageRembourse() {
        if (montantInitial == null || montantInitial.compareTo(BigDecimal.ZERO) == 0) {
            return BigDecimal.ZERO;
        }
        BigDecimal montantRembourse = montantInitial.subtract(montantRestant != null ? montantRestant : BigDecimal.ZERO);
        return montantRembourse.divide(montantInitial, 4, BigDecimal.ROUND_HALF_UP).multiply(BigDecimal.valueOf(100));
    }
    
    // Méthode utilitaire pour convertir LocalDateTime en Date pour les JSP
    public Date getDatePretAsDate() {
        if (datePret == null) {
            return null;
        }
        return Date.from(datePret.atZone(ZoneId.systemDefault()).toInstant());
    }
    
    @Override
    public String toString() {
        return "PretDTO{" +
                "idPret=" + idPret +
                ", duree=" + duree +
                ", datePret=" + datePret +
                ", montantInitial=" + montantInitial +
                ", montantRestant=" + montantRestant +
                ", statut='" + statut + '\'' +
                ", tauxPret=" + tauxPret +
                ", numeroCompte='" + numeroCompte + '\'' +
                '}';
    }
}

