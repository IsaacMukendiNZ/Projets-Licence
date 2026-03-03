# Analyse eye‑tracking complète avec statistiques et graphiques

## Description
Ce script lit un fichier Excel contenant des données d’eye‑tracking organisées par image, condition émotionnelle et zone d’intérêt (R, OeilDroit, OeilGauche, Bouche, Nez). Il extrait les deux métriques : nombre de fixations et durée totale des fixations. Pour chaque combinaison condition × zone, il calcule la moyenne, l’écart‑type et le nombre de valeurs non nulles sur les 8 images. Ensuite, il génère quatre graphiques :
- Fixation count par condition (avec barres par zone)
- Durée de fixation par condition
- Fixation count par zone (avec barres par condition)
- Durée de fixation par zone

Les résultats numériques sont sauvegardés dans un fichier Excel multicouche.

## Prérequis
- MATLAB.
- Fichier Excel structuré comme suit :
  - Ligne 1 : en‑têtes pour “Fixation Count”.
  - Ligne 2 : données de comptage.
  - Ligne 5 : en‑têtes pour “Duration”.
  - Ligne 6 : données de durée.
  - Colonnes : pour chaque image, les 4 conditions dans l’ordre (ANS, HAS, NES, SAS), chacune avec 5 zones dans l’ordre (R, OeilDroit, OeilGauche, Bouche, Nez).

## Utilisation
1. Lancer le script.
2. Sélectionner le fichier Excel via la boîte de dialogue.
3. Les graphiques apparaissent et sont sauvegardés au format PNG et FIG.
4. Les tableaux de résultats sont exportés dans `nom_fichier_resultats_analyses.xlsx`.

## Résultats attendus
Quatre graphiques clairs illustrant les patterns de fixation selon l’émotion et la zone explorée, ainsi qu’un tableau récapitulatif.
