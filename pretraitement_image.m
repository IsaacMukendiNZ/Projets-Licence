clc
close all
clear all
%% CARACTER REGOGNITION EXAMPLE (II):Automating Image Pre-processing
%%Read image
I=imread('ETR.jpg');
imshow(I)
%%gray 
Igray=rgb2gray(I);
imshow(Igray)
%%convert to grayscale image
Ibw=im2bw(Igray,0.85);
imshow(Ibw)
%%edge detection 
Iedge = edge(uint8(Ibw));
imshow(Iedge)

se=strel('square',2);
Iedge2 = imdilate(Iedge, se);
imshow(Iedge2);

Ifill=imfill(Iedge2,'holes');
imshow(Ifill)
%%Blobs analysis
[Ilabel num] = bwlabel(Ifill);
disp(num);
Iprops=regionprops(Ilabel);
Ibox=[Iprops.BoundingBox];
Ibox=reshape(Ibox,[4,3])
imshow(I)

hold on;
for cnt = 1:3
    rectangle('Position', Ibox(:, cnt), 'edgeColor');
end
