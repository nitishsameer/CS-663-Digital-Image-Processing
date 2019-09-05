%% MyMainScript
% For each image; the original image, noisy image and filtered image are
% displayed along with Spacial Gaussian Mask.  
%The rmsd is displayed on command window
%% Part a - barbara image
tic;
input = load('../data/barbara.mat');
barbara = input.imageOrig;

[output, corrupt] = myBilateralFiltering(barbara, 21, 1.3, 11);
figure
subplot(1,3,1);
custom_imshow(mat2gray(barbara));
title("Original");
subplot(1,3,2);
custom_imshow(mat2gray(corrupt));
title("Corrupted");
subplot(1,3,3);
custom_imshow(mat2gray(output));
title("Filtered");

% Gaussian mask
mask = fspecial('gaussian', [21,21], 1.3);
figure
custom_imshow(mat2gray(mask));
title("Spatial Gaussian Mask - Barbara");
toc;

%% Part b - grass image
tic;
grass = imread('../data/grass.png');
grass = double(grass);
[output, corrupt] = myBilateralFiltering(grass, 21, 0.9, 37);
figure
subplot(1,3,1);
custom_imshow(mat2gray(grass));
title("Original");
subplot(1,3,2);
custom_imshow(mat2gray(corrupt));
title("Corrupted");
subplot(1,3,3);
custom_imshow(mat2gray(output));
title("Filtered");

% Gaussian mask
mask = fspecial('gaussian', [21,21], 0.9);
figure
custom_imshow(mat2gray(mask));
title("Spatial Gaussian Mask- Grass");
toc;

%% Part b - grass image
tic;
honeycomb = imread('../data/honeyCombReal.png');
honeycomb = double(honeycomb);
[output, corrupt] = myBilateralFiltering(honeycomb, 21, 0.9, 40);
figure
subplot(1,3,1);
custom_imshow(mat2gray(honeycomb));
title("Original");
subplot(1,3,2);
custom_imshow(mat2gray(corrupt));
title("Corrupted");
subplot(1,3,3);
custom_imshow(mat2gray(output));
title("Filtered");

% Gaussian mask
mask = fspecial('gaussian', [21,21], 0.9);
figure
custom_imshow(mat2gray(mask));
title("Spatial Gaussian Mask- HoneyComb");
toc;

%% end