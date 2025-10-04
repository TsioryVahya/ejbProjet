-- Script pour corriger les problèmes de vues PostgreSQL
-- Ce script supprime temporairement les vues qui bloquent les modifications de colonnes

-- Supprimer la vue problématique
DROP VIEW IF EXISTS v_comptes_avec_solde CASCADE;

-- Vous pouvez recréer la vue après que Hibernate ait fait ses modifications
-- Exemple de recréation de la vue (à adapter selon vos besoins) :
-- CREATE VIEW v_comptes_avec_solde AS
-- SELECT 
--     c.idcompte,
--     c.numerocompte,
--     c.datecreation,
--     cl.nom,
--     cl.prenom,
--     tc.nomtypecompte,
--     COALESCE(SUM(o.montant), 0) as solde
-- FROM compte c
-- LEFT JOIN client cl ON c.idclient = cl.idclient
-- LEFT JOIN typecompte tc ON c.idtypecompte = tc.idtypecompte
-- LEFT JOIN operations o ON c.idcompte = o.idcompte
-- GROUP BY c.idcompte, c.numerocompte, c.datecreation, cl.nom, cl.prenom, tc.nomtypecompte;
