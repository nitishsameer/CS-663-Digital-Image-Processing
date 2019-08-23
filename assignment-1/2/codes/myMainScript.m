%% MyMainScript

%% Your code here
tic;
barbara = imread('../data/barbara.png');
TEM = imread('../data/TEM.png');
canyon = imread('../data/canyon.png');
retina = imread('../data/retina.png');
church = imread('../data/church.png');
chestXray = imread('../data/chestXray.png');
statue = imread('../data/statue.png');
retinaMask = imread('../data/retinaMask.png');
retinaRef = imread('../data/retinaRef.png');
retinaRefMask = imread('../data/retinaRefMask.png');
toc;

%% Part a - Binary masking
tic;
[mask, maskedStatue] = myForegroundMask(statue, 20);
figure
custom_imshow(statue);
title("Original Image");
figure
custom_imshow(mask);
title("Image Mask");
figure
custom_imshow(maskedStatue);
title("Masked Output Image");
toc;

%% Part b - Linear Contrast Stretching
tic;
output = myLinearContrastStretching(barbara);
figure
custom_imshow(barbara);
title("Original Image");
figure
custom_imshow(output);
title("Linear Contrast Stretched Image");
toc;

tic;
output = myLinearContrastStretching(TEM);
figure
custom_imshow(TEM);
title("Original Image");
figure
custom_imshow(output);
title("Linear Contrast Stretched Image");
toc;

tic;
output = myLinearContrastStretching(canyon);
figure
custom_imshow(canyon);
title("Original Image");
figure
custom_imshow(output);
title("Linear Contrast Stretched Image");
toc;

tic;
output = myLinearContrastStretching(church);
figure
custom_imshow(church);
title("Original Image");
figure
custom_imshow(output);
title("Linear Contrast Stretched Image");
toc;

tic;
output = myLinearContrastStretching(chestXray);
figure
custom_imshow(chestXray);
title("Original Image");
figure
custom_imshow(output);
title("Linear Contrast Stretched Image");
toc;

tic;
output = myLinearContrastStretching(maskedStatue);
figure
custom_imshow(maskedStatue);
title("Original Image");
figure
custom_imshow(output);
title("Linear Contrast Stretched Image");
toc;

%% Part c - Histogram Equalization
tic;
output = myHE(barbara);
figure
custom_imshow(barbara);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalized Image");
toc;

tic;
output = myHE(TEM);
figure
custom_imshow(TEM);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalized Image");
toc;

tic;
output = myHE(canyon);
figure
custom_imshow(canyon);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalized Image");
toc;

tic;
output = myHE(church);
figure
custom_imshow(church);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalized Image");
toc;

tic;
output = myHE(chestXray);
figure
custom_imshow(chestXray);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalized Image");
toc;

tic;
output = myHE(maskedStatue);
custom_imshow(output);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Equalized Image");
toc;

%% Part d - Histogram Matching
tic;
output = myHM(retina, retinaMask, retinaRef, retinaRefMask);
op_HE = myHE(retina); 
figure
custom_imshow(retina);
title("Original Image");
figure
custom_imshow(output);
title("Histogram Matched Image");
figure
custom_imshow(op_HE);
title("Histogram Equalized Image");
toc;

%% Part e - CLAHE
tic;
output = myCLAHE(barbara, 121, 0.01, 256);
figure
custom_imshow(barbara);
title("Original Image");
figure
custom_imshow(output);
title("CLAHE with window = 121 , threshold = 0.01 :BEST");
output = myCLAHE(barbara, 201, 0.01, 256);  % large window size 
title("CLAHE with large window = 201 ");
figure
imshow(output);
output = myCLAHE(barbara, 21, 0.01, 256);  % small window size 
figure
imshow(output);
title("CLAHE with small window = 21");
output = myCLAHE(barbara, 121, 0.005, 256);  % half threshold
figure
imshow(output);
title("CLAHE with half threshold of BEST");
toc;

tic;
output = myCLAHE(TEM, 101, 0.08, 256);
figure
imshow(TEM);
title("Original Image");
figure
imshow(output);
title("CLAHE with window =101 , threshold = 0.08 :BEST");
output = myCLAHE(TEM, 201,0.08, 256);  % large window size 
figure
imshow(output);
title("CLAHE with large window = 201");
output = myCLAHE(TEM, 21,0.08 256);  % small window size 
figure
imshow(output);
title("CLAHE with small window = 21");
output = myCLAHE(TEM, 101,0.04, 256);  % half threshold
figure
imshow(output);
title("CLAHE with half threshold of BEST");
toc;

tic;
output = myCLAHE(canyon, 91, 0.08, 256);
figure
imshow(canyon);
title("Original Image");
figure
imshow(output);
title("CLAHE with window = 91 , threshold = 0.08 :BEST");
output = myCLAHE(canyon, 201, 0.08, 256);  % large window size 
figure
imshow(output);
title("CLAHE with large window = 201");
output = myCLAHE(canyon, 21,0.08, 256);  % small window size 
figure
imshow(output);
title("CLAHE with small window = 21 ");
output = myCLAHE(canyon, 91,0.04, 256);  % half threshold
figure
imshow(output);
title("CLAHE with half threshold of BEST");
toc;

tic;
output = myCLAHE(chestXray, 111, 0.008, 256);
figure
imshow(chestXray);
title("Original Image");
figure
imshow(output);
title("CLAHE with window = 111, threshold = 0.08 :BEST");
output = myCLAHE(chestXray, 201, 0.08, 256);  % large window size 
figure
imshow(output);
title("CLAHE with large window = 201");
output = myCLAHE(chestXray, 21, 0.08, 256);  % small window size 
figure
imshow(output);
title("CLAHE with small window = 21 ");
output = myCLAHE(chestXray, 111, 0.04, 256);  % half threshold
figure
imshow(output);
title("CLAHE with half threshold of BEST");
toc;

%% end
