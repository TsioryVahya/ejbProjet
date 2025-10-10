package com.banque.central.controller;

import com.banque.central.service.EpargneApiService;
import com.banque.central.service.PretApiService;
import com.banque.compte.ejb.CompteServiceRemote;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.logging.Logger;

@WebServlet("/accueil")
public class AccueilServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(AccueilServlet.class.getName());
    
    @EJB(lookup = "java:global/compte-courant-ejb-1.0.0/CompteServiceBean!com.banque.compte.ejb.CompteServiceRemote")
    private CompteServiceRemote compteService;
    
    @Inject
    private EpargneApiService epargneApiService;
    
    @Inject
    private PretApiService pretApiService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Vérifier la santé des services
            boolean compteServiceDisponible = (compteService != null);
            boolean epargneApiDisponible = epargneApiService.verifierSanteApi();
            boolean pretApiDisponible = pretApiService.verifierSanteApi();
            
            // Récupérer des statistiques générales
            int nombreClients = 0;
            int nombreComptes = 0;
            
            if (compteServiceDisponible) {
                try {
                    nombreClients = compteService.listerTousLesClients().size();
                    nombreComptes = compteService.listerTousLesComptes().size();
                } catch (Exception e) {
                    LOGGER.warning("Erreur lors de la récupération des statistiques: " + e.getMessage());
                    compteServiceDisponible = false;
                }
            }
            
            // Préparer les données pour la JSP
            request.setAttribute("compteServiceDisponible", compteServiceDisponible);
            request.setAttribute("epargneApiDisponible", epargneApiDisponible);
            request.setAttribute("pretApiDisponible", pretApiDisponible);
            request.setAttribute("nombreClients", nombreClients);
            request.setAttribute("nombreComptes", nombreComptes);
            
            // Calculer le statut global du système
            boolean systemeOperationnel = compteServiceDisponible && epargneApiDisponible && pretApiDisponible;
            request.setAttribute("systemeOperationnel", systemeOperationnel);
            
            // Rediriger vers la page d'accueil
            request.getRequestDispatcher("/jsp/accueil.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur dans AccueilServlet: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du chargement de la page d'accueil: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Rediriger les POST vers GET pour cette servlet
        doGet(request, response);
    }
}
