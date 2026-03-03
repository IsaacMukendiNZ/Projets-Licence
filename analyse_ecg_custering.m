%% --- ANALYSE DE SIGNAL ECG ---
clc; clear all; close all;

% Chargement des données (nécessite ecg_data.mat)
load ecg_data;
N = length(ecg);
Pp = []; % Pics positifs
Np = []; % Pics négatifs

% Algorithme de détection de pics (Maximums locaux)
for i = 2:N-1
   if ecg(i-1) < ecg(i) && ecg(i+1) < ecg(i)
       Pp = [Pp i];
   elseif ecg(i) < ecg(i-1) && ecg(i) < ecg(i+1)
       Np = [Np i];
   end
end

% Affichage du signal et des pics détectés
t = 1:N;
figure; plot(t, ecg); hold on;
plot(t(Pp), ecg(Pp), 'r*'); plot(t(Np), ecg(Np), 'g*');
title('Détection des complexes ECG');

% Extraction de caractéristiques (Amplitude et Durée)
Amp = ecg(Pp);
Dur = diff(Np)'; 
% Note : on s'assure que Amp et Dur ont la même taille pour le K-means
min_len = min(length(Amp), length(Dur));
X_cluster = [Amp(1:min_len) Dur(1:min_len)];

% Clustering des cycles ECG
[idx, C] = kmeans(X_cluster, 3);
figure; gscatter(X_cluster(:,1), X_cluster(:,2), idx);
xlabel('Durée'); ylabel('Amplitude'); title('Clustering des cycles ECG');