# Détection de complexes ECG et classification par k‑means

## Description
Ce script charge un signal ECG (contenu dans `ecg_data.mat`), détecte les pics positifs et négatifs (complexes QRS) par recherche de maximums et minimums locaux. Il extrait ensuite pour chaque cycle l’amplitude du pic et la durée entre pics négatifs consécutifs. Ces caractéristiques sont utilisées pour un clustering non supervisé (k‑means, 3 classes) afin de regrouper les cycles similaires.

## Prérequis
- MATLAB avec la Statistics and Machine Learning Toolbox (pour `kmeans`).
- Fichier `ecg_data.mat` contenant une variable `ecg` (vecteur ligne ou colonne).

## Utilisation
1. Placer `ecg_data.mat` dans le même dossier.
2. Exécuter le script.
3. Observer la détection des pics (graphique avec marqueurs) et le résultat du clustering (nuage de points amplitude vs durée).

## Résultats attendus
- Un premier graphique montre le signal ECG avec les pics positifs (rouge) et négatifs (vert).
- Un second graphique présente les cycles projetés dans l’espace amplitude–durée, colorés selon le cluster attribué.

## Remarques
- La détection par maximum local est simple et peut échouer en présence de bruit. Une amélioration consisterait à utiliser un seuil d’amplitude ou une transformée en ondelettes.
- Le nombre de clusters (3) est fixé arbitrairement ; on pourrait utiliser la méthode du coude pour le choisir.
