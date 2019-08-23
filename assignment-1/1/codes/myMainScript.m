%% MyMainScript


%% Your code here
% Part
tic;
circles = imread('../data/circles_concentric.png');
output1 = myShrinkImageByFactorD(circles, 2);
output2 = myShrinkImageByFactorD(circles, 3);
figure
imshow(circles);
title("Original Image");
figure
imshow(output1);
title("Shrinked Image by factor of 2");
figure
imshow(output2);
title("Shrinked Image by factor of 3");
toc;

%% 