clear all;
close all;
clc;
im = imread('..//data/bird.jpg');
im1 = im(:,:,1); % manually chosen component based on picture
h = fspecial('log',80,0.4); % manual tune of window size and sigma
im2 = imfilter(im1,h);
L = superpixels(im2,500);
h1 = impoly(gca,[196,44; 266,435; 801,675; 676,264]); % rough estimate of bird
roiPoints = getPosition(h1);
roi = poly2mask(roiPoints(:,1),roiPoints(:,2),size(L,1),size(L,2));
BW = grabcut(im2,L,roi);
%reduce mask by factor of 2
BW = BW(1:2:end,1:2:end,:);
%manual tuning
BW(161:173,148:196)=0;
BW(222:246,176:220)=0;
BW(30:40,99:122)=0;
imshow(BW);