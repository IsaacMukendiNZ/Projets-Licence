# Analyse EEG : frequency tagging et potentiels évoqués (ERP)

## Description
Ce script charge un fichier MATLAB contenant une structure `EEG` (champs : `data`, `srate`, `event`). Il effectue deux analyses distinctes :

1. **Frequency tagging** : extraction d’époques de 20 secondes synchronisées sur les événements (stimulus), calcul de la FFT pour mettre en évidence les fréquences de stimulation (tagging fréquentiel).
2. **Potentiels évoqués (ERP)** : extraction d’époques de 2 secondes autour de chaque événement, puis moyenne pour obtenir la réponse évoquée.

Les résultats sont visualisés pour un canal choisi.

## Prérequis
- MATLAB (version récente).
- Fichier de données EEG au format `.mat` contenant la variable `EEG` (structure issue de EEGLAB ou similaire). Exemple : `S01.mat`.
- Les événements doivent être renseignés dans `EEG.event` avec un champ `latency` (en échantillons).

## Utilisation
1. Placer le fichier de données dans le même dossier que le script.
2. Adapter la variable `sub` (numéro du sujet) et les numéros de canal pour les graphiques.
3. Exécuter le script. La première partie calcule le frequency tagging, la seconde les ERP.

## Résultats attendus
- Pour le frequency tagging : un graphique de l’amplitude spectrale (entre 0.75 et 6 Hz) montrant les pics aux fréquences de stimulation.
- Pour les ERP : un tracé de la tension (µV) au cours du temps (2 secondes) pour le canal sélectionné.

## Remarques
- Le script suppose que les événements sont espacés régulièrement (tous les 10 essais pour le tagging). Vérifier la logique d’indexation.
- Une normalisation par soustraction de la moyenne locale est commentée dans le code ; elle peut être activée pour réduire le bruit de fond.
