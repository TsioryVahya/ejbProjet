package com.banque.central.dto;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class ClientDTO implements Serializable {
    private Long idClient;
    private String nom;
    private String prenom;
    private String telephone;
    private String email;
    private LocalDateTime dateCreation;
    private LocalDateTime dateModification;
    
    // Constructeurs
    public ClientDTO() {}
    
    public ClientDTO(Long idClient, String nom, String prenom, String telephone, String email, LocalDateTime dateCreation) {
        this.idClient = idClient;
        this.nom = nom;
        this.prenom = prenom;
        this.telephone = telephone;
        this.email = email;
        this.dateCreation = dateCreation;
    }
    
    // Getters et Setters
    public Long getIdClient() { return idClient; }
    public void setIdClient(Long idClient) { this.idClient = idClient; }
    
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    
    public String getTelephone() { return telephone; }
    public void setTelephone(String telephone) { this.telephone = telephone; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
    
    public LocalDateTime getDateModification() { return dateModification; }
    public void setDateModification(LocalDateTime dateModification) { this.dateModification = dateModification; }
    
    // Méthodes utilitaires pour la conversion de dates (compatibilité JSP)
    public Date getDateCreationAsDate() {
        return dateCreation != null ? Date.from(dateCreation.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public Date getDateModificationAsDate() {
        return dateModification != null ? Date.from(dateModification.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public String getNomComplet() {
        return nom + " " + prenom;
    }
    
    public boolean hasContact() {
        return (email != null && !email.trim().isEmpty()) || (telephone != null && !telephone.trim().isEmpty());
    }
    
    @Override
    public String toString() {
        return "ClientDTO{" +
                "idClient=" + idClient +
                ", nom='" + nom + '\'' +
                ", prenom='" + prenom + '\'' +
                ", email='" + email + '\'' +
                ", telephone='" + telephone + '\'' +
                '}';
    }
}
