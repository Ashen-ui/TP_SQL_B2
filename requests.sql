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

-- 3. Temps de jeu cumule par mois.
SELECT date_trunc('month', date_game) AS mois,
       SUM(time_duration) AS duree_mois,
       SUM(SUM(time_duration)) OVER (
           ORDER BY date_trunc('month', date_game)
       ) AS duree_cumulee
FROM GameReplay
GROUP BY date_trunc('month', date_game);

-- 4. Nombre de parties compare au mois precedent.
WITH parties_mois AS (
    SELECT date_trunc('month', date_game) AS mois, COUNT(*) AS nombre
    FROM GameReplay
    GROUP BY date_trunc('month', date_game)
),
evolution AS (
    SELECT mois, nombre, LAG(nombre) OVER (ORDER BY mois) AS precedent
    FROM parties_mois
)
SELECT mois, nombre, precedent,
       ROUND(100.0 * (nombre - precedent) / NULLIF(precedent, 0), 2) AS evolution_pct
FROM evolution;

-- 5. Part de chaque joueur dans le total des points.
SELECT player_id, SUM(score) AS points,
       ROUND(100.0 * SUM(score) / SUM(SUM(score)) OVER (), 2) AS part_pct
FROM GameScore
GROUP BY player_id;

-- 6. Duree moyenne des 3 dernieres parties.
SELECT id, date_game, time_duration,
       AVG(time_duration) OVER (
           ORDER BY date_game, id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
       ) AS moyenne_3_parties
FROM GameReplay;

-- PALIER 3 : CTE et recursivite

-- 1. Joueurs dont le score total depasse la moyenne.
WITH scores_joueurs AS (
    SELECT player_id, SUM(score) AS total
    FROM GameScore
    GROUP BY player_id
),
moyenne AS (
    SELECT player_id, total, AVG(total) OVER () AS moyenne
    FROM scores_joueurs
)
SELECT player_id, total
FROM moyenne
WHERE total > moyenne;

-- 2. Mois dont la duree totale depasse la moyenne mensuelle.
WITH durees_mois AS (
    SELECT date_trunc('month', date_game) AS mois, SUM(time_duration) AS duree
    FROM GameReplay
    GROUP BY date_trunc('month', date_game)
),
moyenne AS (
    SELECT mois, duree, AVG(duree) OVER () AS moyenne
    FROM durees_mois
)
SELECT mois, duree
FROM moyenne
WHERE duree > moyenne;

-- 3. Arbre des equipes et sous-equipes.
WITH RECURSIVE equipes AS (
    SELECT id, name, parent_party_id, 1 AS niveau, name AS chemin
    FROM Party
    WHERE parent_party_id IS NULL
    UNION ALL
    SELECT p.id, p.name, p.parent_party_id, e.niveau + 1,
           e.chemin || ' > ' || p.name
    FROM Party p
    JOIN equipes e ON p.parent_party_id = e.id
)
SELECT name, niveau, chemin FROM equipes;

-- 4. Jours sans partie.
-- "jour" vient du calendrier genere ; date_game est la date de GameReplay.
SELECT jour::date AS jour
FROM generate_series(
    DATE '2026-07-01', DATE '2026-09-30', INTERVAL '1 day'
) AS calendrier(jour)
LEFT JOIN GameReplay g ON g.date_game::date = jour::date
WHERE g.id IS NULL;

-- PALIER 4 : rapports

-- 1. Nombre de parties par mois avec FILTER.
SELECT COUNT(*) FILTER (
           WHERE date_game >= DATE '2026-07-01'
             AND date_game < DATE '2026-08-01'
       ) AS juillet,
       COUNT(*) FILTER (
           WHERE date_game >= DATE '2026-08-01'
             AND date_game < DATE '2026-09-01'
       ) AS aout,
       COUNT(*) FILTER (WHERE date_game >= DATE '2026-09-01') AS septembre
FROM GameReplay;

-- 2. Nombre de parties par mois et total general.
SELECT COALESCE(to_char(date_trunc('month', date_game), 'YYYY-MM'),
                'Total general') AS mois,
       COUNT(*) AS parties
FROM GameReplay
GROUP BY ROLLUP (date_trunc('month', date_game));

-- 3. Comparer la duree moyenne et la duree mediane.

-- 4. Tableau de bord mensuel : parties et duree cumulee.

