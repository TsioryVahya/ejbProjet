package com.banque.central.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonSetter;
import com.fasterxml.jackson.databind.JsonNode;

@JsonIgnoreProperties(ignoreUnknown = true)
public class EpargneDTO implements Serializable {
    private Long idDepotEpargne;
    private BigDecimal montantEpargne;
    private LocalDateTime dateEpargne;
    private Long idCompte;
    private String numeroCompte;
    private Long idTaux;
    private BigDecimal tauxEpargne;
    private BigDecimal interetsCalcules;
    private BigDecimal montantDisponible;
    private BigDecimal totalRetraits;
    
    // Constructeurs
    public EpargneDTO() {}
    
    public EpargneDTO(Long idDepotEpargne, BigDecimal montantEpargne, LocalDateTime dateEpargne, 
                     Long idCompte, String numeroCompte, BigDecimal tauxEpargne) {
        this.idDepotEpargne = idDepotEpargne;
        this.montantEpargne = montantEpargne;
        this.dateEpargne = dateEpargne;
        this.idCompte = idCompte;
        this.numeroCompte = numeroCompte;
        this.tauxEpargne = tauxEpargne;
    }
    
    // Getters et Setters
    public Long getIdDepotEpargne() { return idDepotEpargne; }
    public void setIdDepotEpargne(Long idDepotEpargne) { this.idDepotEpargne = idDepotEpargne; }
    
    public BigDecimal getMontantEpargne() { return montantEpargne; }
    public void setMontantEpargne(BigDecimal montantEpargne) { this.montantEpargne = montantEpargne; }
    
    public LocalDateTime getDateEpargne() { return dateEpargne; }
    public void setDateEpargne(LocalDateTime dateEpargne) { this.dateEpargne = dateEpargne; }
    
    public Long getIdCompte() { return idCompte; }
    public void setIdCompte(Long idCompte) { this.idCompte = idCompte; }
    
    public String getNumeroCompte() { return numeroCompte; }
    public void setNumeroCompte(String numeroCompte) { this.numeroCompte = numeroCompte; }
    
    public Long getIdTaux() { return idTaux; }
    public void setIdTaux(Long idTaux) { this.idTaux = idTaux; }
    
    public BigDecimal getTauxEpargne() { return tauxEpargne; }
    public void setTauxEpargne(BigDecimal tauxEpargne) { this.tauxEpargne = tauxEpargne; }
    
    @JsonSetter("tauxEpargne")
    public void setTauxEpargneFromObject(JsonNode tauxNode) {
        if (tauxNode.isNumber()) {
            this.tauxEpargne = tauxNode.decimalValue();
        } else if (tauxNode.isObject() && tauxNode.has("pourcentage")) {
            this.tauxEpargne = tauxNode.get("pourcentage").decimalValue();
        }
    }
    
    public BigDecimal getInteretsCalcules() { return interetsCalcules; }
    public void setInteretsCalcules(BigDecimal interetsCalcules) { this.interetsCalcules = interetsCalcules; }
    
    public BigDecimal getMontantDisponible() { return montantDisponible; }
    public void setMontantDisponible(BigDecimal montantDisponible) { this.montantDisponible = montantDisponible; }
    
    public BigDecimal getTotalRetraits() { return totalRetraits; }
    public void setTotalRetraits(BigDecimal totalRetraits) { this.totalRetraits = totalRetraits; }
    
    @Override
    public String toString() {
        return "EpargneDTO{" +
                "idDepotEpargne=" + idDepotEpargne +
                ", montantEpargne=" + montantEpargne +
                ", dateEpargne=" + dateEpargne +
                ", numeroCompte='" + numeroCompte + '\'' +
                ", tauxEpargne=" + tauxEpargne +
                ", montantDisponible=" + montantDisponible +
                '}';
    }
}

