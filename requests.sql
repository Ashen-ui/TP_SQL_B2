-- PALIER 1 : vérifier les quantités de données.
SELECT COUNT(*) AS nombre_parties,
       MIN(date_game) AS premiere_partie,
       MAX(date_game) AS derniere_partie
FROM GameReplay;

SELECT COUNT(*) AS nombre_scores FROM GameScore;

-- PALIER 2 : fonctions de fenetre

-- 1. Classement des scores dans chaque partie.
SELECT game_id, player_id, score,
       RANK() OVER (PARTITION BY game_id ORDER BY score DESC) AS rang
FROM GameScore;

-- 2. Les 3 meilleurs scores de chaque partie.
WITH classement AS (
    SELECT game_id, player_id, score,
           ROW_NUMBER() OVER (
               PARTITION BY game_id ORDER BY score DESC
           ) AS rang
    FROM GameScore
)
SELECT game_id, player_id, score
FROM classement
WHERE rang <= 3;

