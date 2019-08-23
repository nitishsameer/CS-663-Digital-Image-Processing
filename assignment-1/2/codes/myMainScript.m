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
imshow(statue);
figure
imshow(mask);
figure
imshow(maskedStatue);
toc;

%% Part b - Linear Contrast Stretching
tic;
output = myLinearContrastStretching(barbara);
figure
imshow(barbara);
figure
imshow(output);
toc;

tic;
output = myLinearContrastStretching(TEM);
figure
imshow(TEM);
figure
imshow(output);
toc;

tic;
output = myLinearContrastStretching(canyon);
figure
imshow(canyon);
figure
imshow(output);
toc;

tic;
output = myLinearContrastStretching(church);
figure
imshow(church);
figure
imshow(output);
toc;

tic;
output = myLinearContrastStretching(chestXray);
figure
imshow(chestXray);
figure
imshow(output);
toc;

tic;
output = myLinearContrastStretching(maskedStatue);
figure
imshow(maskedStatue);
figure
imshow(output);
toc;

%% Part c - Histogram Equalization
tic;
output = myHE(barbara);
figure
imshow(barbara);
figure
imshow(output);
toc;

tic;
output = myHE(TEM);
figure
imshow(TEM);
figure
imshow(output);
toc;

tic;
output = myHE(canyon);
figure
imshow(canyon);
figure
imshow(output);
toc;

tic;
output = myHE(church);
figure
imshow(church);
figure
imshow(output);
toc;

tic;
output = myHE(chestXray);
figure
imshow(chestXray);
figure
imshow(output);
toc;

tic;
output = myHE
imshow(maskedStatue);
figure
imshow(output);
toc;

%% Part d - Histogram Matching
tic;
output = myHM(retina, retinaMask, retinaRef, retinaRefMask);
op_HE = myHE(retina); %????????????????????
figure
imshow(retina);
figure
imshow(output);
figure
imshow(op_HE);
toc;

%% Part e - CLAHE
tic;
output = myCLAHE(barbara, window, thresh, 256);
figure
imshow(barbara);
figure
imshow(output);
output = myCLAHE(barbara, window, thresh, 256);  % large window size 
figure
imshow(output);
output = myCLAHE(barbara, window, thresh, 256);  % small window size 
figure
imshow(output);
output = myCLAHE(barbara, window, thresh, 256);  % half threshold
figure
imshow(output);
toc;

tic;
output = myCLAHE(TEM, window, thresh, 256);
figure
imshow(TEM);
figure
imshow(output);
output = myCLAHE(TEM, window, thresh, 256);  % large window size 
figure
imshow(output);
output = myCLAHE(TEM, window, thresh, 256);  % small window size 
figure
imshow(output);
output = myCLAHE(TEM, window, thresh, 256);  % half threshold
figure
imshow(output);
toc;

tic;
output = myCLAHE(canyon, window, thresh, 256);
figure
imshow(canyon);
figure
imshow(output);
output = myCLAHE(canyon, window, thresh, 256);  % large window size 
figure
imshow(output);
output = myCLAHE(canyon, window, thresh, 256);  % small window size 
figure
imshow(output);
output = myCLAHE(canyon, window, thresh, 256);  % half threshold
figure
imshow(output);
toc;

tic;
output = myCLAHE(chestXray, window, thresh, 256);
figure
imshow(chestXray);
figure
imshow(output);
output = myCLAHE(chestXray, window, thresh, 256);  % large window size 
figure
imshow(output);
output = myCLAHE(chestXray, window, thresh, 256);  % small window size 
figure
imshow(output);
output = myCLAHE(chestXray, window, thresh, 256);  % half threshold
figure
imshow(output);
toc;

%% end
