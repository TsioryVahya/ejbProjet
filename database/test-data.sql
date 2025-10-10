-- ========================================
-- DONNÉES DE TEST POUR LE SYSTÈME BANCAIRE
-- ========================================

-- Insertion des types de comptes
INSERT INTO TypeCompte (nomTypeCompte, description) VALUES 
('COURANT', 'Compte courant standard'),
('EPARGNE', 'Compte d''épargne avec intérêts'),
('PROFESSIONNEL', 'Compte professionnel pour entreprises');

-- Insertion des types d'opérations
INSERT INTO TypeOperation (nomTypeOperation, description) VALUES 
('DEPOT', 'Dépôt d''argent sur le compte'),
('RETRAIT', 'Retrait d''argent du compte'),
('VIREMENT_DEBIT', 'Virement sortant (débit)'),
('VIREMENT_CREDIT', 'Virement entrant (crédit)'),
('FRAIS', 'Frais bancaires'),
('INTERETS', 'Intérêts créditeurs');

-- Insertion des taux pour les prêts
INSERT INTO TauxPret (pourcentage) VALUES 
(3.50),
(4.25),
(5.00);

-- Insertion des taux pour l'épargne
INSERT INTO TauxEpargne (pourcentage) VALUES 
(1.50),
(2.00),
(2.75);

-- Insertion de clients de test
INSERT INTO Client (nom, prenom, telephone, email) VALUES 
('MARTIN', 'Jean', '0123456789', 'jean.martin@email.com'),
('DUBOIS', 'Marie', '0234567890', 'marie.dubois@email.com'),
('BERNARD', 'Pierre', '0345678901', 'pierre.bernard@email.com'),
('THOMAS', 'Sophie', '0456789012', 'sophie.thomas@email.com'),
('PETIT', 'Luc', '0567890123', 'luc.petit@email.com');

-- Insertion de comptes de test
INSERT INTO Compte (numeroCompte, idClient, idTypeCompte) VALUES 
('CC001001', 1, 1),  -- Compte courant de Jean MARTIN
('CC001002', 2, 1),  -- Compte courant de Marie DUBOIS
('EP001001', 1, 2),  -- Compte épargne de Jean MARTIN
('CC001003', 3, 1),  -- Compte courant de Pierre BERNARD
('PR001001', 4, 3),  -- Compte professionnel de Sophie THOMAS
('CC001004', 5, 1);  -- Compte courant de Luc PETIT

-- Insertion d'opérations de test
-- Opérations pour le compte CC001001 (Jean MARTIN)
INSERT INTO Operations (montant, dateOperation, description, idTypeOperation, idCompte) VALUES 
(1000.00, CURRENT_TIMESTAMP - INTERVAL '30 days', 'Dépôt initial', 1, 1),
(500.00, CURRENT_TIMESTAMP - INTERVAL '25 days', 'Virement salaire', 4, 1),
(-50.00, CURRENT_TIMESTAMP - INTERVAL '20 days', 'Retrait DAB', 2, 1),
(-25.00, CURRENT_TIMESTAMP - INTERVAL '15 days', 'Virement vers épargne', 3, 1),
(1200.00, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Virement salaire', 4, 1),
(-80.00, CURRENT_TIMESTAMP - INTERVAL '5 days', 'Achat en ligne', 2, 1);

-- Opérations pour le compte CC001002 (Marie DUBOIS)
INSERT INTO Operations (montant, dateOperation, description, idTypeOperation, idCompte) VALUES 
(800.00, CURRENT_TIMESTAMP - INTERVAL '28 days', 'Dépôt initial', 1, 2),
(750.00, CURRENT_TIMESTAMP - INTERVAL '22 days', 'Virement salaire', 4, 2),
(-120.00, CURRENT_TIMESTAMP - INTERVAL '18 days', 'Courses alimentaires', 2, 2),
(-45.00, CURRENT_TIMESTAMP - INTERVAL '12 days', 'Essence', 2, 2),
(750.00, CURRENT_TIMESTAMP - INTERVAL '8 days', 'Virement salaire', 4, 2);

-- Opérations pour le compte EP001001 (Épargne Jean MARTIN)
INSERT INTO Operations (montant, dateOperation, description, idTypeOperation, idCompte) VALUES 
(25.00, CURRENT_TIMESTAMP - INTERVAL '15 days', 'Virement depuis compte courant', 4, 3),
(2.50, CURRENT_TIMESTAMP - INTERVAL '1 days', 'Intérêts mensuels', 6, 3);

-- Opérations pour le compte CC001003 (Pierre BERNARD)
INSERT INTO Operations (montant, dateOperation, description, idTypeOperation, idCompte) VALUES 
(1500.00, CURRENT_TIMESTAMP - INTERVAL '20 days', 'Dépôt initial', 1, 4),
(-200.00, CURRENT_TIMESTAMP - INTERVAL '15 days', 'Retrait', 2, 4),
(-300.00, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Virement loyer', 3, 4);

-- Opérations pour le compte PR001001 (Sophie THOMAS - Professionnel)
INSERT INTO Operations (montant, dateOperation, description, idTypeOperation, idCompte) VALUES 
(5000.00, CURRENT_TIMESTAMP - INTERVAL '25 days', 'Capital initial', 1, 5),
(2500.00, CURRENT_TIMESTAMP - INTERVAL '20 days', 'Facture client', 4, 5),
(-800.00, CURRENT_TIMESTAMP - INTERVAL '15 days', 'Achat matériel', 2, 5),
(-150.00, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Frais bancaires', 5, 5);

-- Opérations pour le compte CC001004 (Luc PETIT)
INSERT INTO Operations (montant, dateOperation, description, idTypeOperation, idCompte) VALUES 
(600.00, CURRENT_TIMESTAMP - INTERVAL '15 days', 'Dépôt initial', 1, 6),
(-100.00, CURRENT_TIMESTAMP - INTERVAL '10 days', 'Retrait', 2, 6);

-- Insertion de quelques prêts de test
INSERT INTO Prets (duree, datePret, montantInitial, montantRestant, idTaux, idCompte) VALUES 
(240, CURRENT_TIMESTAMP - INTERVAL '60 days', 150000.00, 145000.00, 1, 1),  -- Prêt immobilier Jean MARTIN
(60, CURRENT_TIMESTAMP - INTERVAL '30 days', 25000.00, 23000.00, 2, 4);     -- Prêt auto Pierre BERNARD

-- Insertion de quelques remboursements
INSERT INTO Remboursement (montantRembourser, dateRemboursement, idPret) VALUES 
(625.00, CURRENT_TIMESTAMP - INTERVAL '30 days', 1),  -- Remboursement prêt immobilier
(625.00, CURRENT_TIMESTAMP - INTERVAL '1 days', 1),   -- Remboursement prêt immobilier
(416.67, CURRENT_TIMESTAMP - INTERVAL '15 days', 2);  -- Remboursement prêt auto

-- Insertion de dépôts d'épargne
INSERT INTO DepotEpargne (montantEpargne, dateEpargne, idCompte, idTaux) VALUES 
(1000.00, CURRENT_TIMESTAMP - INTERVAL '90 days', 3, 1),  -- Épargne Jean MARTIN
(500.00, CURRENT_TIMESTAMP - INTERVAL '60 days', 3, 1);   -- Épargne Jean MARTIN

-- Insertion de retraits d'épargne
INSERT INTO RetraitEpargne (montantRetraitEpargne, dateRetraitEpargne, idDepotEpargne) VALUES 
(200.00, CURRENT_TIMESTAMP - INTERVAL '30 days', 1);  -- Retrait partiel épargne

-- Affichage des résultats pour vérification
SELECT 'Clients créés:' as info, COUNT(*) as nombre FROM Client
UNION ALL
SELECT 'Comptes créés:', COUNT(*) FROM Compte
UNION ALL
SELECT 'Opérations créées:', COUNT(*) FROM Operations
UNION ALL
SELECT 'Prêts créés:', COUNT(*) FROM Prets;
