-- ========================================
-- SUPPRESSION DES TABLES EXISTANTES
-- ========================================
DROP TABLE IF EXISTS RetraitEpargne CASCADE;
DROP TABLE IF EXISTS DepotEpargne CASCADE;
DROP TABLE IF EXISTS Remboursement CASCADE;
DROP TABLE IF EXISTS Prets CASCADE;
DROP TABLE IF EXISTS Operations CASCADE;
DROP TABLE IF EXISTS Compte CASCADE;
DROP TABLE IF EXISTS TypeOperation CASCADE;
DROP TABLE IF EXISTS TypeCompte CASCADE;
DROP TABLE IF EXISTS Client CASCADE;
DROP TABLE IF EXISTS TauxPret CASCADE;
DROP TABLE IF EXISTS TauxEpargne CASCADE;

-- ========================================
-- CREATION DES TABLES
-- ========================================

-- Table Client
CREATE TABLE Client(
   idClient BIGSERIAL PRIMARY KEY,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   telephone VARCHAR(15),
   email VARCHAR(100),
   dateCreation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table TypeCompte
CREATE TABLE TypeCompte(
   idTypeCompte BIGSERIAL PRIMARY KEY,
   nomTypeCompte VARCHAR(50) NOT NULL UNIQUE,
   description TEXT,
   dateCreation TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table TypeOperation
CREATE TABLE TypeOperation(
   idTypeOperation BIGSERIAL PRIMARY KEY,
   nomTypeOperation VARCHAR(50) NOT NULL UNIQUE,
   description TEXT
);

-- Table TauxPret
CREATE TABLE TauxPret(
   idTaux BIGSERIAL PRIMARY KEY,
   pourcentage NUMERIC(5,2) NOT NULL CHECK (pourcentage >= 0 AND pourcentage <= 100),
   dateApplication TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table TauxEpargne
CREATE TABLE TauxEpargne(
   idTaux BIGSERIAL PRIMARY KEY,
   pourcentage NUMERIC(5,2) NOT NULL CHECK (pourcentage >= 0 AND pourcentage <= 100),
   dateApplication TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table Compte
CREATE TABLE Compte(
   idCompte BIGSERIAL PRIMARY KEY,
   numeroCompte VARCHAR(50) NOT NULL UNIQUE,
   dateCreation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   dateModification TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
   actif BOOLEAN DEFAULT TRUE,
   idClient INTEGER NOT NULL,
   idTypeCompte INTEGER NOT NULL,
   FOREIGN KEY(idClient) REFERENCES Client(idClient) ON DELETE RESTRICT,
   FOREIGN KEY(idTypeCompte) REFERENCES TypeCompte(idTypeCompte) ON DELETE RESTRICT
);

-- Table Operations
CREATE TABLE Operations(
   idOperation BIGSERIAL PRIMARY KEY,
   montant NUMERIC(15,2) NOT NULL,
   dateOperation TIMESTAMP ,
   description TEXT,
   idTypeOperation INTEGER NOT NULL,
   idCompte INTEGER NOT NULL,
   FOREIGN KEY(idTypeOperation) REFERENCES TypeOperation(idTypeOperation) ON DELETE RESTRICT,
   FOREIGN KEY(idCompte) REFERENCES Compte(idCompte) ON DELETE CASCADE
);

-- Table Prets
CREATE TABLE Prets(
   idPret BIGSERIAL PRIMARY KEY,
   duree INTEGER NOT NULL CHECK (duree > 0),
   datePret TIMESTAMP  ,
   montantInitial NUMERIC(15,2) NOT NULL CHECK (montantInitial > 0),
   montantRestant NUMERIC(15,2) NOT NULL,
   statut VARCHAR(20) DEFAULT 'ACTIF',
   idTaux INTEGER NOT NULL,
   idCompte INTEGER NOT NULL,
   FOREIGN KEY(idTaux) REFERENCES TauxPret(idTaux) ON DELETE RESTRICT,
   FOREIGN KEY(idCompte) REFERENCES Compte(idCompte) ON DELETE CASCADE
);

-- Table Remboursement
CREATE TABLE Remboursement(
   idRemboursement BIGSERIAL PRIMARY KEY,
   montantRembourser NUMERIC(15,2) NOT NULL CHECK (montantRembourser > 0),
   dateRemboursement TIMESTAMP ,
   idPret INTEGER NOT NULL,
   FOREIGN KEY(idPret) REFERENCES Prets(idPret) ON DELETE CASCADE
);

-- Table DepotEpargne
CREATE TABLE DepotEpargne(
   idDepotEpargne BIGSERIAL PRIMARY KEY,
   montantEpargne NUMERIC(15,2) NOT NULL CHECK (montantEpargne > 0),
   dateEpargne TIMESTAMP  ,
   idCompte INTEGER NOT NULL,
   idTaux INTEGER NOT NULL,
   FOREIGN KEY(idCompte) REFERENCES Compte(idCompte) ON DELETE CASCADE,
   FOREIGN KEY(idTaux) REFERENCES TauxEpargne(idTaux) ON DELETE RESTRICT
);

-- Table RetraitEpargne
CREATE TABLE RetraitEpargne(
   idRetraitEpargne BIGSERIAL PRIMARY KEY,
   montantRetraitEpargne NUMERIC(15,2) NOT NULL CHECK (montantRetraitEpargne > 0),
   dateRetraitEpargne TIMESTAMP  ,
   idDepotEpargne INTEGER NOT NULL,
   FOREIGN KEY(idDepotEpargne) REFERENCES DepotEpargne(idDepotEpargne) ON DELETE CASCADE
);

-- ========================================
-- INSERTIONS DE DONNÉES DE BASE
-- ========================================

INSERT INTO Client (nom, prenom, telephone, email) VALUES 
('Dupont', 'Jean', '0123456789', 'jean.dupont@email.com'),
('Martin', 'Marie', '0234567890', 'marie.martin@email.com'),
('Bernard', 'Pierre', '0345678901', 'pierre.bernard@email.com'),
('Durand', 'Sophie', '0456789012', 'sophie.durand@email.com'),
('Moreau', 'Luc', '0567890123', 'luc.moreau@email.com');

INSERT INTO TypeCompte (nomTypeCompte, description) VALUES 
('Compte Courant', 'Compte pour les opérations courantes'),
('Compte Épargne', 'Compte d''épargne avec intérêts'),
('Compte Jeune', 'Compte spécial pour les jeunes de moins de 25 ans'),
('Compte Professionnel', 'Compte destiné aux professionnels et entreprises'),
('Livret A', 'Livret d''épargne réglementé');

INSERT INTO TypeOperation (nomTypeOperation, description) VALUES 
('DEPOT', 'Dépôt d''argent sur le compte (crédit)'),
('RETRAIT', 'Retrait d''argent du compte (débit)'),
('VIREMENT_CREDIT', 'Virement reçu (crédit)'),
('VIREMENT_DEBIT', 'Virement émis (débit)'),
('PRELEVEMENT', 'Prélèvement automatique (débit)'),
('INTERETS', 'Versement d''intérêts (crédit)'),
('FRAIS', 'Frais bancaires (débit)'),
('SOLDE_INITIAL', 'Solde initial à l''ouverture du compte (crédit)');

INSERT INTO TauxPret (pourcentage) VALUES (2.50),(3.75),(4.20),(1.90);
INSERT INTO TauxEpargne (pourcentage) VALUES (0.75),(1.25),(2.00),(0.50);

-- ========================================
-- VUE DE CALCUL DES SOLDES
-- ========================================

CREATE OR REPLACE VIEW v_comptes_avec_solde AS
SELECT 
    c.idCompte,
    c.numeroCompte,
    c.dateCreation,
    c.dateModification,
    c.actif,
    c.idClient,
    c.idTypeCompte,
    cl.nom,
    cl.prenom,
    tc.nomTypeCompte,
    COALESCE(
        (SELECT SUM(
            CASE 
                WHEN t.nomTypeOperation IN ('DEPOT', 'VIREMENT_CREDIT', 'INTERETS', 'SOLDE_INITIAL') 
                THEN o.montant
                WHEN t.nomTypeOperation IN ('RETRAIT', 'VIREMENT_DEBIT', 'PRELEVEMENT', 'FRAIS') 
                THEN -o.montant
                ELSE 0
            END
        )
        FROM Operations o
        JOIN TypeOperation t ON o.idTypeOperation = t.idTypeOperation
        WHERE o.idCompte = c.idCompte), 0
    ) AS solde
FROM Compte c
JOIN Client cl ON c.idClient = cl.idClient
JOIN TypeCompte tc ON c.idTypeCompte = tc.idTypeCompte;

-- ========================================
-- FONCTIONS UTILES
-- ========================================

CREATE OR REPLACE FUNCTION calculer_solde(p_idCompte INTEGER)
RETURNS NUMERIC(15,2) AS $$
BEGIN
    RETURN COALESCE(
        (SELECT SUM(
            CASE 
                WHEN t.nomTypeOperation IN ('DEPOT', 'VIREMENT_CREDIT', 'INTERETS', 'SOLDE_INITIAL') 
                THEN o.montant
                WHEN t.nomTypeOperation IN ('RETRAIT', 'VIREMENT_DEBIT', 'PRELEVEMENT', 'FRAIS') 
                THEN -o.montant
                ELSE 0
            END
        )
        FROM Operations o
        JOIN TypeOperation t ON o.idTypeOperation = t.idTypeOperation
        WHERE o.idCompte = p_idCompte), 0
    );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION creer_compte_avec_solde(
    p_numeroCompte VARCHAR(50),
    p_idClient INTEGER,
    p_idTypeCompte INTEGER,
    p_soldeInitial NUMERIC(15,2) DEFAULT 0
)
RETURNS INTEGER AS $$
DECLARE
    v_idCompte INTEGER;
    v_idTypeOperationDepot INTEGER;
BEGIN
    INSERT INTO Compte (numeroCompte, idClient, idTypeCompte)
    VALUES (p_numeroCompte, p_idClient, p_idTypeCompte)
    RETURNING idCompte INTO v_idCompte;
    
    IF p_soldeInitial > 0 THEN
        SELECT idTypeOperation INTO v_idTypeOperationDepot
        FROM TypeOperation 
        WHERE nomTypeOperation = 'SOLDE_INITIAL';
        
        INSERT INTO Operations (montant, description, idTypeOperation, idCompte)
        VALUES (p_soldeInitial, 'Solde initial à l''ouverture du compte', v_idTypeOperationDepot, v_idCompte);
    END IF;
    
    RETURN v_idCompte;
END;
$$ LANGUAGE plpgsql;

-- ========================================
-- INDEX POUR LES PERFORMANCES
-- ========================================

CREATE INDEX idx_compte_numero ON Compte(numeroCompte);
CREATE INDEX idx_compte_client ON Compte(idClient);
CREATE INDEX idx_operations_compte ON Operations(idCompte);
CREATE INDEX idx_operations_date ON Operations(dateOperation);
CREATE INDEX idx_operations_type ON Operations(idTypeOperation);

-- ========================================
-- EXEMPLES D'UTILISATION
-- ========================================

-- Création d'un compte avec solde initial
SELECT creer_compte_avec_solde('FR76 1234 5678 9012 3456 78', 1, 1, 1000.00) as nouveau_compte_id;

-- Dépôt
INSERT INTO Operations (montant, description, idTypeOperation, idCompte)
SELECT 500.00, 'Dépôt en espèces', idTypeOperation, 1
FROM TypeOperation WHERE nomTypeOperation = 'DEPOT';

-- Retrait
INSERT INTO Operations (montant, description, idTypeOperation, idCompte)
SELECT 200.00, 'Retrait DAB', idTypeOperation, 1
FROM TypeOperation WHERE nomTypeOperation = 'RETRAIT';

-- Vérification
SELECT * FROM v_comptes_avec_solde ORDER BY idCompte;
SELECT * FROM Operations ORDER BY dateOperation DESC;
