clc
close all
clear all

Im = imread('coins1.JPG');
figure('Name', 'Image Originale');
imshow(Im);

R = Im(:,:,1);
G = Im(:,:,2);
B = Im(:,:,3);


seuil_rouge = 100;
masque_rouge = (R > seuil_rouge) & (G < 100) & (B < 100);


Im_rouge = Im;
Im_rouge(:,:,1) = Im(:,:,1) .* uint8(masque_rouge);
Im_rouge(:,:,2) = Im(:,:,2) .* uint8(masque_rouge);
Im_rouge(:,:,3) = Im(:,:,3) .* uint8(masque_rouge);

figure('Name', 'Pièces Rouges');
subplot(1,2,1);
imshow(masque_rouge);
title('Masque Rouge');
subplot(1,2,2);
imshow(Im_rouge);
title('Pièces Rouges Segmentées');


seuil_vert = 100;
masque_vert = (G > seuil_vert) & (R < 100) & (B < 100);

Im_vert = Im;
Im_vert(:,:,1) = Im(:,:,1) .* uint8(masque_vert);
Im_vert(:,:,2) = Im(:,:,2) .* uint8(masque_vert);
Im_vert(:,:,3) = Im(:,:,3) .* uint8(masque_vert);

figure('Name', 'Pièces Vertes');
subplot(1,2,1);
imshow(masque_vert);
title('Masque Vert');
subplot(1,2,2);
imshow(Im_vert);
title('Pièces Vertes Segmentées');

seuil_bleu = 100;
masque_bleu = (B > seuil_bleu) & (R < 100) & (G < 100);

Im_bleu = Im;
Im_bleu(:,:,1) = Im(:,:,1) .* uint8(masque_bleu);
Im_bleu(:,:,2) = Im(:,:,2) .* uint8(masque_bleu);
Im_bleu(:,:,3) = Im(:,:,3) .* uint8(masque_bleu);

figure('Name', 'Pièces Bleues');
subplot(1,2,1);
imshow(masque_bleu);
title('Masque Bleu');
subplot(1,2,2);
imshow(Im_bleu);
title('Pièces Bleues Segmentées');

figure('Name', 'Comparaison Toutes Couleurs');
subplot(2,2,1);
imshow(Im);
title('Image Originale');
subplot(2,2,2);
imshow(Im_rouge);
title('Pièces Rouges');
subplot(2,2,3);
imshow(Im_vert);
title('Pièces Vertes');
subplot(2,2,4);
imshow(Im_bleu);
title('Pièces Bleues');