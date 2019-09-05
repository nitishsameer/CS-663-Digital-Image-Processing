clear all;
close all;
clc;
im = imread('..//data/flower.jpg');
im1 = im(:,:,3); % manually chosen component based on picture
im2 = im1 >170; % manually chosen threshold
im2 = im2uint8(im2);
L = superpixels(im2,500);
h1 = impoly(gca,[131,60; 139,212; 297,217; 298,47]); % rough estimate of flower petals
roiPoints = getPosition(h1);
roi = poly2mask(roiPoints(:,1),roiPoints(:,2),size(L,1),size(L,2));
BW = grabcut(im2,L,roi);
imshow(BW)
