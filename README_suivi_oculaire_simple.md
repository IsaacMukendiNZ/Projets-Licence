# Analyse eye‑tracking – Tableau récapitulatif simple

## Description
Ce script lit un fichier Excel contenant des données d’eye‑tracking organisées par image, condition émotionnelle et zone d’intérêt (R, OeilDroit, OeilGauche, Bouche, Nez). Il extrait les deux métriques : nombre de fixations et durée totale des fixations. Pour chaque combinaison condition × zone, il calcule la moyenne, l’écart‑type et le nombre de valeurs non nulles sur les 8 images. Il ajoute également une ligne “GLOBAL” par condition (toutes zones confondues). Le résultat est sauvegardé dans un nouveau fichier Excel.

## Prérequis
- MATLAB.
- Fichier Excel structuré comme décrit dans le script `suivi_oculaire_complet.m`.

## Utilisation
1. Lancer le script.
2. Sélectionner le fichier Excel via la boîte de dialogue.
3. Le script génère un tableau récapitulatif et le sauvegarde sous `nom_fichier_TABLEAU_COMPLET.xlsx`.

## Résultats attendus
Un tableau avec les colonnes : Condition, Zone, Moy_FixCount, Std_FixCount, N_Fix, Moy_Duration_s, Std_Duration_s, N_Dur.
