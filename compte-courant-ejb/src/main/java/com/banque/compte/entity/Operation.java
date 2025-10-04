package com.banque.compte.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@Entity
@Table(name = "operations")
public class Operation implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idoperation")
    private Long idOperation;
    
    @Column(name = "montant", nullable = false, precision = 15, scale = 2)
    private BigDecimal montant;
    
    @Column(name = "dateoperation")
    private LocalDateTime dateOperation;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idtypeoperation", nullable = false)
    private TypeOperation typeOperation;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idcompte", nullable = false)
    private Compte compte;
    
    // Constructeurs
    public Operation() {
        this.dateOperation = LocalDateTime.now();
    }
    
    public Operation(BigDecimal montant, String description, TypeOperation typeOperation, Compte compte) {
        this();
        this.montant = montant;
        this.description = description;
        this.typeOperation = typeOperation;
        this.compte = compte;
    }
    
    // Méthode appelée avant la persistance pour s'assurer que la date est définie
    @PrePersist
    protected void onCreate() {
        if (this.dateOperation == null) {
            this.dateOperation = LocalDateTime.now();
        }
    }
    
    // Méthode pour obtenir le montant avec signe (+ pour crédit, - pour débit)
    public BigDecimal getMontantAvecSigne() {
        if (typeOperation != null && typeOperation.isCredit()) {
            return montant;
        } else if (typeOperation != null && typeOperation.isDebit()) {
            return montant.negate();
        }
        return BigDecimal.ZERO;
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
    
    public TypeOperation getTypeOperation() { return typeOperation; }
    public void setTypeOperation(TypeOperation typeOperation) { this.typeOperation = typeOperation; }
    
    public Compte getCompte() { return compte; }
    public void setCompte(Compte compte) { this.compte = compte; }
    
    @Override
    public String toString() {
        return "Operation{" +
                "idOperation=" + idOperation +
                ", montant=" + montant +
                ", dateOperation=" + dateOperation +
                ", description='" + description + '\'' +
                '}';
    }
}
