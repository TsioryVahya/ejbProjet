package com.banque.central.controller;

import com.banque.central.dto.CompteAvecSoldeDTO;
import com.banque.central.dto.DepotEpargneDTO;
import com.banque.central.dto.RetraitEpargneDTO;
import com.banque.central.dto.TauxEpargneDTO;
import com.banque.central.service.EpargneApiService;
import com.banque.compte.ejb.CompteServiceRemote;
import com.banque.compte.entity.Compte;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/epargne/*")
public class EpargneServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(EpargneServlet.class.getName());
    
    @EJB(lookup = "java:global/compte-courant-ejb-1.0.0/CompteServiceBean!com.banque.compte.ejb.CompteServiceRemote")
    private CompteServiceRemote compteService;
    
    @Inject
    private EpargneApiService epargneApiService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = pathInfo != null ? pathInfo.substring(1) : "list";
        
        try {
            switch (action) {
                case "list":
                case "depots":
                    listerDepotsEpargne(request, response);
                    break;
                case "details":
                    afficherDetailsEpargne(request, response);
                    break;
                case "nouveau-depot":
                    afficherFormulaireNouveauDepot(request, response);
                    break;
                case "nouveau-retrait":
                    afficherFormulaireNouveauRetrait(request, response);
                    break;
                case "statistiques":
                    afficherStatistiques(request, response);
                    break;
                default:
                    listerDepotsEpargne(request, response);
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans EpargneServlet: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du traitement de la demande: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = pathInfo != null ? pathInfo.substring(1) : "";
        
        try {
            switch (action) {
                case "creer-depot":
                    creerDepotEpargne(request, response);
                    break;
                case "creer-retrait":
                    creerRetraitEpargne(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/epargne/list");
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans EpargneServlet POST: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du traitement de la demande: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherDetailsEpargne(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("id");
        if (idCompteStr == null || idCompteStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/epargne/list");
            return;
        }
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            
            // Récupérer les informations du compte
            Compte compte = compteService.trouverCompteParId(idCompte);
            if (compte == null) {
                request.setAttribute("erreur", "Compte introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            // Récupérer les dépôts d'épargne via l'API
            List<DepotEpargneDTO> depots = epargneApiService.obtenirDepotsParCompte(idCompte);
            BigDecimal soldeEpargne = epargneApiService.obtenirSoldeEpargne(idCompte);
            
            request.setAttribute("compte", compte);
            request.setAttribute("depots", depots);
            request.setAttribute("soldeEpargne", soldeEpargne);
            request.setAttribute("apiDisponible", epargneApiService.verifierSanteApi());
            request.getRequestDispatcher("/jsp/epargne-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "ID de compte invalide");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage des détails d'épargne: " + e.getMessage());
            request.setAttribute("erreur", "Service d'épargne temporairement indisponible");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherFormulaireNouveauDepot(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Récupérer tous les comptes pour le formulaire de dépôt
            List<Compte> comptes = compteService.listerTousLesComptes();
            List<CompteAvecSoldeDTO> comptesAvecSolde = new ArrayList<>();
            
            // Créer des DTOs avec les soldes calculés
            for (Compte compte : comptes) {
                try {
                    BigDecimal solde = compteService.obtenirSoldeCompte(compte.getIdCompte());
                    
                    CompteAvecSoldeDTO compteDTO = new CompteAvecSoldeDTO(
                        compte.getIdCompte(),
                        compte.getNumeroCompte(),
                        compte.getClient() != null ? compte.getClient().getNom() : "",
                        compte.getClient() != null ? compte.getClient().getPrenom() : "",
                        compte.getTypeCompte() != null ? compte.getTypeCompte().getNomTypeCompte() : "",
                        solde,
                        compte.getActif()
                    );
                    
                    comptesAvecSolde.add(compteDTO);
                } catch (Exception e) {
                    LOGGER.warning("Erreur lors du calcul du solde pour le compte " + compte.getIdCompte() + ": " + e.getMessage());
                    
                    CompteAvecSoldeDTO compteDTO = new CompteAvecSoldeDTO(
                        compte.getIdCompte(),
                        compte.getNumeroCompte(),
                        compte.getClient() != null ? compte.getClient().getNom() : "",
                        compte.getClient() != null ? compte.getClient().getPrenom() : "",
                        compte.getTypeCompte() != null ? compte.getTypeCompte().getNomTypeCompte() : "",
                        BigDecimal.ZERO,
                        compte.getActif()
                    );
                    
                    comptesAvecSolde.add(compteDTO);
                }
            }
            
            // Récupérer les taux d'épargne disponibles
            List<TauxEpargneDTO> tauxDisponibles = new ArrayList<>();
            try {
                tauxDisponibles = epargneApiService.obtenirTousLesTaux();
            } catch (Exception e) {
                LOGGER.warning("Erreur lors de la récupération des taux d'épargne: " + e.getMessage());
            }
            
            request.setAttribute("comptes", comptesAvecSolde);
            request.setAttribute("tauxDisponibles", tauxDisponibles);
            request.getRequestDispatcher("/jsp/nouveau-depot-epargne.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage du formulaire: " + e.getMessage());
            throw new ServletException("Erreur lors de l'affichage du formulaire", e);
        }
    }
    
    private void afficherFormulaireNouveauRetrait(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("idCompte");
        if (idCompteStr == null || idCompteStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/epargne/list");
            return;
        }
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            
            // Récupérer les dépôts d'épargne disponibles pour retrait
            List<DepotEpargneDTO> depots = epargneApiService.obtenirDepotsParCompte(idCompte);
            Compte compte = compteService.trouverCompteParId(idCompte);
            
            request.setAttribute("compte", compte);
            request.setAttribute("depots", depots);
            request.getRequestDispatcher("/jsp/nouveau-retrait-epargne.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage du formulaire de retrait: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de l'affichage du formulaire de retrait");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherStatistiques(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("idCompte");
        
        try {
            String statistiques;
            if (idCompteStr != null && !idCompteStr.trim().isEmpty()) {
                Long idCompte = Long.parseLong(idCompteStr);
                statistiques = epargneApiService.obtenirStatistiquesEpargne(idCompte);
                Compte compte = compteService.trouverCompteParId(idCompte);
                request.setAttribute("compte", compte);
            } else {
                // Statistiques globales - pour l'instant on affiche un message
                statistiques = "{\"message\":\"Statistiques globales non disponibles\"}";
            }
            
            request.setAttribute("statistiques", statistiques);
            request.getRequestDispatcher("/jsp/statistiques-epargne.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des statistiques: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la récupération des statistiques");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void creerDepotEpargne(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("idCompte");
        String montantStr = request.getParameter("montant");
        String dureeStr = request.getParameter("duree");
        String idTauxStr = request.getParameter("idTaux");
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            BigDecimal montant = new BigDecimal(montantStr);
            Integer duree = Integer.parseInt(dureeStr);
            Long idTaux = (idTauxStr != null && !idTauxStr.isEmpty()) ? Long.parseLong(idTauxStr) : null;
            
            // Vérifier que le compte existe et est un compte d'épargne
            Compte compte = compteService.trouverCompteParId(idCompte);
            if (compte == null) {
                request.setAttribute("erreur", "Compte introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            // Créer l'opération de débit sur le compte courant
            String descriptionOperation = "Dépôt d'épargne - " + montant + "€ sur " + duree + " mois";
            compteService.creerOperationDepotEpargne(idCompte, montant, descriptionOperation);
            
            // Créer le dépôt d'épargne via l'API
            DepotEpargneDTO depot = epargneApiService.creerDepotEpargne(idCompte, montant, duree, idTaux);
            
            // Rediriger vers la liste des dépôts avec message de succès
            request.getSession().setAttribute("succes", "Dépôt d'épargne créé avec succès pour un montant de " + 
                montant.toString() + "€ sur " + duree + " mois. Le montant a été débité de votre compte.");
            response.sendRedirect(request.getContextPath() + "/epargne/depots");
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la création du dépôt d'épargne: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la création du dépôt d'épargne: " + e.getMessage());
            afficherFormulaireNouveauDepot(request, response);
        }
    }
    
    private void creerRetraitEpargne(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idDepotStr = request.getParameter("idDepot");
        String montantStr = request.getParameter("montant");
        String idCompteStr = request.getParameter("idCompte");
        
        try {
            Long idDepot = Long.parseLong(idDepotStr);
            BigDecimal montant = new BigDecimal(montantStr);
            Long idCompte = Long.parseLong(idCompteStr);
            
            // Créer le retrait d'épargne via l'API
            RetraitEpargneDTO retrait = epargneApiService.creerRetraitEpargne(idDepot, montant);
            
            request.setAttribute("succes", "Retrait d'épargne effectué avec succès");
            response.sendRedirect(request.getContextPath() + "/epargne/details?id=" + idCompte);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors du retrait d'épargne: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du retrait d'épargne: " + e.getMessage());
            
            // Rediriger vers le formulaire de retrait avec l'erreur
            String idCompteParam = request.getParameter("idCompte");
            if (idCompteParam != null) {
                request.setAttribute("idCompte", idCompteParam);
                afficherFormulaireNouveauRetrait(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/epargne/list");
            }
        }
    }
    
    // Méthode pour lister tous les dépôts d'épargne
    private void listerDepotsEpargne(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            // Récupérer le message de succès depuis la session s'il existe
            String messageSucces = (String) request.getSession().getAttribute("succes");
            if (messageSucces != null) {
                request.setAttribute("succes", messageSucces);
                request.getSession().removeAttribute("succes"); // Supprimer après utilisation
            }
            
            // Récupérer tous les dépôts d'épargne directement depuis l'API
            List<DepotEpargneDTO> tousLesDepots = epargneApiService.obtenirTousLesDepots();
            
            request.setAttribute("depots", tousLesDepots);
            request.setAttribute("apiDisponible", epargneApiService.verifierSanteApi());
            request.getRequestDispatcher("/jsp/epargne-depots.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des dépôts d'épargne: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la récupération des dépôts d'épargne");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
}
