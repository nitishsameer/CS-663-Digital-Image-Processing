%% MyMainScript


%% Your code here
% Part a - Shrink
tic;
circles = imread('../data/circles_concentric.png');
output = myShrinkImageByFactorD(circles, 2);
output2 = myShrinkImageByFactorD(circles, 3);
figure
imshow(circles);
title("Original Image");
figure
imshow(output);
title("Shrinked Image by factor of 2");
figure
custom_imshow(output2);
title("Shrinked Image by factor of 3");
toc;

%% Part 2 - Bilinear Interpolation
tic;
input = imread('../data/barbaraSmall.png');
output = myBilinearInterpolation(input);
figure
custom_imshow(input);
title("Original Image");
figure
custom_imshow(output);
title("Bilinear Interpolated Image");
toc;

%% Part 3 - Nearest Neighbor Interpolation
tic;
output = myNearestNeighborInterpolation(input);
figure
custom_imshow(input);
title("Original Image");
figure
custom_imshow(output);
title("NearestNeighbor Interpolated Image");
toc;

%% end