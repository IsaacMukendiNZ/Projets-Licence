# Comparaison inter-régionale des taux de mortinatalité (ANOVA et régressions)

## Description
Ce script charge les fichiers de taux et d'effectifs pour toutes les régions de France métropolitaine (hors DOM). Il réalise :
- Une ANOVA pour tester les variations temporelles.
- Des régressions linéaires par région pour estimer les tendances.
- Des graphiques d'évolution nationale et de distribution annuelle.
- Des graphiques individuels des écarts à la moyenne régionale.

## Prérequis
- R avec les packages : `readxl`, `dplyr`, `ggplot2`, `tidyr`, `lubridate`
- Deux fichiers Excel (taux et effectifs) avec une structure similaire aux précédents.

## Utilisation
1. Lancez le script.
2. Sélectionnez le fichier des taux, puis celui des effectifs.
3. Les résultats numériques et graphiques s'affichent.

## Résultats attendus
- Tableau des moyennes régionales.
- Résultats ANOVA.
- Pentes des tendances par région avec p-values.
- Graphiques : tendance nationale, boxplots annuels, écarts régionaux.

## Remarques
- Les codes des DOM sont exclus (liste `codes_exclure`).
- La priorité des types (Totale > Induite > Spontanée) est gérée.
