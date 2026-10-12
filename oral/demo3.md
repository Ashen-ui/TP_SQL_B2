# Demo 3 - Les equipes et leurs sous-equipes

## Question métier

Quelles équipes dépendent d'autres équipes ?

## Requête

```sql
WITH RECURSIVE equipes AS (
    SELECT id, name, parent_party_id, 1 AS niveau
    FROM Party
    WHERE parent_party_id IS NULL

    UNION ALL

    SELECT p.id, p.name, p.parent_party_id, e.niveau + 1
    FROM Party p
    JOIN equipes e ON p.parent_party_id = e.id
)
SELECT name, niveau
FROM equipes;
```

## Principe

La première partie trouve les équipes sans parent. La partie après `UNION ALL`
cherche leurs sous-équipes. Elle recommence pour chaque niveau. La CTE
`equipes` garde les résultats trouvés.

## Résultat obtenu

Une liste des équipes avec leur niveau : les équipes principales sont au niveau
1, leurs sous-équipes au niveau 2, et ainsi de suite.

## Difficulté rencontrée

La récursivité était nouvelle pour moi. Le point difficile était de comprendre
que la requête repart des équipes déjà trouvées pour chercher leurs enfants.

## Difficulté générale du TP

La principale difficulté a été de travailler avec des notions avancées que nous
n'avions pas encore beaucoup étudiées, notamment les CTE, les fonctions de
fenêtre et les requêtes récursives. J'ai dû les comprendre progressivement en
partant de petits exemples.
