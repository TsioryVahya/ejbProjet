package com.banque.central.dto;

import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

public class RemboursementDTO implements Serializable {
    private Long idRemboursement;
    private BigDecimal montantRembourser;
    private LocalDateTime dateRemboursement;
    private Long idPret;
    
    // Constructeurs
    public RemboursementDTO() {}
    
    public RemboursementDTO(Long idRemboursement, BigDecimal montantRembourser, 
                          LocalDateTime dateRemboursement, Long idPret) {
        this.idRemboursement = idRemboursement;
        this.montantRembourser = montantRembourser;
        this.dateRemboursement = dateRemboursement;
        this.idPret = idPret;
    }
    
    // Getters et Setters
    public Long getIdRemboursement() { return idRemboursement; }
    public void setIdRemboursement(Long idRemboursement) { this.idRemboursement = idRemboursement; }
    
    public BigDecimal getMontantRembourser() { return montantRembourser; }
    public void setMontantRembourser(BigDecimal montantRembourser) { this.montantRembourser = montantRembourser; }
    
    public LocalDateTime getDateRemboursement() { return dateRemboursement; }
    public void setDateRemboursement(LocalDateTime dateRemboursement) { this.dateRemboursement = dateRemboursement; }
    
    public Long getIdPret() { return idPret; }
    public void setIdPret(Long idPret) { this.idPret = idPret; }
    
    @Override
    public String toString() {
        return "RemboursementDTO{" +
                "idRemboursement=" + idRemboursement +
                ", montantRembourser=" + montantRembourser +
                ", dateRemboursement=" + dateRemboursement +
                ", idPret=" + idPret +
                '}';
    }
}
