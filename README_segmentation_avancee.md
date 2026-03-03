# Segmentation d’image par couleur avec opérations morphologiques avancées

## Description
Ce script segmente l’image `coins1.JPG` (pièces de monnaie) en fonction de plusieurs plages de couleurs (bleu, jaune/vert, rouge clair, rouge foncé). Pour chaque plage, il affiche l’histogramme du canal concerné, crée un masque par seuillage, puis applique une érosion et une dilatation (ouverture) pour nettoyer le masque. Le résultat est l’image où seuls les pixels de la couleur sélectionnée apparaissent.

## Prérequis
- MATLAB avec Image Processing Toolbox.
- Image `coins1.JPG` dans le dossier.

## Utilisation
1. Placer l’image dans le dossier.
2. Exécuter le script.
3. Observer les histogrammes, les masques bruts, les masques nettoyés et les images segmentées pour chaque plage de couleur.

## Résultats attendus
Une série de figures pour chaque plage de couleur, montrant l’histogramme, le masque brut et le résultat final après morphologie.

## Remarques
- Les seuils sont choisis visuellement à partir des histogrammes ; ils peuvent être ajustés.
- L’élément structurant (disque) permet de supprimer les petits artefacts.
