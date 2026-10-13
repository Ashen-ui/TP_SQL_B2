# Demo 2 - Les joueurs avec le plus de points

## Question métier

Quels joueurs ont le plus grand total de points ?

## Requête

```sql
WITH points_joueurs AS (
    SELECT player_id, SUM(score) AS total_points
    FROM GameScore
    GROUP BY player_id
)
SELECT player_id, total_points
FROM points_joueurs
ORDER BY total_points DESC
LIMIT 3;
```

## Principe

La CTE additionne les scores de chaque joueur. La requête principale trie les
totaux du plus grand au plus petit et garde les trois premiers.

## Résultat obtenu

Trois lignes au maximum : un identifiant de joueur et son total de points. Les
joueurs affichés dépendent des scores présents dans la base.

## Difficulté rencontrée

Je devais distinguer le score d'une partie du total d'un joueur. `GROUP BY`
rassemble les scores d'un même joueur, puis `SUM` les additionne.
