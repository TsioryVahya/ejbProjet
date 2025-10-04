package com.banque.central.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class CompteDTO implements Serializable {
    private Long idCompte;
    private String numeroCompte;
    private LocalDateTime dateCreation;
    private LocalDateTime dateModification;
    private Boolean actif;
    private BigDecimal solde;
    
    // Informations client
    private Long idClient;
    private String nomClient;
    private String prenomClient;
    private String emailClient;
    private String telephoneClient;
    
    // Informations type de compte
    private Long idTypeCompte;
    private String nomTypeCompte;
    private String descriptionTypeCompte;
    
    // Constructeurs
    public CompteDTO() {}
    
    public CompteDTO(Long idCompte, String numeroCompte, String nomClient, String prenomClient, 
                     String nomTypeCompte, BigDecimal solde, Boolean actif) {
        this.idCompte = idCompte;
        this.numeroCompte = numeroCompte;
        this.nomClient = nomClient;
        this.prenomClient = prenomClient;
        this.nomTypeCompte = nomTypeCompte;
        this.solde = solde;
        this.actif = actif;
    }
    
    // Getters et Setters
    public Long getIdCompte() { return idCompte; }
    public void setIdCompte(Long idCompte) { this.idCompte = idCompte; }
    
    public String getNumeroCompte() { return numeroCompte; }
    public void setNumeroCompte(String numeroCompte) { this.numeroCompte = numeroCompte; }
    
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
    
    public LocalDateTime getDateModification() { return dateModification; }
    public void setDateModification(LocalDateTime dateModification) { this.dateModification = dateModification; }
    
    public Boolean getActif() { return actif; }
    public void setActif(Boolean actif) { this.actif = actif; }
    
    public BigDecimal getSolde() { return solde; }
    public void setSolde(BigDecimal solde) { this.solde = solde; }
    
    public Long getIdClient() { return idClient; }
    public void setIdClient(Long idClient) { this.idClient = idClient; }
    
    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }
    
    public String getPrenomClient() { return prenomClient; }
    public void setPrenomClient(String prenomClient) { this.prenomClient = prenomClient; }
    
    public String getEmailClient() { return emailClient; }
    public void setEmailClient(String emailClient) { this.emailClient = emailClient; }
    
    public String getTelephoneClient() { return telephoneClient; }
    public void setTelephoneClient(String telephoneClient) { this.telephoneClient = telephoneClient; }
    
    public Long getIdTypeCompte() { return idTypeCompte; }
    public void setIdTypeCompte(Long idTypeCompte) { this.idTypeCompte = idTypeCompte; }
    
    public String getNomTypeCompte() { return nomTypeCompte; }
    public void setNomTypeCompte(String nomTypeCompte) { this.nomTypeCompte = nomTypeCompte; }
    
    public String getDescriptionTypeCompte() { return descriptionTypeCompte; }
    public void setDescriptionTypeCompte(String descriptionTypeCompte) { this.descriptionTypeCompte = descriptionTypeCompte; }
    
    public String getNomCompletClient() {
        return (nomClient != null ? nomClient : "") + " " + (prenomClient != null ? prenomClient : "");
    }
    
    // Méthodes utilitaires pour la conversion de dates (compatibilité JSP)
    public Date getDateCreationAsDate() {
        return dateCreation != null ? Date.from(dateCreation.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public Date getDateModificationAsDate() {
        return dateModification != null ? Date.from(dateModification.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public String getDateCreationFormatted() {
        return dateCreation != null ? dateCreation.toString() : "";
    }
    
    public String getDateModificationFormatted() {
        return dateModification != null ? dateModification.toString() : "";
    }

    @Override
    public String toString() {
        return "CompteDTO{" +
                "idCompte=" + idCompte +
                ", numeroCompte='" + numeroCompte + '\'' +
                ", nomClient='" + nomClient + '\'' +
                ", prenomClient='" + prenomClient + '\'' +
                ", nomTypeCompte='" + nomTypeCompte + '\'' +
                ", solde=" + solde +
                ", actif=" + actif +
                '}';
    }
}
