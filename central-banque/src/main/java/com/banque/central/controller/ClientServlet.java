package com.banque.central.controller;

import com.banque.central.dto.ClientDTO;
import com.banque.compte.ejb.CompteServiceRemote;
import com.banque.compte.entity.Client;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/client/*")
public class ClientServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(ClientServlet.class.getName());
    
    @EJB(lookup = "java:global/compte-courant-ejb-1.0.0/CompteServiceBean!com.banque.compte.ejb.CompteServiceRemote")
    private CompteServiceRemote compteService;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pathInfo = request.getPathInfo();
        String action = pathInfo != null ? pathInfo.substring(1) : "list";
        
        try {
            switch (action) {
                case "list":
                    listerClients(request, response);
                    break;
                case "nouveau":
                    afficherFormulaireNouveauClient(request, response);
                    break;
                case "details":
                    afficherDetailsClient(request, response);
                    break;
                default:
                    listerClients(request, response);
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans ClientServlet: " + e.getMessage());
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
                    creerClient(request, response);
                    break;
                case "modifier":
                    modifierClient(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/client/list");
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans ClientServlet POST: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du traitement de la demande: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void listerClients(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Récupérer les messages de session s'ils existent
            String messageSucces = (String) request.getSession().getAttribute("succes");
            String messageErreur = (String) request.getSession().getAttribute("erreur");
            
            if (messageSucces != null) {
                request.setAttribute("succes", messageSucces);
                request.getSession().removeAttribute("succes");
            }
            
            if (messageErreur != null) {
                request.setAttribute("erreur", messageErreur);
                request.getSession().removeAttribute("erreur");
            }
            
            List<Client> clients = compteService.listerTousLesClients();
            
            // Convertir les entités en DTOs
            List<ClientDTO> clientsDTO = new ArrayList<>();
            for (Client client : clients) {
                ClientDTO dto = new ClientDTO();
                dto.setIdClient(client.getIdClient());
                dto.setNom(client.getNom());
                dto.setPrenom(client.getPrenom());
                dto.setTelephone(client.getTelephone());
                dto.setEmail(client.getEmail());
                dto.setDateCreation(client.getDateCreation());
                
                clientsDTO.add(dto);
            }
            
            request.setAttribute("clients", clientsDTO);
            request.getRequestDispatcher("/jsp/clients-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des clients: " + e.getMessage());
            throw new ServletException("Erreur lors de la récupération des clients", e);
        }
    }
    
    private void afficherFormulaireNouveauClient(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            request.getRequestDispatcher("/jsp/nouveau-client.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage du formulaire: " + e.getMessage());
            throw new ServletException("Erreur lors de l'affichage du formulaire", e);
        }
    }
    
    private void afficherDetailsClient(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idClientStr = request.getParameter("id");
        if (idClientStr == null || idClientStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/client/list");
            return;
        }
        
        try {
            Long idClient = Long.parseLong(idClientStr);
            Client client = compteService.trouverClientParId(idClient);
            
            if (client == null) {
                request.setAttribute("erreur", "Client introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            // Récupérer les comptes du client
            var comptes = compteService.listerComptesParClient(idClient);
            
            request.setAttribute("client", client);
            request.setAttribute("comptes", comptes);
            request.getRequestDispatcher("/jsp/client-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "ID de client invalide");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void creerClient(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        
        try {
            // Validation des champs obligatoires
            if (nom == null || nom.trim().isEmpty()) {
                throw new IllegalArgumentException("Le nom est obligatoire");
            }
            if (prenom == null || prenom.trim().isEmpty()) {
                throw new IllegalArgumentException("Le prénom est obligatoire");
            }
            
            Client nouveauClient = compteService.creerClient(nom.trim(), prenom.trim(), 
                telephone != null ? telephone.trim() : null, 
                email != null ? email.trim() : null);
            
            request.getSession().setAttribute("succes", 
                String.format("Client %s %s créé avec succès", prenom, nom));
            response.sendRedirect(request.getContextPath() + "/client/list");
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la création du client: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la création du client: " + e.getMessage());
            request.setAttribute("nom", nom);
            request.setAttribute("prenom", prenom);
            request.setAttribute("telephone", telephone);
            request.setAttribute("email", email);
            afficherFormulaireNouveauClient(request, response);
        }
    }
    
    private void modifierClient(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idClientStr = request.getParameter("idClient");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String telephone = request.getParameter("telephone");
        String email = request.getParameter("email");
        
        try {
            Long idClient = Long.parseLong(idClientStr);
            Client client = compteService.trouverClientParId(idClient);
            
            if (client == null) {
                throw new IllegalArgumentException("Client introuvable");
            }
            
            // Validation des champs obligatoires
            if (nom == null || nom.trim().isEmpty()) {
                throw new IllegalArgumentException("Le nom est obligatoire");
            }
            if (prenom == null || prenom.trim().isEmpty()) {
                throw new IllegalArgumentException("Le prénom est obligatoire");
            }
            
            // Mise à jour des informations
            client.setNom(nom.trim());
            client.setPrenom(prenom.trim());
            client.setTelephone(telephone != null ? telephone.trim() : null);
            client.setEmail(email != null ? email.trim() : null);
            
            compteService.modifierClient(client);
            
            request.getSession().setAttribute("succes", 
                String.format("Client %s %s modifié avec succès", prenom, nom));
            response.sendRedirect(request.getContextPath() + "/client/details?id=" + idClient);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la modification du client: " + e.getMessage());
            request.getSession().setAttribute("erreur", "Erreur lors de la modification du client: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/client/list");
        }
    }
}
