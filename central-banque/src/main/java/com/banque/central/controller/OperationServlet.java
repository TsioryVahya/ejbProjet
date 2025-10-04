package com.banque.central.controller;

import com.banque.central.dto.CompteDTO;
import com.banque.central.dto.OperationDTO;
import com.banque.compte.ejb.CompteServiceRemote;
import com.banque.compte.entity.Compte;
import com.banque.compte.entity.Operation;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

@WebServlet("/operations/*")
public class OperationServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(OperationServlet.class.getName());
    
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
                    listerOperations(request, response);
                    break;
                case "export":
                    exporterOperations(request, response);
                    break;
                default:
                    listerOperations(request, response);
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans OperationServlet: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du traitement de la demande: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void listerOperations(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Récupérer les paramètres de filtrage
            String idCompteFilter = request.getParameter("idCompte");
            String typeOperationFilter = request.getParameter("typeOperation");
            String dateDebutStr = request.getParameter("dateDebut");
            String dateFinStr = request.getParameter("dateFin");
            String limitStr = request.getParameter("limit");
            
            // Paramètres par défaut
            int limit = 100; // Limite par défaut
            if (limitStr != null && !limitStr.trim().isEmpty()) {
                try {
                    limit = Integer.parseInt(limitStr);
                    if (limit > 500) limit = 500; // Limite maximum
                } catch (NumberFormatException e) {
                    limit = 100;
                }
            }
            
            List<OperationDTO> operationsDTO = new ArrayList<>();
            List<CompteDTO> comptesDTO = new ArrayList<>();
            
            // Récupérer tous les comptes pour le filtre
            List<Compte> comptes = compteService.listerTousLesComptes();
            for (Compte compte : comptes) {
                CompteDTO dto = new CompteDTO();
                dto.setIdCompte(compte.getIdCompte());
                dto.setNumeroCompte(compte.getNumeroCompte());
                dto.setActif(compte.getActif());
                
                if (compte.getClient() != null) {
                    dto.setNomClient(compte.getClient().getNom());
                    dto.setPrenomClient(compte.getClient().getPrenom());
                }
                
                comptesDTO.add(dto);
            }
            
            // Récupérer les opérations
            List<Operation> operations;
            
            if (idCompteFilter != null && !idCompteFilter.trim().isEmpty()) {
                // Filtrer par compte spécifique
                Long idCompte = Long.parseLong(idCompteFilter);
                operations = compteService.listerOperationsParCompte(idCompte, limit);
            } else {
                // Récupérer toutes les opérations (limité) avec une seule requête optimisée
                operations = compteService.listerToutesLesOperations(limit);
            }
            
            // Convertir en DTO et appliquer les filtres
            for (Operation operation : operations) {
                OperationDTO dto = new OperationDTO();
                dto.setIdOperation(operation.getIdOperation());
                dto.setMontant(operation.getMontant());
                dto.setDateOperation(operation.getDateOperation());
                dto.setDescription(operation.getDescription());
                dto.setIdCompte(operation.getCompte().getIdCompte());
                dto.setNumeroCompte(operation.getCompte().getNumeroCompte());
                
                if (operation.getTypeOperation() != null) {
                    dto.setTypeOperation(operation.getTypeOperation().getNomTypeOperation());
                    dto.setDescriptionTypeOperation(operation.getTypeOperation().getDescription());
                }
                
                // Appliquer les filtres
                boolean includeOperation = true;
                
                // Filtre par type d'opération
                if (typeOperationFilter != null && !typeOperationFilter.trim().isEmpty() && 
                    !typeOperationFilter.equals("TOUS")) {
                    if (!typeOperationFilter.equals(dto.getTypeOperation())) {
                        includeOperation = false;
                    }
                }
                
                // Filtre par période
                if (includeOperation && dateDebutStr != null && !dateDebutStr.trim().isEmpty()) {
                    try {
                        LocalDate dateDebut = LocalDate.parse(dateDebutStr);
                        if (dto.getDateOperation().toLocalDate().isBefore(dateDebut)) {
                            includeOperation = false;
                        }
                    } catch (Exception e) {
                        LOGGER.warning("Format de date début invalide: " + dateDebutStr);
                    }
                }
                
                if (includeOperation && dateFinStr != null && !dateFinStr.trim().isEmpty()) {
                    try {
                        LocalDate dateFin = LocalDate.parse(dateFinStr);
                        if (dto.getDateOperation().toLocalDate().isAfter(dateFin)) {
                            includeOperation = false;
                        }
                    } catch (Exception e) {
                        LOGGER.warning("Format de date fin invalide: " + dateFinStr);
                    }
                }
                
                if (includeOperation) {
                    operationsDTO.add(dto);
                }
            }
            
            // Calculer les statistiques
            BigDecimal totalCredits = operationsDTO.stream()
                .filter(OperationDTO::isCredit)
                .map(OperationDTO::getMontant)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
                
            BigDecimal totalDebits = operationsDTO.stream()
                .filter(OperationDTO::isDebit)
                .map(OperationDTO::getMontant)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Passer les données à la JSP
            request.setAttribute("operations", operationsDTO);
            request.setAttribute("comptes", comptesDTO);
            request.setAttribute("totalCredits", totalCredits);
            request.setAttribute("totalDebits", totalDebits);
            request.setAttribute("soldeNet", totalCredits.subtract(totalDebits));
            
            // Conserver les paramètres de filtre
            request.setAttribute("selectedCompte", idCompteFilter);
            request.setAttribute("selectedTypeOperation", typeOperationFilter);
            request.setAttribute("dateDebut", dateDebutStr);
            request.setAttribute("dateFin", dateFinStr);
            request.setAttribute("limit", limit);
            
            request.getRequestDispatcher("/jsp/operations-list.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des opérations: " + e.getMessage());
            throw new ServletException("Erreur lors de la récupération des opérations", e);
        }
    }
    
    private void exporterOperations(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Récupérer les mêmes données que pour l'affichage
        listerOperations(request, response);
        
        // TODO: Implémenter l'export CSV/Excel
        // Pour l'instant, rediriger vers la liste
        response.sendRedirect(request.getContextPath() + "/operations/list");
    }
}
