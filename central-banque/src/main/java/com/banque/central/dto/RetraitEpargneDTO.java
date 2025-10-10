package com.banque.central.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@JsonIgnoreProperties(ignoreUnknown = true)
public class RetraitEpargneDTO implements Serializable {
    private Long idRetraitEpargne;
    private BigDecimal montantRetrait;
    private LocalDateTime dateRetrait;
    private Long idDepotEpargne;
    
    // Constructeurs
    public RetraitEpargneDTO() {}
    
    public RetraitEpargneDTO(Long idRetraitEpargne, BigDecimal montantRetrait, 
                           LocalDateTime dateRetrait, Long idDepotEpargne) {
        this.idRetraitEpargne = idRetraitEpargne;
        this.montantRetrait = montantRetrait;
        this.dateRetrait = dateRetrait;
        this.idDepotEpargne = idDepotEpargne;
    }
    
    // Getters et Setters
    public Long getIdRetraitEpargne() { return idRetraitEpargne; }
    public void setIdRetraitEpargne(Long idRetraitEpargne) { this.idRetraitEpargne = idRetraitEpargne; }
    
    public BigDecimal getMontantRetrait() { return montantRetrait; }
    public void setMontantRetrait(BigDecimal montantRetrait) { this.montantRetrait = montantRetrait; }
    
    public LocalDateTime getDateRetrait() { return dateRetrait; }
    public void setDateRetrait(LocalDateTime dateRetrait) { this.dateRetrait = dateRetrait; }
    
    public Long getIdDepotEpargne() { return idDepotEpargne; }
    public void setIdDepotEpargne(Long idDepotEpargne) { this.idDepotEpargne = idDepotEpargne; }
    
    @Override
    public String toString() {
        return "RetraitEpargneDTO{" +
                "idRetraitEpargne=" + idRetraitEpargne +
                ", montantRetrait=" + montantRetrait +
                ", dateRetrait=" + dateRetrait +
                ", idDepotEpargne=" + idDepotEpargne +
                '}';
    }
}
