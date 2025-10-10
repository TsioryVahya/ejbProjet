package com.banque.central.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

@JsonIgnoreProperties(ignoreUnknown = true)
public class TauxEpargneDTO implements Serializable {
    private Long idTaux;
    private BigDecimal pourcentage;
    private LocalDateTime dateApplication;
    private String description;
    
    // Constructeurs
    public TauxEpargneDTO() {}
    
    public TauxEpargneDTO(Long idTaux, BigDecimal pourcentage, LocalDateTime dateApplication, String description) {
        this.idTaux = idTaux;
        this.pourcentage = pourcentage;
        this.dateApplication = dateApplication;
        this.description = description;
    }
    
    // Getters et Setters
    public Long getIdTaux() { return idTaux; }
    public void setIdTaux(Long idTaux) { this.idTaux = idTaux; }
    
    public BigDecimal getPourcentage() { return pourcentage; }
    public void setPourcentage(BigDecimal pourcentage) { this.pourcentage = pourcentage; }
    
    public LocalDateTime getDateApplication() { return dateApplication; }
    public void setDateApplication(LocalDateTime dateApplication) { this.dateApplication = dateApplication; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    // Méthode utilitaire pour l'affichage
    public String getAffichageComplet() {
        return pourcentage + "% - " + (description != null ? description : "Taux standard");
    }
    
    @Override
    public String toString() {
        return "TauxEpargneDTO{" +
                "idTaux=" + idTaux +
                ", pourcentage=" + pourcentage +
                ", dateApplication=" + dateApplication +
                ", description='" + description + '\'' +
                '}';
    }
}
