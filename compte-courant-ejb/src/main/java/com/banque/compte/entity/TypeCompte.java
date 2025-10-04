package com.banque.compte.entity;

import jakarta.persistence.*;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.List;

@Entity
@Table(name = "typecompte")
public class TypeCompte implements Serializable {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "idtypecompte")
    private Long idTypeCompte;
    
    @Column(name = "nomtypecompte", nullable = false, unique = true, length = 50)
    private String nomTypeCompte;
    
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    
    @Column(name = "datecreation")
    private LocalDateTime dateCreation;
    
    @OneToMany(mappedBy = "typeCompte", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    private List<Compte> comptes;
    
    // Constructeurs
    public TypeCompte() {
        this.dateCreation = LocalDateTime.now();
    }
    
    public TypeCompte(String nomTypeCompte, String description) {
        this();
        this.nomTypeCompte = nomTypeCompte;
        this.description = description;
    }
    
    // Getters et Setters
    public Long getIdTypeCompte() { return idTypeCompte; }
    public void setIdTypeCompte(Long idTypeCompte) { this.idTypeCompte = idTypeCompte; }
    
    public String getNomTypeCompte() { return nomTypeCompte; }
    public void setNomTypeCompte(String nomTypeCompte) { this.nomTypeCompte = nomTypeCompte; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public LocalDateTime getDateCreation() { return dateCreation; }
    public void setDateCreation(LocalDateTime dateCreation) { this.dateCreation = dateCreation; }
    
    public List<Compte> getComptes() { return comptes; }
    public void setComptes(List<Compte> comptes) { this.comptes = comptes; }
    
    @Override
    public String toString() {
        return "TypeCompte{" +
                "idTypeCompte=" + idTypeCompte +
                ", nomTypeCompte='" + nomTypeCompte + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
