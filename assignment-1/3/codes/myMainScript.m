%% MyMainScript

clear all
tic;
%% Your code here
input = imread('../data/statue.png');
output = myHE(input);
modified_out = myModifiedHM(input);
figure
custom_imshow(input);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalization Output");
figure
custom_imshow(modified_out);
title("Modified HE Output");
toc;
