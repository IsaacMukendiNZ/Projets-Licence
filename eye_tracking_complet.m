% Script d'analyse des données d'eye-tracking
% Organise les données par condition émotionnelle et calcule moyennes/écarts-types

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

disp('Fichier chargé.');

% Définir les paramètres
images = {'AF01', 'AF02', 'AF03', 'AF23', 'AM04', 'AM17', 'AM20', 'AM32'};
% Ordre dans le fichier: ANS, HAS, NES, SAS pour chaque image
conditions_fichier = {'ANS', 'HAS', 'NES', 'SAS'};
conditions_final = {'NES', 'HAS', 'ANG', 'SAD'}; % Pour les résultats

% Ordre fixe des zones: R (entre yeux), Oeil droit, Oeil gauche, Bouche, Nez
zones = {'R', 'OeilDroit', 'OeilGauche', 'Bouche', 'Nez'};
n_images = length(images);
n_conditions = 4;
n_zones = 5;

% Initialiser les structures
fixation_data = zeros(n_images, n_conditions, n_zones);
duration_data = zeros(n_images, n_conditions, n_zones);

% Lignes des données
fix_count_header = 1;
fix_count_data = 2; % Rec 50
fix_duration_header = 5;
fix_duration_data = 6; % Rec 50

% Structure attendue des colonnes:
% Pour chaque image: ANS (5 zones), HAS (5 zones), NES (5 zones), SAS (5 zones)
% Soit 20 colonnes par image, total = 8 images × 20 colonnes = 160 colonnes

disp('Extraction selon ordre fixe: Image -> ANS/HAS/NES/SAS -> R/OeilDroit/OeilGauche/Bouche/Nez');

% Compteur de colonnes
col_idx = 2; % Commence à la colonne B (colonne 2)

for img_idx = 1:n_images
    fprintf('Traitement image %s...\n', images{img_idx});
    
    for cond_idx = 1:n_conditions
        cond = conditions_fichier{cond_idx};
        
        for zone_idx = 1:n_zones
            zone = zones{zone_idx};
            
            % Vérifier que la colonne existe
            if col_idx > size(raw, 2)
                warning('Fin du fichier atteinte à la colonne %d', col_idx);
                break;
            end
            
            % Lire le header pour vérification (optionnel mais utile pour debug)
            header_fix = '';
            if ~isempty(raw{fix_count_header, col_idx})
                header_fix = char(raw{fix_count_header, col_idx});
            end
            
            % Extraire Fixation Count
            val_fix = raw{fix_count_data, col_idx};
            if isnumeric(val_fix) && ~isnan(val_fix)
                fixation_data(img_idx, cond_idx, zone_idx) = val_fix;
            else
                fixation_data(img_idx, cond_idx, zone_idx) = 0;
            end
            
            % Extraire Duration (même colonne mais ligne différente)
            val_dur = raw{fix_duration_data, col_idx};
            if isnumeric(val_dur) && ~isnan(val_dur)
                duration_data(img_idx, cond_idx, zone_idx) = val_dur;
            else
                duration_data(img_idx, cond_idx, zone_idx) = 0;
            end
            
            % Debug: afficher quelques extractions
            if img_idx <= 2 && cond_idx <= 2 && zone_idx <= 2
                fprintf('  Col %d: %s-%s-%s: Fix=%g, Dur=%g\n', ...
                    col_idx, images{img_idx}, cond, zone, ...
                    fixation_data(img_idx, cond_idx, zone_idx), ...
                    duration_data(img_idx, cond_idx, zone_idx));
            end
            
            % Passer à la colonne suivante
            col_idx = col_idx + 1;
        end
    end
end

fprintf('\nTotal colonnes traitées: %d\n', col_idx - 2);

% Réorganiser pour avoir NES en premier (au lieu de ANS)
% ANS=1 -> ANG, HAS=2 -> HAS, NES=3 -> NES, SAS=4 -> SAD
% Ordre final: NES(3), HAS(2), ANG(1), SAD(4)
ordre_final = [3, 2, 1, 4]; % Indices pour réorganiser

fixation_reorg = fixation_data(:, ordre_final, :);
duration_reorg = duration_data(:, ordre_final, :);

% Calculer moyennes et écarts-types sur les 8 images
Condition = {};
Zone = {};
Moyenne_Fix = [];
EcartType_Fix = [];
Moyenne_Dur = [];
EcartType_Dur = [];
N_valeurs = [];

for c = 1:length(conditions_final)
    cond_name = conditions_final{c};
    
    for z = 1:n_zones
        zone_name = zones{z};
        
        % Extraire les valeurs des 8 images pour cette condition et zone
        vals_fix = fixation_reorg(:, c, z);
        vals_dur = duration_reorg(:, c, z);
        
        % Filtrer les zéros (données manquantes)
        vals_fix = vals_fix(vals_fix > 0);
        vals_dur = vals_dur(vals_dur > 0);
        
        Condition{end+1} = cond_name;
        Zone{end+1} = zone_name;
        
        if ~isempty(vals_fix)
            Moyenne_Fix(end+1) = mean(vals_fix);
            EcartType_Fix(end+1) = std(vals_fix);
        else
            Moyenne_Fix(end+1) = NaN;
            EcartType_Fix(end+1) = NaN;
        end
        
        if ~isempty(vals_dur)
            Moyenne_Dur(end+1) = mean(vals_dur);
            EcartType_Dur(end+1) = std(vals_dur);
        else
            Moyenne_Dur(end+1) = NaN;
            EcartType_Dur(end+1) = NaN;
        end
        
        N_valeurs(end+1) = length(vals_fix);
    end
end

% Créer les tableaux
T_fixation = table(Condition', Zone', Moyenne_Fix', EcartType_Fix', N_valeurs', ...
    'VariableNames', {'Condition', 'Zone', 'Moyenne', 'EcartType', 'N'});
T_duration = table(Condition', Zone', Moyenne_Dur', EcartType_Dur', N_valeurs', ...
    'VariableNames', {'Condition', 'Zone', 'Moyenne', 'EcartType', 'N'});

% Afficher
fprintf('\n');
disp('========================================');
disp('         FIXATION COUNT');
disp('========================================');
disp(T_fixation);
fprintf('\n');
disp('========================================');
disp('    FIXATION DURATION (secondes)');
disp('========================================');
disp(T_duration);

% Sauvegarder
[~, name, ~] = fileparts(filename);
output_file = fullfile(path, [name '_resultats_analyses.xlsx']);
writetable(T_fixation, output_file, 'Sheet', 'Fixation_Count');
writetable(T_duration, output_file, 'Sheet', 'Duration');

fprintf('\nRésultats sauvegardés dans: %s\n', output_file);

% Préparer les données
data_fix = reshape(Moyenne_Fix, n_zones, length(conditions_final))';
err_fix = reshape(EcartType_Fix, n_zones, length(conditions_final))';
data_dur = reshape(Moyenne_Dur, n_zones, length(conditions_final))';
err_dur = reshape(EcartType_Dur, n_zones, length(conditions_final))';

% Calculer positions pour barres d'erreur
ngroups = size(data_fix, 1);
nbars = size(data_fix, 2);
groupwidth = min(0.8, nbars/(nbars + 1.5));

% ========== FIGURE 1: Fixation Count par Condition ==========
fig1 = figure('Position', [100 100 800 600]);
bar(1:length(conditions_final), data_fix);
hold on;
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, data_fix(:,i), err_fix(:,i), 'k.', 'LineWidth', 1.5, 'MarkerSize', 0.1);
end
hold off;
set(gca, 'XTick', 1:length(conditions_final), 'XTickLabel', conditions_final, 'FontSize', 11);
legend(zones, 'Location', 'northeast', 'FontSize', 10);
title('Fixation Count par Condition Émotionnelle', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Nombre moyen de fixations', 'FontSize', 12);
xlabel('Condition émotionnelle', 'FontSize', 12);
grid on;
ylim([0 max(data_fix(:)) * 1.2]);
saveas(fig1, fullfile(path, [name '_FixationCount_Condition.png']));
saveas(fig1, fullfile(path, [name '_FixationCount_Condition.fig']));

% ========== FIGURE 2: Duration par Condition ==========
fig2 = figure('Position', [150 150 800 600]);
bar(1:length(conditions_final), data_dur);
hold on;
for i = 1:nbars
    x = (1:ngroups) - groupwidth/2 + (2*i-1) * groupwidth / (2*nbars);
    errorbar(x, data_dur(:,i), err_dur(:,i), 'k.', 'LineWidth', 1.5, 'MarkerSize', 0.1);
end
hold off;
set(gca, 'XTick', 1:length(conditions_final), 'XTickLabel', conditions_final, 'FontSize', 11);
legend(zones, 'Location', 'northeast', 'FontSize', 10);
title('Duration par Condition Émotionnelle', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Durée moyenne (secondes)', 'FontSize', 12);
xlabel('Condition émotionnelle', 'FontSize', 12);
grid on;
ylim([0 max(data_dur(:)) * 1.2]);
saveas(fig2, fullfile(path, [name '_Duration_Condition.png']));
saveas(fig2, fullfile(path, [name '_Duration_Condition.fig']));

% ========== FIGURE 3: Fixation Count par Zone ==========
fig3 = figure('Position', [200 200 800 600]);
bar(1:n_zones, data_fix');
set(gca, 'XTick', 1:n_zones, 'XTickLabel', zones, 'FontSize', 11);
legend(conditions_final, 'Location', 'northeast', 'FontSize', 10);
title('Fixation Count par Zone d''Intérêt', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Nombre moyen de fixations', 'FontSize', 12);
xlabel('Zone d''intérêt', 'FontSize', 12);
grid on;
ylim([0 max(data_fix(:)) * 1.1]);
saveas(fig3, fullfile(path, [name '_FixationCount_Zone.png']));
saveas(fig3, fullfile(path, [name '_FixationCount_Zone.fig']));

% ========== FIGURE 4: Duration par Zone ==========
fig4 = figure('Position', [250 250 800 600]);
bar(1:n_zones, data_dur');
set(gca, 'XTick', 1:n_zones, 'XTickLabel', zones, 'FontSize', 11);
legend(conditions_final, 'Location', 'northeast', 'FontSize', 10);
title('Duration par Zone d''Intérêt', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('Durée moyenne (secondes)', 'FontSize', 12);
xlabel('Zone d''intérêt', 'FontSize', 12);
grid on;
ylim([0 max(data_dur(:)) * 1.1]);
saveas(fig4, fullfile(path, [name '_Duration_Zone.png']));
saveas(fig4, fullfile(path, [name '_Duration_Zone.fig']));

fprintf('\nGraphiques sauvegardés.\n');
disp('========================================');
disp('Analyse terminée avec succès!');
disp('========================================');