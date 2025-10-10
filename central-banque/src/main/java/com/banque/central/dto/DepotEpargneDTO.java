package com.banque.central.dto;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@JsonIgnoreProperties(ignoreUnknown = true)
public class DepotEpargneDTO implements Serializable {
    private Long idDepotEpargne;
    private BigDecimal montantEpargne;
    private LocalDateTime dateEpargne;
    private Integer duree;
    private Long idCompte;
    private Long idTaux;
    
    // Informations du compte (depuis l'API)
    private String numeroCompte;
    private String nomClient;
    private String prenomClient;
    
    // Informations du taux
    private BigDecimal tauxPourcentage;
    private String descriptionTaux;
    
    // Retraits associés
    private List<RetraitEpargneDTO> retraitsEpargne;
    
    // Constructeurs
    public DepotEpargneDTO() {}
    
    public DepotEpargneDTO(Long idDepotEpargne, BigDecimal montantEpargne, 
                          LocalDateTime dateEpargne, Long idCompte, Long idTaux) {
        this.idDepotEpargne = idDepotEpargne;
        this.montantEpargne = montantEpargne;
        this.dateEpargne = dateEpargne;
        this.idCompte = idCompte;
        this.idTaux = idTaux;
    }
    
    // Getters et Setters
    public Long getIdDepotEpargne() { return idDepotEpargne; }
    public void setIdDepotEpargne(Long idDepotEpargne) { this.idDepotEpargne = idDepotEpargne; }
    
    public BigDecimal getMontantEpargne() { return montantEpargne; }
    public void setMontantEpargne(BigDecimal montantEpargne) { this.montantEpargne = montantEpargne; }
    
    public LocalDateTime getDateEpargne() { return dateEpargne; }
    public void setDateEpargne(LocalDateTime dateEpargne) { this.dateEpargne = dateEpargne; }
    
    public Integer getDuree() { return duree; }
    public void setDuree(Integer duree) { this.duree = duree; }
    
    public Long getIdCompte() { return idCompte; }
    public void setIdCompte(Long idCompte) { this.idCompte = idCompte; }
    
    public Long getIdTaux() { return idTaux; }
    public void setIdTaux(Long idTaux) { this.idTaux = idTaux; }
    
    public String getNumeroCompte() { return numeroCompte; }
    public void setNumeroCompte(String numeroCompte) { this.numeroCompte = numeroCompte; }
    
    public String getNomClient() { return nomClient; }
    public void setNomClient(String nomClient) { this.nomClient = nomClient; }
    
    public String getPrenomClient() { return prenomClient; }
    public void setPrenomClient(String prenomClient) { this.prenomClient = prenomClient; }
    
    public BigDecimal getTauxPourcentage() { return tauxPourcentage; }
    public void setTauxPourcentage(BigDecimal tauxPourcentage) { this.tauxPourcentage = tauxPourcentage; }
    
    public String getDescriptionTaux() { return descriptionTaux; }
    public void setDescriptionTaux(String descriptionTaux) { this.descriptionTaux = descriptionTaux; }
    
    public List<RetraitEpargneDTO> getRetraitsEpargne() { return retraitsEpargne; }
    public void setRetraitsEpargne(List<RetraitEpargneDTO> retraitsEpargne) { this.retraitsEpargne = retraitsEpargne; }
    
    // Méthodes utilitaires
    public BigDecimal getMontantDisponible() {
        if (retraitsEpargne == null || retraitsEpargne.isEmpty()) {
            return montantEpargne;
        }
        
        BigDecimal totalRetraits = retraitsEpargne.stream()
            .map(RetraitEpargneDTO::getMontantRetrait)
            .reduce(BigDecimal.ZERO, BigDecimal::add);
            
        return montantEpargne.subtract(totalRetraits);
    }
    
    @Override
    public String toString() {
        return "DepotEpargneDTO{" +
                "idDepotEpargne=" + idDepotEpargne +
                ", montantEpargne=" + montantEpargne +
                ", dateEpargne=" + dateEpargne +
                ", idCompte=" + idCompte +
                ", idTaux=" + idTaux +
                ", numeroCompte='" + numeroCompte + '\'' +
                ", nomClient='" + nomClient + '\'' +
                ", prenomClient='" + prenomClient + '\'' +
                ", tauxPourcentage=" + tauxPourcentage +
                '}';
    }
}
