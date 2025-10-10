package com.banque.central.controller;

import com.banque.central.dto.CompteDTO;
import com.banque.central.dto.OperationDTO;
import com.banque.compte.ejb.CompteServiceRemote;
import com.banque.compte.entity.Client;
import com.banque.compte.entity.Compte;
import com.banque.compte.entity.Operation;
import com.banque.compte.entity.TypeCompte;

import jakarta.ejb.EJB;
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

@WebServlet("/compte/*")
public class CompteServlet extends HttpServlet {
    
    private static final Logger LOGGER = Logger.getLogger(CompteServlet.class.getName());
    
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
                    listerComptes(request, response);
                    break;
                case "details":
                    afficherDetailsCompte(request, response);
                    break;
                case "nouveau":
                    afficherFormulaireNouveauCompte(request, response);
                    break;
                case "operations":
                    afficherOperations(request, response);
                    break;
                default:
                    listerComptes(request, response);
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans CompteServlet: " + e.getMessage());
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
                    creerCompte(request, response);
                    break;
                case "depot":
                    effectuerDepot(request, response);
                    break;
                case "retrait":
                    effectuerRetrait(request, response);
                    break;
                case "virement":
                    effectuerVirement(request, response);
                    break;
                default:
                    response.sendRedirect(request.getContextPath() + "/compte/list");
                    break;
            }
        } catch (Exception e) {
            LOGGER.severe("Erreur dans CompteServlet POST: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors du traitement de la demande: " + e.getMessage());
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void listerComptes(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        List<CompteDTO> comptesDTO = new ArrayList<>();
        
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
            
            List<Compte> comptes = compteService.listerTousLesComptes();
            
            for (Compte compte : comptes) {
                BigDecimal solde = compteService.obtenirSoldeCompte(compte.getIdCompte());
                
                CompteDTO dto = new CompteDTO();
                dto.setIdCompte(compte.getIdCompte());
                dto.setNumeroCompte(compte.getNumeroCompte());
                dto.setDateCreation(compte.getDateCreation());
                dto.setActif(compte.getActif());
                dto.setSolde(solde);
                
                if (compte.getClient() != null) {
                    dto.setIdClient(compte.getClient().getIdClient());
                    dto.setNomClient(compte.getClient().getNom());
                    dto.setPrenomClient(compte.getClient().getPrenom());
                    dto.setEmailClient(compte.getClient().getEmail());
                    dto.setTelephoneClient(compte.getClient().getTelephone());
                }
                
                if (compte.getTypeCompte() != null) {
                    dto.setIdTypeCompte(compte.getTypeCompte().getIdTypeCompte());
                    dto.setNomTypeCompte(compte.getTypeCompte().getNomTypeCompte());
                    dto.setDescriptionTypeCompte(compte.getTypeCompte().getDescription());
                }
                
                comptesDTO.add(dto);
            }
            
            request.setAttribute("comptes", comptesDTO);
            request.getRequestDispatcher("/jsp/compte.jsp").forward(request, response);
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la récupération des comptes: " + e.getMessage());
            throw new ServletException("Erreur lors de la récupération des comptes", e);
        }
    }
    
    private void afficherDetailsCompte(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("id");
        if (idCompteStr == null || idCompteStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/compte/list");
            return;
        }
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            Compte compte = compteService.trouverCompteParId(idCompte);
            
            if (compte == null) {
                request.setAttribute("erreur", "Compte introuvable");
                request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
                return;
            }
            
            // Convertir en DTO
            CompteDTO compteDTO = new CompteDTO();
            compteDTO.setIdCompte(compte.getIdCompte());
            compteDTO.setNumeroCompte(compte.getNumeroCompte());
            compteDTO.setDateCreation(compte.getDateCreation());
            compteDTO.setDateModification(compte.getDateModification());
            compteDTO.setActif(compte.getActif());
            compteDTO.setSolde(compteService.obtenirSoldeCompte(idCompte));
            
            if (compte.getClient() != null) {
                compteDTO.setIdClient(compte.getClient().getIdClient());
                compteDTO.setNomClient(compte.getClient().getNom());
                compteDTO.setPrenomClient(compte.getClient().getPrenom());
                compteDTO.setEmailClient(compte.getClient().getEmail());
                compteDTO.setTelephoneClient(compte.getClient().getTelephone());
            }
            
            if (compte.getTypeCompte() != null) {
                compteDTO.setIdTypeCompte(compte.getTypeCompte().getIdTypeCompte());
                compteDTO.setNomTypeCompte(compte.getTypeCompte().getNomTypeCompte());
                compteDTO.setDescriptionTypeCompte(compte.getTypeCompte().getDescription());
            }
            
            request.setAttribute("compte", compteDTO);
            request.getRequestDispatcher("/jsp/compte-details.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "ID de compte invalide");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherOperations(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("id");
        if (idCompteStr == null || idCompteStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/compte/list");
            return;
        }
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            List<Operation> operations = compteService.listerOperationsParCompte(idCompte, 50);
            
            List<OperationDTO> operationsDTO = new ArrayList<>();
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
                
                operationsDTO.add(dto);
            }
            
            Compte compte = compteService.trouverCompteParId(idCompte);
            request.setAttribute("compte", compte);
            request.setAttribute("operations", operationsDTO);
            request.getRequestDispatcher("/jsp/operations.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            request.setAttribute("erreur", "ID de compte invalide");
            request.getRequestDispatcher("/jsp/erreur.jsp").forward(request, response);
        }
    }
    
    private void afficherFormulaireNouveauCompte(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            List<Client> clients = compteService.listerTousLesClients();
            List<TypeCompte> typesCompte = compteService.listerTousLesTypesCompte();
            
            request.setAttribute("clients", clients);
            request.setAttribute("typesCompte", typesCompte);
            request.getRequestDispatcher("/jsp/nouveau-compte.jsp").forward(request, response);
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de l'affichage du formulaire: " + e.getMessage());
            throw new ServletException("Erreur lors de l'affichage du formulaire", e);
        }
    }
    
    private void creerCompte(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String numeroCompte = request.getParameter("numeroCompte");
        String idClientStr = request.getParameter("idClient");
        String idTypeCompteStr = request.getParameter("idTypeCompte");
        String soldeInitialStr = request.getParameter("soldeInitial");
        
        try {
            Long idClient = Long.parseLong(idClientStr);
            Long idTypeCompte = Long.parseLong(idTypeCompteStr);
            BigDecimal soldeInitial = new BigDecimal(soldeInitialStr != null ? soldeInitialStr : "0");
            
            Compte nouveauCompte = compteService.creerCompte(numeroCompte, idClient, idTypeCompte, soldeInitial);
            
            request.getSession().setAttribute("succes", 
                String.format("Compte %s créé avec succès pour le client", numeroCompte));
            response.sendRedirect(request.getContextPath() + "/compte/list");
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors de la création du compte: " + e.getMessage());
            request.setAttribute("erreur", "Erreur lors de la création du compte: " + e.getMessage());
            afficherFormulaireNouveauCompte(request, response);
        }
    }
    
    private void effectuerDepot(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("idCompte");
        String montantStr = request.getParameter("montant");
        String description = request.getParameter("description");
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            BigDecimal montant = new BigDecimal(montantStr);
            
            if (montant.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Le montant doit être positif");
            }
            
            Operation operation = compteService.effectuerDepot(idCompte, montant, description);
            
            // Utiliser la session pour passer le message de succès
            request.getSession().setAttribute("succes", 
                String.format("Dépôt de %.2f€ effectué avec succès sur le compte", montant));
            response.sendRedirect(request.getContextPath() + "/compte/list");
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors du dépôt: " + e.getMessage());
            request.getSession().setAttribute("erreur", "Erreur lors du dépôt: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/compte/list");
        }
    }
    
    private void effectuerRetrait(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String idCompteStr = request.getParameter("idCompte");
        String montantStr = request.getParameter("montant");
        String description = request.getParameter("description");
        
        try {
            Long idCompte = Long.parseLong(idCompteStr);
            BigDecimal montant = new BigDecimal(montantStr);
            
            if (montant.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Le montant doit être positif");
            }
            
            Operation operation = compteService.effectuerRetrait(idCompte, montant, description);
            
            // Utiliser la session pour passer le message de succès
            request.getSession().setAttribute("succes", 
                String.format("Retrait de %.2f€ effectué avec succès sur le compte", montant));
            response.sendRedirect(request.getContextPath() + "/compte/list");
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors du retrait: " + e.getMessage());
            request.getSession().setAttribute("erreur", "Erreur lors du retrait: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/compte/list");
        }
    }
    
    private void effectuerVirement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Support pour les deux formats de paramètres
        String idCompteSourceStr = request.getParameter("idCompteSource");
        String idCompteDebiteurStr = request.getParameter("idCompteDebiteur");
        String compteDestination = request.getParameter("compteDestination");
        String idCompteCrediteurStr = request.getParameter("idCompteCrediteur");
        String montantStr = request.getParameter("montant");
        String description = request.getParameter("description");
        
        try {
            // Utiliser idCompteSource si disponible, sinon idCompteDebiteur
            Long idCompteDebiteur = Long.parseLong(idCompteSourceStr != null ? idCompteSourceStr : idCompteDebiteurStr);
            
            Long idCompteCrediteur;
            if (idCompteCrediteurStr != null) {
                // Virement classique avec ID
                idCompteCrediteur = Long.parseLong(idCompteCrediteurStr);
            } else if (compteDestination != null) {
                // Virement rapide avec numéro de compte
                Compte compteDestinataire = compteService.trouverCompteParNumero(compteDestination);
                if (compteDestinataire == null) {
                    throw new IllegalArgumentException("Compte de destination introuvable: " + compteDestination);
                }
                idCompteCrediteur = compteDestinataire.getIdCompte();
            } else {
                throw new IllegalArgumentException("Compte de destination non spécifié");
            }
            
            BigDecimal montant = new BigDecimal(montantStr);
            
            if (montant.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Le montant doit être positif");
            }
            
            if (idCompteDebiteur.equals(idCompteCrediteur)) {
                throw new IllegalArgumentException("Le compte source et destination ne peuvent pas être identiques");
            }
            
            Operation operation = compteService.effectuerVirement(idCompteDebiteur, idCompteCrediteur, montant, description);
            
            // Utiliser la session pour passer le message de succès
            request.getSession().setAttribute("succes", 
                String.format("Virement de %.2f€ effectué avec succès", montant));
            response.sendRedirect(request.getContextPath() + "/compte/list");
            
        } catch (Exception e) {
            LOGGER.severe("Erreur lors du virement: " + e.getMessage());
            request.getSession().setAttribute("erreur", "Erreur lors du virement: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/compte/list");
        }
    }
}
