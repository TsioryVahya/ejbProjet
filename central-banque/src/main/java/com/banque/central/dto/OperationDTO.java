package com.banque.central.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;

public class OperationDTO implements Serializable {
    private Long idOperation;
    private BigDecimal montant;
    private LocalDateTime dateOperation;
    private String description;
    private String typeOperation;
    private String descriptionTypeOperation;
    private Long idCompte;
    private String numeroCompte;
    
    // Constructeurs
    public OperationDTO() {}
    
    public OperationDTO(Long idOperation, BigDecimal montant, LocalDateTime dateOperation, 
                       String description, String typeOperation, Long idCompte, String numeroCompte) {
        this.idOperation = idOperation;
        this.montant = montant;
        this.dateOperation = dateOperation;
        this.description = description;
        this.typeOperation = typeOperation;
        this.idCompte = idCompte;
        this.numeroCompte = numeroCompte;
    }
    
    // Getters et Setters
    public Long getIdOperation() { return idOperation; }
    public void setIdOperation(Long idOperation) { this.idOperation = idOperation; }
    
    public BigDecimal getMontant() { return montant; }
    public void setMontant(BigDecimal montant) { this.montant = montant; }
    
    public LocalDateTime getDateOperation() { return dateOperation; }
    public void setDateOperation(LocalDateTime dateOperation) { this.dateOperation = dateOperation; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getTypeOperation() { return typeOperation; }
    public void setTypeOperation(String typeOperation) { this.typeOperation = typeOperation; }
    
    public String getDescriptionTypeOperation() { return descriptionTypeOperation; }
    public void setDescriptionTypeOperation(String descriptionTypeOperation) { this.descriptionTypeOperation = descriptionTypeOperation; }
    
    public Long getIdCompte() { return idCompte; }
    public void setIdCompte(Long idCompte) { this.idCompte = idCompte; }
    
    public String getNumeroCompte() { return numeroCompte; }
    public void setNumeroCompte(String numeroCompte) { this.numeroCompte = numeroCompte; }
    
    // Méthodes utilitaires
    public boolean isCredit() {
        return "DEPOT".equals(typeOperation) || 
               "VIREMENT_CREDIT".equals(typeOperation) || 
               "INTERETS".equals(typeOperation) || 
               "SOLDE_INITIAL".equals(typeOperation);
    }
    
    public boolean isDebit() {
        return "RETRAIT".equals(typeOperation) || 
               "VIREMENT_DEBIT".equals(typeOperation) || 
               "PRELEVEMENT".equals(typeOperation) || 
               "FRAIS".equals(typeOperation);
    }
    
    public BigDecimal getMontantAvecSigne() {
        if (isCredit()) {
            return montant;
        } else if (isDebit()) {
            return montant.negate();
        }
        return BigDecimal.ZERO;
    }
    
    // Méthodes utilitaires pour la conversion de dates (compatibilité JSP)
    public Date getDateOperationAsDate() {
        return dateOperation != null ? Date.from(dateOperation.atZone(ZoneId.systemDefault()).toInstant()) : null;
    }
    
    public String getDateOperationFormatted() {
        return dateOperation != null ? dateOperation.toString() : "";
    }
    
    @Override
    public String toString() {
        return "OperationDTO{" +
                "idOperation=" + idOperation +
                ", montant=" + montant +
                ", dateOperation=" + dateOperation +
                ", description='" + description + '\'' +
                ", typeOperation='" + typeOperation + '\'' +
                ", numeroCompte='" + numeroCompte + '\'' +
                '}';
    }
}
