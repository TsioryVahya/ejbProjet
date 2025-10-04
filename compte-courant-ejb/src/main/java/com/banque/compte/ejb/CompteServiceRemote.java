package com.banque.compte.ejb;

import com.banque.compte.entity.Compte;
import com.banque.compte.entity.Operation;
import com.banque.compte.entity.Client;
import com.banque.compte.entity.TypeCompte;

import jakarta.ejb.Remote;
import java.math.BigDecimal;
import java.util.List;

@Remote
public interface CompteServiceRemote {
    
    // Gestion des clients
    Client creerClient(String nom, String prenom, String telephone, String email);
    Client trouverClientParId(Long idClient);
    List<Client> listerTousLesClients();
    Client modifierClient(Client client);
    
    // Gestion des types de comptes
    List<TypeCompte> listerTousLesTypesCompte();
    
    
    // Gestion des comptes
    Compte creerCompte(String numeroCompte, Long idClient, Long idTypeCompte, BigDecimal soldeInitial);
    Compte trouverCompteParId(Long idCompte);
    Compte trouverCompteParNumero(String numeroCompte);
    List<Compte> listerComptesParClient(Long idClient);
    List<Compte> listerTousLesComptes();
    BigDecimal obtenirSoldeCompte(Long idCompte);
    
    // Gestion des opérations
    Operation effectuerDepot(Long idCompte, BigDecimal montant, String description);
    Operation effectuerRetrait(Long idCompte, BigDecimal montant, String description);
    Operation effectuerVirement(Long idCompteDebiteur, Long idCompteCrediteur, BigDecimal montant, String description);
    List<Operation> listerOperationsParCompte(Long idCompte);
    List<Operation> listerOperationsParCompte(Long idCompte, int limite);
    List<Operation> listerToutesLesOperations(int limite);
    
    // Utilitaires
    boolean compteExiste(String numeroCompte);
    boolean soldeDisponible(Long idCompte, BigDecimal montant);
}
