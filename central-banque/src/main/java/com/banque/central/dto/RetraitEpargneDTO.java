package com.banque.central.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class RetraitEpargneDTO implements Serializable {
    private Long idRetraitEpargne;
    private BigDecimal montantRetraitEpargne;
    private LocalDateTime dateRetraitEpargne;
    private Long idDepotEpargne;
    
    // Constructeurs
    public RetraitEpargneDTO() {}
    
    public RetraitEpargneDTO(Long idRetraitEpargne, BigDecimal montantRetraitEpargne, 
                           LocalDateTime dateRetraitEpargne, Long idDepotEpargne) {
        this.idRetraitEpargne = idRetraitEpargne;
        this.montantRetraitEpargne = montantRetraitEpargne;
        this.dateRetraitEpargne = dateRetraitEpargne;
        this.idDepotEpargne = idDepotEpargne;
    }
    
    // Getters et Setters
    public Long getIdRetraitEpargne() { return idRetraitEpargne; }
    public void setIdRetraitEpargne(Long idRetraitEpargne) { this.idRetraitEpargne = idRetraitEpargne; }
    
    public BigDecimal getMontantRetraitEpargne() { return montantRetraitEpargne; }
    public void setMontantRetraitEpargne(BigDecimal montantRetraitEpargne) { this.montantRetraitEpargne = montantRetraitEpargne; }
    
    public LocalDateTime getDateRetraitEpargne() { return dateRetraitEpargne; }
    public void setDateRetraitEpargne(LocalDateTime dateRetraitEpargne) { this.dateRetraitEpargne = dateRetraitEpargne; }
    
    public Long getIdDepotEpargne() { return idDepotEpargne; }
    public void setIdDepotEpargne(Long idDepotEpargne) { this.idDepotEpargne = idDepotEpargne; }
    
    @Override
    public String toString() {
        return "RetraitEpargneDTO{" +
                "idRetraitEpargne=" + idRetraitEpargne +
                ", montantRetraitEpargne=" + montantRetraitEpargne +
                ", dateRetraitEpargne=" + dateRetraitEpargne +
                ", idDepotEpargne=" + idDepotEpargne +
                '}';
    }
}
