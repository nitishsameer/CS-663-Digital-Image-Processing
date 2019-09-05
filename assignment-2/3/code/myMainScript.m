%% MyMainScript - Report Question 3

tic;

%% Barbara
disp('Starting Barbara')
load('../data/barbara.mat');
noise_output = add_noise(imageOrig);
%Gaussian Blurring and Decimation
filtered_input = imgaussfilt(noise_output, 1); %Chosen sigma = 1
decimated_input = filtered_input(1:2:end, 1:2:end, :);

image_decimated = imageOrig(1:2:end, 1:2:end, :);
h_best = 0.15;
[output, iso_mask] = myPatchBasedFiltering(decimated_input, h_best);
rmsd = calculate_rmsd(output, image_decimated);

disp(strcat('Optimal RMSD value of ', num2str(rmsd), ' is obtained at sigma = ', num2str(h_best)))

%Sub optimal RMSD
[output, ~] = myPatchBasedFiltering(decimated_input, 0.9*h_best);
rmsd = calculate_rmsd(output, image_decimated);
disp(strcat('RMSD value at 0.9*sigma is ', num2str(rmsd)))

[output, ~] = myPatchBasedFiltering(decimated_input, 1.1*h_best);
rmsd = calculate_rmsd(output, image_decimated);
disp(strcat('RMSD value at 0.9*sigma is ', num2str(rmsd)))

figure
subplot(1, 3, 1)
custom_imshow(image_decimated)
subplot(1, 3, 2)
custom_imshow(noise_output)
subplot(1, 3, 3)
custom_imshow(output)

figure
custom_imshow(iso_mask)

%% Grass.png
disp('Starting Grass')
input = imread('../data/grass.png');
input = double(input);
noise_output = add_noise(input);
h_best = 1.86;
[output, iso_mask] = myPatchBasedFiltering(noise_output, h_best);
rmsd = calculate_rmsd(output, input);

disp(strcat('Optimal RMSD value of ', num2str(rmsd), ' is obtained at sigma = ', num2str(h_best)))

%Sub optimal RMSD
[output, ~] = myPatchBasedFiltering(noise_output, 0.9*h_best);
rmsd = calculate_rmsd(output, input);
disp(strcat('RMSD value at 0.9*sigma is ', num2str(rmsd)))

[output, ~] = myPatchBasedFiltering(noise_output, 1.1*h_best);
rmsd = calculate_rmsd(output, input);
disp(strcat('RMSD value at 0.9*sigma is ', num2str(rmsd)))

figure
subplot(1, 3, 1)
custom_imshow(input)
subplot(1, 3, 2)
custom_imshow(noise_output)
subplot(1, 3, 3)
custom_imshow(output)

figure
custom_imshow(iso_mask)

%% HoneyComb
input = imread('../data/honeyCombReal.png');
input = double(input);
noise_output = add_noise(input);
h_best = 2.1;
[output, iso_mask] = myPatchBasedFiltering(noise_output, h_best);
rmsd = calculate_rmsd(output, input);

disp(strcat('Optimal RMSD value of ', num2str(rmsd), ' is obtained at sigma = ', num2str(h_best)))

%Sub optimal RMSD
[output, ~] = myPatchBasedFiltering(noise_output, 0.9*h_best);
rmsd = calculate_rmsd(output, input);
disp(strcat('RMSD value at 0.9*sigma is ', num2str(rmsd)))

[output, ~] = myPatchBasedFiltering(noise_output, 1.1*h_best);
rmsd = calculate_rmsd(output, input);
disp(strcat('RMSD value at 0.9*sigma is ', num2str(rmsd)))

figure
subplot(1, 3, 1)
custom_imshow(input)
subplot(1, 3, 2)
custom_imshow(noise_output)
subplot(1, 3, 3)
custom_imshow(output)

figure
custom_imshow(iso_mask)


toc;
