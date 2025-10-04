package com.banque.compte.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "compte")
public class Compte implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idcompte")
    private Long idCompte;
    
    @Column(name = "numerocompte", nullable = false, unique = true, length = 50)
    private String numeroCompte;
    
    @Column(name = "datecreation")
    private LocalDateTime dateCreation;
    
    @Column(name = "datemodification")
    private LocalDateTime dateModification;
    
    @Column(name = "actif")
    private Boolean actif;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idclient", nullable = false)
    private Client client;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "idtypecompte", nullable = false)
    private TypeCompte typeCompte;
    
    @OneToMany(mappedBy = "compte", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Operation> operations;
    
    // Constructeurs
    public Compte() {
        this.dateCreation = LocalDateTime.now();
        this.dateModification = LocalDateTime.now();
        this.actif = true;
    }
    
    public Compte(String numeroCompte, Client client, TypeCompte typeCompte) {
        this();
        this.numeroCompte = numeroCompte;
        this.client = client;
        this.typeCompte = typeCompte;
    }
    
    // Méthode pour calculer le solde
    public BigDecimal calculerSolde() {
        if (operations == null || operations.isEmpty()) {
            return BigDecimal.ZERO;
        }
        
        return operations.stream()
                .map(Operation::getMontantAvecSigne)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
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
    
    public Client getClient() { return client; }
    public void setClient(Client client) { this.client = client; }
    
    public TypeCompte getTypeCompte() { return typeCompte; }
    public void setTypeCompte(TypeCompte typeCompte) { this.typeCompte = typeCompte; }
    
    public List<Operation> getOperations() { return operations; }
    public void setOperations(List<Operation> operations) { this.operations = operations; }
    
    @PreUpdate
    public void preUpdate() {
        this.dateModification = LocalDateTime.now();
    }
    
    @Override
    public String toString() {
        return "Compte{" +
                "idCompte=" + idCompte +
                ", numeroCompte='" + numeroCompte + '\'' +
                ", actif=" + actif +
                '}';
    }
}
