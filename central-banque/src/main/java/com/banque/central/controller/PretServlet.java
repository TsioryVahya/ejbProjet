package com.banque.central.controller;

import com.banque.central.dto.PretDTO;
import com.banque.central.dto.RemboursementDTO;
import com.banque.central.service.PretApiService;
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
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/pret/*")
public class PretServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(PretServlet.class.getName());
    
    @EJB(lookup = "java:global/compte-courant-ejb-1.0.0/CompteServiceBean!com.banque.compte.ejb.CompteServiceRemote")
    private CompteServiceRemote compteService;
    
    @Inject
    private PretApiService pretApiService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = pathInfo != null ? pathInfo.substring(1) : "list";
        
        try {
            switch (action) {
                case "list":
                    listerPrets(request, response);
                    break;
                case "details":
                    afficherDetailsPret(request, response);
                    break;
                case "nouveau":
                    afficherFormulaireNouveauPret(request, response);
                    break;
                case "simulation":
                    afficherFormulaireSimulation(request, response);
                    break;
                case "echeancier":
                    afficherEcheancier(request, response);
                    break;
                case "remboursement":
                    afficherFormulaireRemboursement(request, response);
                    break;
                case "statistiques":
                    afficherStatistiques(request, response);
                    break;
                default:
                    listerPrets(request, response);
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans PretServlet: " + e.getMessage());
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
                case "creer":
                    creerPret(request, response);
                    break;
                case "simuler":
                    simulerPret(request, response);
                    break;
                case "rembourser":
                    effectuerRemboursement(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/pret/list");
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans PretServlet POST: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du traitement de la demande: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void listerPrets(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Récupérer tous les prêts actifs
            List<PretDTO> prets = pretApiService.obtenirPretsActifs();
            
            request.setAttribute("prets", prets);
            request.setAttribute("apiDisponible", pretApiService.verifierSanteApi());
            request.getRequestDispatcher("/jsp/pret.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des prêts: " + e.getMessage());
            request.setAttribute("erreur", "Service de prêt temporairement indisponible");
            request.setAttribute("apiDisponible", false);
            request.getRequestDispatcher("/jsp/pret.jsp").forward(request, response);
        }
    }
    
    private void afficherDetailsPret(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idPretStr = request.getParameter("id");
        if (idPretStr == null || idPretStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pret/list");
            return;
        }
        
        try {
            Long idPret = Long.parseLong(idPretStr);
            
            // Récupérer les détails du prêt
            PretDTO pret = pretApiService.obtenirPret(idPret);
            if (pret == null) {
                request.setAttribute("erreur", "Prêt introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            // Récupérer les remboursements
            List<RemboursementDTO> remboursements = pretApiService.obtenirRemboursementsParPret(idPret);
            
            // Récupérer les informations du compte associé
            Compte compte = compteService.trouverCompteParId(pret.getIdCompte());
            
            request.setAttribute("pret", pret);
            request.setAttribute("remboursements", remboursements);
            request.setAttribute("compte", compte);
            request.setAttribute("apiDisponible", pretApiService.verifierSanteApi());
            request.getRequestDispatcher("/jsp/pret-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "ID de prêt invalide");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage des détails du prêt: " + e.getMessage());
            request.setAttribute("erreur", "Service de prêt temporairement indisponible");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherFormulaireNouveauPret(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Récupérer tous les comptes pour le formulaire
            List<Compte> comptes = compteService.listerTousLesComptes();
            
            request.setAttribute("comptes", comptes);
            request.getRequestDispatcher("/jsp/nouveau-pret.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage du formulaire: " + e.getMessage());
            throw new ServletException("Erreur lors de l'affichage du formulaire", e);
        }
    }
    
    private void afficherFormulaireSimulation(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.getRequestDispatcher("/jsp/simulation-pret.jsp").forward(request, response);
    }
    
    private void afficherEcheancier(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idPretStr = request.getParameter("id");
        if (idPretStr == null || idPretStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pret/list");
            return;
        }
        
        try {
            Long idPret = Long.parseLong(idPretStr);
            
            // Calculer l'échéancier via l'API
            String echeancier = pretApiService.calculerEcheancier(idPret);
            PretDTO pret = pretApiService.obtenirPret(idPret);
            
            request.setAttribute("echeancier", echeancier);
            request.setAttribute("pret", pret);
            request.getRequestDispatcher("/jsp/echeancier-pret.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors du calcul de l'échéancier: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du calcul de l'échéancier: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherFormulaireRemboursement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idPretStr = request.getParameter("idPret");
        if (idPretStr == null || idPretStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/pret/list");
            return;
        }
        
        try {
            Long idPret = Long.parseLong(idPretStr);
            PretDTO pret = pretApiService.obtenirPret(idPret);
            
            if (pret == null) {
                request.setAttribute("erreur", "Prêt introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            request.setAttribute("pret", pret);
            request.getRequestDispatcher("/jsp/remboursement-pret.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage du formulaire de remboursement: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de l'affichage du formulaire de remboursement");
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
                statistiques = pretApiService.obtenirStatistiquesPrets(idCompte);
                Compte compte = compteService.trouverCompteParId(idCompte);
                request.setAttribute("compte", compte);
            } else {
                statistiques = pretApiService.obtenirStatistiquesPrets(null);
            }
            
            request.setAttribute("statistiques", statistiques);
            request.getRequestDispatcher("/jsp/statistiques-pret.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des statistiques: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la récupération des statistiques");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void creerPret(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("idCompte");
        String montantStr = request.getParameter("montant");
        String dureeStr = request.getParameter("duree");
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            BigDecimal montant = new BigDecimal(montantStr);
            Integer duree = Integer.parseInt(dureeStr);
            
            // Vérifier que le compte existe
            Compte compte = compteService.trouverCompteParId(idCompte);
            if (compte == null) {
                request.setAttribute("erreur", "Compte introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            // Créer le prêt via l'API
            PretDTO pret = pretApiService.creerPret(idCompte, montant, duree);
            
            request.setAttribute("succes", "Prêt créé avec succès");
            response.sendRedirect(request.getContextPath() + "/pret/details?id=" + pret.getIdPret());
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la création du prêt: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la création du prêt: " + e.getMessage());
            afficherFormulaireNouveauPret(request, response);
        }
    }
    
    private void simulerPret(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String montantStr = request.getParameter("montant");
        String dureeStr = request.getParameter("duree");
        
        try {
            BigDecimal montant = new BigDecimal(montantStr);
            Integer duree = Integer.parseInt(dureeStr);
            
            // Simuler le prêt via l'API
            String simulation = pretApiService.simulerPret(montant, duree);
            
            request.setAttribute("simulation", simulation);
            request.setAttribute("montantSimule", montant);
            request.setAttribute("dureeSimulee", duree);
            request.getRequestDispatcher("/jsp/simulation-pret.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la simulation du prêt: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la simulation du prêt: " + e.getMessage());
            request.getRequestDispatcher("/jsp/simulation-pret.jsp").forward(request, response);
        }
    }
    
    private void effectuerRemboursement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idPretStr = request.getParameter("idPret");
        String montantStr = request.getParameter("montant");
        
        try {
            Long idPret = Long.parseLong(idPretStr);
            BigDecimal montant = new BigDecimal(montantStr);
            
            // Effectuer le remboursement via l'API
            RemboursementDTO remboursement = pretApiService.effectuerRemboursement(idPret, montant);
            
            request.setAttribute("succes", "Remboursement effectué avec succès");
            response.sendRedirect(request.getContextPath() + "/pret/details?id=" + idPret);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors du remboursement: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du remboursement: " + e.getMessage());
            
            // Rediriger vers le formulaire de remboursement avec l'erreur
            String idPretParam = request.getParameter("idPret");
            if (idPretParam != null) {
                request.setAttribute("idPret", idPretParam);
                afficherFormulaireRemboursement(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/pret/list");
            }
        }
    }
}
