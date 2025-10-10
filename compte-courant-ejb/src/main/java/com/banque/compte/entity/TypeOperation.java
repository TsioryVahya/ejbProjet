package com.banque.compte.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.util.List;

@Entity
@Table(name = "typeoperation")
public class TypeOperation implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtypeoperation")
    private Long idTypeOperation;
    
    @Column(name = "nomtypeoperation", nullable = false, unique = true, length = 50)
    private String nomTypeOperation;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @OneToMany(mappedBy = "typeOperation", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Operation> operations;
    
    // Constructeurs
    public TypeOperation() {}
    
    public TypeOperation(String nomTypeOperation, String description) {
        this.nomTypeOperation = nomTypeOperation;
        this.description = description;
    }
    
    // Méthode pour déterminer si l'opération est un crédit
    public boolean isCredit() {
        return "DEPOT".equals(nomTypeOperation) || 
               "VIREMENT_CREDIT".equals(nomTypeOperation) || 
               "INTERETS".equals(nomTypeOperation) || 
               "SOLDE_INITIAL".equals(nomTypeOperation);
    }
    
    // Méthode pour déterminer si l'opération est un débit
    public boolean isDebit() {
        return "RETRAIT".equals(nomTypeOperation) || 
               "VIREMENT_DEBIT".equals(nomTypeOperation) || 
               "PRELEVEMENT".equals(nomTypeOperation) || 
               "FRAIS".equals(nomTypeOperation);
    }
    
    // Getters et Setters
    public Long getIdTypeOperation() { return idTypeOperation; }
    public void setIdTypeOperation(Long idTypeOperation) { this.idTypeOperation = idTypeOperation; }
    
    public String getNomTypeOperation() { return nomTypeOperation; }
    public void setNomTypeOperation(String nomTypeOperation) { this.nomTypeOperation = nomTypeOperation; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public List<Operation> getOperations() { return operations; }
    public void setOperations(List<Operation> operations) { this.operations = operations; }
    
    @Override
    public String toString() {
        return "TypeOperation{" +
                "idTypeOperation=" + idTypeOperation +
                ", nomTypeOperation='" + nomTypeOperation + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
