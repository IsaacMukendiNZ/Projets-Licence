# Analyse statistique de l'impact des vagues de chaleur sur la mortalité périnatale

## Description
Ce script reprend la base quotidienne générée précédemment et réalise :
- Un récapitulatif des vagues de chaleur (dates, durée, intensité).
- Une modélisation GLM (quasi-Poisson) pour estimer l'effet des vagues de chaleur et de la température sur la mortinatalité et la prématurité.
- Des graphiques d'évolution annuelle et un forest plot des risques (IRR).

## Prérequis
- R avec les packages : `readxl`, `writexl`, `ggplot2`, `gridExtra`, `dplyr`
- Le fichier `Base_HDF_Journaliere.xlsx` généré par le script précédent (ou un fichier similaire).

## Utilisation
1. Assurez-vous que `Base_HDF_Journaliere.xlsx` est dans le dossier de travail.
2. Exécutez le script.
3. Les résultats statistiques s'affichent dans la console, et les graphiques sont produits.

## Résultats attendus
- Tableau des vagues de chaleur.
- Coefficients IRR avec intervalles de confiance et p-values.
- Graphiques annuels et forest plot.

## Remarques
- Le modèle utilise une correction de surdispersion (quasi-Poisson).
- Interprétation : un IRR > 1 indique une augmentation du risque pendant les vagues de chaleur.
