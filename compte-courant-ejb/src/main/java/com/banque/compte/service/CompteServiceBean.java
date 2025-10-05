package com.banque.compte.service;

import com.banque.compte.ejb.CompteServiceLocal;
import com.banque.compte.ejb.CompteServiceRemote;
import com.banque.compte.entity.*;

import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.TypedQuery;
import jakarta.transaction.Transactional;
import java.math.BigDecimal;
import java.util.List;

@Stateless
@Transactional
public class CompteServiceBean implements CompteServiceLocal, CompteServiceRemote {
    
    @PersistenceContext(unitName = "BanquePU")
    private EntityManager em;
    
    // ===== GESTION DES CLIENTS =====
    
    @Override
    public Client creerClient(String nom, String prenom, String telephone, String email) {
        Client client = new Client(nom, prenom, telephone, email);
        em.persist(client);
        return client;
    }
    
    @Override
    public Client trouverClientParId(Long idClient) {
        return em.find(Client.class, idClient);
    }
    
    @Override
    public List<Client> listerTousLesClients() {
        TypedQuery<Client> query = em.createQuery("SELECT c FROM Client c ORDER BY c.nom, c.prenom", Client.class);
        return query.getResultList();
    }
    
    @Override
    public Client modifierClient(Client client) {
        return em.merge(client);
    }
    
    // ===== GESTION DES TYPES DE COMPTES =====
    
    @Override
    public List<TypeCompte> listerTousLesTypesCompte() {
        TypedQuery<TypeCompte> query = em.createQuery("SELECT t FROM TypeCompte t ORDER BY t.nomTypeCompte", TypeCompte.class);
        return query.getResultList();
    }
    
    // ===== GESTION DES COMPTES =====
    
    @Override
    public Compte creerCompte(String numeroCompte, Long idClient, Long idTypeCompte, BigDecimal soldeInitial) {
        Client client = em.find(Client.class, idClient);
        TypeCompte typeCompte = em.find(TypeCompte.class, idTypeCompte);
        
        if (client == null) {
            throw new IllegalArgumentException("Client introuvable avec l'ID: " + idClient);
        }
        if (typeCompte == null) {
            throw new IllegalArgumentException("Type de compte introuvable avec l'ID: " + idTypeCompte);
        }
        
        Compte compte = new Compte(numeroCompte, client, typeCompte);
        em.persist(compte);
        
        // Créer l'opération de solde initial si nécessaire
        if (soldeInitial != null && soldeInitial.compareTo(BigDecimal.ZERO) > 0) {
            TypeOperation typeOpSoldeInitial = trouverTypeOperationParNom("SOLDE_INITIAL");
            if (typeOpSoldeInitial != null) {
                Operation operationInitiale = new Operation(soldeInitial, 
                    "Solde initial à l'ouverture du compte", typeOpSoldeInitial, compte);
                em.persist(operationInitiale);
            }
        }
        
        return compte;
    }
    
    @Override
    public Compte trouverCompteParId(Long idCompte) {
        TypedQuery<Compte> query = em.createQuery(
            "SELECT c FROM Compte c " +
            "LEFT JOIN FETCH c.client " +
            "LEFT JOIN FETCH c.typeCompte " +
            "WHERE c.idCompte = :idCompte", Compte.class);
        query.setParameter("idCompte", idCompte);
        List<Compte> comptes = query.getResultList();
        return comptes.isEmpty() ? null : comptes.get(0);
    }
    
    @Override
    public Compte trouverCompteParNumero(String numeroCompte) {
        TypedQuery<Compte> query = em.createQuery(
            "SELECT c FROM Compte c " +
            "LEFT JOIN FETCH c.client " +
            "LEFT JOIN FETCH c.typeCompte " +
            "WHERE c.numeroCompte = :numeroCompte", Compte.class);
        query.setParameter("numeroCompte", numeroCompte);
        List<Compte> comptes = query.getResultList();
        return comptes.isEmpty() ? null : comptes.get(0);
    }
    
    @Override
    public List<Compte> listerComptesParClient(Long idClient) {
        TypedQuery<Compte> query = em.createQuery(
            "SELECT c FROM Compte c " +
            "LEFT JOIN FETCH c.client " +
            "LEFT JOIN FETCH c.typeCompte " +
            "WHERE c.client.idClient = :idClient ORDER BY c.dateCreation DESC", Compte.class);
        query.setParameter("idClient", idClient);
        return query.getResultList();
    }
    
    @Override
    public List<Compte> listerTousLesComptes() {
        TypedQuery<Compte> query = em.createQuery(
            "SELECT c FROM Compte c " +
            "LEFT JOIN FETCH c.client " +
            "LEFT JOIN FETCH c.typeCompte " +
            "ORDER BY c.dateCreation DESC", Compte.class);
        return query.getResultList();
    }
    
    @Override
    public BigDecimal obtenirSoldeCompte(Long idCompte) {
        // Utilisation de la fonction PostgreSQL calculer_solde pour calculer le solde
        String sql = "SELECT public.calculer_solde(:idCompte)";
        Object result = em.createNativeQuery(sql)
                         .setParameter("idCompte", idCompte.intValue())
                         .getSingleResult();
        return result != null ? new BigDecimal(result.toString()) : BigDecimal.ZERO;
    }
    
    // ===== GESTION DES OPÉRATIONS =====
    
    @Override
    public Operation effectuerDepot(Long idCompte, BigDecimal montant, String description) {
        if (montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Le montant du dépôt doit être positif");
        }
        
        Compte compte = em.find(Compte.class, idCompte);
        if (compte == null || !compte.getActif()) {
            throw new IllegalArgumentException("Compte introuvable ou inactif");
        }
        
        TypeOperation typeOperation = trouverTypeOperationParNom("DEPOT");
        Operation operation = new Operation(montant, description, typeOperation, compte);
        em.persist(operation);
        
        return operation;
    }
    
    @Override
    public Operation effectuerRetrait(Long idCompte, BigDecimal montant, String description) {
        if (montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Le montant du retrait doit être positif");
        }
        
        Compte compte = em.find(Compte.class, idCompte);
        if (compte == null || !compte.getActif()) {
            throw new IllegalArgumentException("Compte introuvable ou inactif");
        }
        
        // Vérifier le solde disponible
        if (!soldeDisponible(idCompte, montant)) {
            throw new IllegalArgumentException("Solde insuffisant pour effectuer ce retrait");
        }
        
        TypeOperation typeOperation = trouverTypeOperationParNom("RETRAIT");
        Operation operation = new Operation(montant, description, typeOperation, compte);
        em.persist(operation);
        
        return operation;
    }
    
    @Override
    public Operation effectuerVirement(Long idCompteDebiteur, Long idCompteCrediteur, BigDecimal montant, String description) {
        if (montant.compareTo(BigDecimal.ZERO) <= 0) {
            throw new IllegalArgumentException("Le montant du virement doit être positif");
        }
        
        Compte compteDebiteur = em.find(Compte.class, idCompteDebiteur);
        Compte compteCrediteur = em.find(Compte.class, idCompteCrediteur);
        
        if (compteDebiteur == null || !compteDebiteur.getActif()) {
            throw new IllegalArgumentException("Compte débiteur introuvable ou inactif");
        }
        if (compteCrediteur == null || !compteCrediteur.getActif()) {
            throw new IllegalArgumentException("Compte créditeur introuvable ou inactif");
        }
        
        // Vérifier le solde disponible
        if (!soldeDisponible(idCompteDebiteur, montant)) {
            throw new IllegalArgumentException("Solde insuffisant pour effectuer ce virement");
        }
        
        // Créer l'opération de débit
        TypeOperation typeOperationDebit = trouverTypeOperationParNom("VIREMENT_DEBIT");
        Operation operationDebit = new Operation(montant, 
            "Virement vers " + compteCrediteur.getNumeroCompte() + " - " + description, 
            typeOperationDebit, compteDebiteur);
        em.persist(operationDebit);
        
        // Créer l'opération de crédit
        TypeOperation typeOperationCredit = trouverTypeOperationParNom("VIREMENT_CREDIT");
        Operation operationCredit = new Operation(montant, 
            "Virement de " + compteDebiteur.getNumeroCompte() + " - " + description, 
            typeOperationCredit, compteCrediteur);
        em.persist(operationCredit);
        
        return operationDebit; // Retourner l'opération de débit comme référence
    }
    
    @Override
    public List<Operation> listerOperationsParCompte(Long idCompte) {
        TypedQuery<Operation> query = em.createQuery(
            "SELECT o FROM Operation o " +
            "LEFT JOIN FETCH o.compte " +
            "LEFT JOIN FETCH o.typeOperation " +
            "WHERE o.compte.idCompte = :idCompte ORDER BY o.dateOperation DESC", 
            Operation.class);
        query.setParameter("idCompte", idCompte);
        return query.getResultList();
    }
    
    @Override
    public List<Operation> listerOperationsParCompte(Long idCompte, int limite) {
        TypedQuery<Operation> query = em.createQuery(
            "SELECT o FROM Operation o " +
            "LEFT JOIN FETCH o.compte " +
            "LEFT JOIN FETCH o.typeOperation " +
            "WHERE o.compte.idCompte = :idCompte ORDER BY o.dateOperation DESC", 
            Operation.class);
        query.setParameter("idCompte", idCompte);
        query.setMaxResults(limite);
        return query.getResultList();
    }
    
    @Override
    public List<Operation> listerToutesLesOperations(int limite) {
        TypedQuery<Operation> query = em.createQuery(
            "SELECT o FROM Operation o " +
            "LEFT JOIN FETCH o.compte " +
            "LEFT JOIN FETCH o.typeOperation " +
            "ORDER BY o.dateOperation DESC", 
            Operation.class);
        query.setMaxResults(limite);
        return query.getResultList();
    }
    
    // ===== UTILITAIRES =====
    
    @Override
    public boolean compteExiste(String numeroCompte) {
        TypedQuery<Long> query = em.createQuery(
            "SELECT COUNT(c) FROM Compte c WHERE c.numeroCompte = :numeroCompte", Long.class);
        query.setParameter("numeroCompte", numeroCompte);
        return query.getSingleResult() > 0;
    }
    
    @Override
    public boolean soldeDisponible(Long idCompte, BigDecimal montant) {
        BigDecimal soldeActuel = obtenirSoldeCompte(idCompte);
        return soldeActuel.compareTo(montant) >= 0;
    }
    
    // Méthode utilitaire privée
    private TypeOperation trouverTypeOperationParNom(String nomTypeOperation) {
        TypedQuery<TypeOperation> query = em.createQuery(
            "SELECT t FROM TypeOperation t WHERE t.nomTypeOperation = :nom", TypeOperation.class);
        query.setParameter("nom", nomTypeOperation);
        List<TypeOperation> types = query.getResultList();
        return types.isEmpty() ? null : types.get(0);
    }
}
