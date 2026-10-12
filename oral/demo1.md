# Demo 1 - Les meilleurs scores d'une partie

## Question métier

Quels sont les trois meilleurs scores de chaque partie ?

## Requête

```sql
WITH classement AS (
    SELECT game_id, player_id, score,
           ROW_NUMBER() OVER (
               PARTITION BY game_id
               ORDER BY score DESC
           ) AS rang
    FROM GameScore
)
SELECT game_id, player_id, score
FROM classement
WHERE rang <= 3;
```

## Principe

La CTE `classement` ajoute un numéro à chaque score. Le classement recommence
pour chaque partie. La requête principale garde les trois premiers numéros.

## Résultat obtenu

Une liste avec le numéro de la partie, le joueur et son score. Il y a au maximum
trois joueurs affichés par partie. Les scores exacts dépendent des données de la
base.

## Difficulté rencontrée

Je n'avais pas encore étudié les fonctions de fenêtre et les CTE. J'ai dû
comprendre comment numéroter les scores par partie avant de pouvoir garder les
trois premiers.
