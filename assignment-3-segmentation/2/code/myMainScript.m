%% Assignment 3
%By-
% Kumar Ashutosh 16D070043
% Nisha Brahmankar 16D070019
% Adarsh Kumar 160110071

tic;
%% Optimal Parameters
n_iterations = 20;
h_spatial = 20;
h_intensity = 15;
knn_neighbours = 500;

%% Input
input = imread('../data/flower.png');
scaled_input = input(1:2:end, 1:2:end, :);

%% Taking the Output with the above parameters and myMeanShiftSegmentation
output = myMeanShiftSegmentation(scaled_input, h_spatial, h_intensity, n_iterations);
output = uint8(output); %For analyzing the distict color values

%% Plotting the Output
figure
subplot(1, 2, 1)
imshow(input)
title('Input Image')

subplot(1, 2, 2)
imshow(output)
title('Output Segmented Image')

toc;
