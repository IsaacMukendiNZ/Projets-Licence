
---

### **3. Pour `Cnn_mnist.py` – `README_Cnn_mnist.md`**
```markdown
# Classification de chiffres manuscrits (MNIST) avec un CNN

## Description
Ce script utilise TensorFlow/Keras pour construire et entraîner un réseau de neurones convolutionnel (CNN) sur le jeu de données MNIST (chiffres de 0 à 9).  
Les étapes :
- Chargement des données MNIST
- Normalisation des pixels entre 0 et 1
- Définition d’un modèle CNN avec deux couches de convolution et des couches fully connected
- Compilation et entraînement
- Évaluation sur les données de test

## Prérequis
- Python 3 avec `tensorflow`, `numpy`, `matplotlib`
- Le dataset MNIST est téléchargé automatiquement par Keras

## Utilisation
Exécutez simplement :
```bash
python Cnn_mnist.py
