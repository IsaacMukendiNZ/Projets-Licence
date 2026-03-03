% Script d'analyse eye-tracking simplifié
% Construit tout dans un seul tableau récapitulatif

clear; clc;

% Demander le fichier Excel
[file, path] = uigetfile('*.xlsx;*.xls', 'Sélectionnez le fichier Excel');
if isequal(file, 0)
    disp('Aucun fichier sélectionné');
    return;
end

% Lire le fichier Excel
filename = fullfile(path, file);
[~, ~, raw] = xlsread(filename);

disp('Fichier chargé. Traitement en cours...');

% Définir les paramètres
images = {'AF01', 'AF02', 'AF03', 'AF23', 'AM04', 'AM17', 'AM20', 'AM32'};
conditions_fichier = {'ANS', 'HAS', 'NES', 'SAS'};
conditions_final = {'NES', 'HAS', 'ANG', 'SAD'};
zones = {'R', 'OeilDroit', 'OeilGauche', 'Bouche', 'Nez'};
n_images = length(images);
n_conditions = 4;
n_zones = 5;

% Initialiser les structures
fixation_data = zeros(n_images, n_conditions, n_zones);
duration_data = zeros(n_images, n_conditions, n_zones);

% Lignes des données
fix_count_header = 1;
fix_count_data = 2;
fix_duration_header = 5;
fix_duration_data = 6;

% Extraction des données (lecture séquentielle)
col_idx = 2;

for img_idx = 1:n_images
    for cond_idx = 1:n_conditions
        for zone_idx = 1:n_zones
            if col_idx > size(raw, 2)
                break;
            end
            
            % Extraire Fixation Count
            val_fix = raw{fix_count_data, col_idx};
            if isnumeric(val_fix) && ~isnan(val_fix)
                fixation_data(img_idx, cond_idx, zone_idx) = val_fix;
            end
            
            % Extraire Duration
            val_dur = raw{fix_duration_data, col_idx};
            if isnumeric(val_dur) && ~isnan(val_dur)
                duration_data(img_idx, cond_idx, zone_idx) = val_dur;
            end
            
            col_idx = col_idx + 1;
        end
    end
end

% Réorganiser dans l'ordre final (NES, HAS, ANG, SAD)
ordre_final = [3, 2, 1, 4];
fixation_reorg = fixation_data(:, ordre_final, :);
duration_reorg = duration_data(:, ordre_final, :);

% ============================================================
% CONSTRUCTION DU TABLEAU COMPLET
% ============================================================

% Initialiser les vecteurs pour le tableau
Condition_Tab = {};
Zone_Tab = {};
Moyenne_Fix_Tab = [];
EcartType_Fix_Tab = [];
N_Fix_Tab = [];
Moyenne_Dur_Tab = [];
EcartType_Dur_Tab = [];
N_Dur_Tab = [];

% Calculer pour chaque condition et zone
for c = 1:length(conditions_final)
    cond_name = conditions_final{c};
    
    for z = 1:n_zones
        zone_name = zones{z};
        
        % Extraire les valeurs des 8 images
        vals_fix = fixation_reorg(:, c, z);
        vals_dur = duration_reorg(:, c, z);
        
        % Filtrer les zéros
        vals_fix_clean = vals_fix(vals_fix > 0);
        vals_dur_clean = vals_dur(vals_dur > 0);
        
        % Ajouter au tableau
        Condition_Tab{end+1} = cond_name;
        Zone_Tab{end+1} = zone_name;
        
        if ~isempty(vals_fix_clean)
            Moyenne_Fix_Tab(end+1) = mean(vals_fix_clean);
            EcartType_Fix_Tab(end+1) = std(vals_fix_clean);
            N_Fix_Tab(end+1) = length(vals_fix_clean);
        else
            Moyenne_Fix_Tab(end+1) = NaN;
            EcartType_Fix_Tab(end+1) = NaN;
            N_Fix_Tab(end+1) = 0;
        end
        
        if ~isempty(vals_dur_clean)
            Moyenne_Dur_Tab(end+1) = mean(vals_dur_clean);
            EcartType_Dur_Tab(end+1) = std(vals_dur_clean);
            N_Dur_Tab(end+1) = length(vals_dur_clean);
        else
            Moyenne_Dur_Tab(end+1) = NaN;
            EcartType_Dur_Tab(end+1) = NaN;
            N_Dur_Tab(end+1) = 0;
        end
    end
end

% Ajouter les moyennes GLOBALES par condition (ligne de séparation)
for c = 1:length(conditions_final)
    cond_name = conditions_final{c};
    
    % Extraire toutes les valeurs pour cette condition
    all_fix = fixation_reorg(:, c, :);
    all_dur = duration_reorg(:, c, :);
    
    all_fix_clean = all_fix(all_fix > 0);
    all_dur_clean = all_dur(all_dur > 0);
    
    % Ajouter ligne de moyenne globale
    Condition_Tab{end+1} = [cond_name ' (GLOBAL)'];
    Zone_Tab{end+1} = 'TOUTES';
    Moyenne_Fix_Tab(end+1) = mean(all_fix_clean);
    EcartType_Fix_Tab(end+1) = std(all_fix_clean);
    N_Fix_Tab(end+1) = length(all_fix_clean);
    Moyenne_Dur_Tab(end+1) = mean(all_dur_clean);
    EcartType_Dur_Tab(end+1) = std(all_dur_clean);
    N_Dur_Tab(end+1) = length(all_dur_clean);
end

% Créer le tableau final complet
T_COMPLET = table(Condition_Tab', Zone_Tab', ...
    Moyenne_Fix_Tab', EcartType_Fix_Tab', N_Fix_Tab', ...
    Moyenne_Dur_Tab', EcartType_Dur_Tab', N_Dur_Tab', ...
    'VariableNames', {'Condition', 'Zone', ...
    'Moy_FixCount', 'Std_FixCount', 'N_Fix', ...
    'Moy_Duration_s', 'Std_Duration_s', 'N_Dur'});

% Afficher le tableau complet
fprintf('\n');
disp('===========================================================================');
disp('                    TABLEAU RÉCAPITULATIF COMPLET');
disp('===========================================================================');
disp(T_COMPLET);

% Sauvegarder
[~, name, ~] = fileparts(filename);
output_file = fullfile(path, [name '_TABLEAU_COMPLET.xlsx']);
writetable(T_COMPLET, output_file, 'Sheet', 'Resultats_Complets');

fprintf('\n');
fprintf('Tableau sauvegardé dans: %s\n', output_file);
disp('===========================================================================');
disp('Analyse terminée avec succès!');
disp('===========================================================================');