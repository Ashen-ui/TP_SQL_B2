# Demo 3 - Le classement des scores

## Question métier

Quel est le classement des joueurs dans chaque partie ?

## Requête

```sql
SELECT game_id, player_id, score,
       RANK() OVER (PARTITION BY game_id ORDER BY score DESC) AS rang
FROM GameScore;
```

## Principe

La requête trie les scores du plus grand au plus petit. `PARTITION BY game_id`
recommence le classement pour chaque partie. `RANK()` donne un rang à chaque
score. Si deux joueurs ont le même score, ils ont le même rang.

## Résultat obtenu

La requête affiche le numéro de la partie, le joueur, son score et son rang.
Les premiers rangs correspondent aux meilleurs scores de chaque partie.

## Difficulté rencontrée

La fonction `RANK()` et `PARTITION BY` étaient nouvelles. Il fallait comprendre
que le classement repart de 1 à chaque nouvelle partie.
