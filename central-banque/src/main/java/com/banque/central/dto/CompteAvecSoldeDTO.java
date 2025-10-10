package com.banque.central.dto;

import java.io.Serializable;
import java.math.BigDecimal;

public class CompteAvecSoldeDTO implements Serializable {
    private Long idCompte;
    private String numeroCompte;
    private String nomClient;
    private String prenomClient;
    private String nomTypeCompte;
    private BigDecimal solde;
    private Boolean actif;
    
    // Constructeurs
    public CompteAvecSoldeDTO() {}
    
    public CompteAvecSoldeDTO(Long idCompte, String numeroCompte, String nomClient, 
                             String prenomClient, String nomTypeCompte, BigDecimal solde, Boolean actif) {
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
    
    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }
    
    public String getPrenomClient() { return prenomClient; }
    public void setPrenomClient(String prenomClient) { this.prenomClient = prenomClient; }
    
    public String getNomTypeCompte() { return nomTypeCompte; }
    public void setNomTypeCompte(String nomTypeCompte) { this.nomTypeCompte = nomTypeCompte; }
    
    public BigDecimal getSolde() { return solde; }
    public void setSolde(BigDecimal solde) { this.solde = solde; }
    
    public Boolean getActif() { return actif; }
    public void setActif(Boolean actif) { this.actif = actif; }
    
    // Méthode utilitaire pour l'affichage
    public String getAffichageComplet() {
        return numeroCompte + " - " + prenomClient + " " + nomClient;
    }
    
    @Override
    public String toString() {
        return "CompteAvecSoldeDTO{" +
                "idCompte=" + idCompte +
                ", numeroCompte='" + numeroCompte + '\'' +
                ", nomClient='" + nomClient + '\'' +
                ", prenomClient='" + prenomClient + '\'' +
                ", solde=" + solde +
                '}';
    }
}
