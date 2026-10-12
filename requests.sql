-- PALIER 1 : vérifier les quantités de données.
SELECT COUNT(*) AS nombre_parties,
       MIN(date_game) AS premiere_partie,
       MAX(date_game) AS derniere_partie
FROM GameReplay;

SELECT COUNT(*) AS nombre_scores FROM GameScore;

