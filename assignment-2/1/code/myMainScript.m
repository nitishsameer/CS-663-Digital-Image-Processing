clear all;
close all;
clc;
imagePath = {'../data/bird_reduced.bmp';'../data/flower.jpg'};
maskPath = {'../images/mask1_reduced.bmp';'../images/mask2.bmp'};
% Question 1_c_i
tic
mask1 = imread(char(maskPath(1))).*1;
im1 = im2double(imread(char(imagePath(1))));
im_fore1 = im1.*mask1;
im_back1 = im1.*((mask1.*-1) + 1);
mask2 = imread(char(maskPath(2))).*1;
im2 = im2double(imread(char(imagePath(2))));
im_fore2 = im2.*mask2;
im_back2 = im2.*((mask2.*-1) + 1);
figure(1)
montage({mask1,im_fore1,im_back1,mask2,im_fore2,im_back2});


% Question 1_c_ii
% this part takes roughly 5 mins to finish

[D1,A1] = mySpatiallyVaryingKernel(40,imread(char(maskPath(1))),imread(char(imagePath(1))));
[D2,A2] = mySpatiallyVaryingKernel(20,imread(char(maskPath(2))),imread(char(imagePath(2))));
figure(2)
subplot(2,1,1)
imcontour(D1)
subplot(2,1,2)
imcontour(D2)


% Question 1_c_iii
figure(3)
for i = 2:2:20
    im_kernel = fspecial('disk',0.1*i*20);
    im_kernel = im2uint8(im_kernel./im_kernel(round(end/2),round(end/2)));
    im_kernel = im2uint8(im_kernel);
    h(i/2) =subplot(5,2,i/2);
    imshow(im_kernel)
end
linkaxes([h(1),h(2),h(3),h(4),h(5),h(6),h(7),h(8),h(9),h(10)]);

% Question 1_c_iv
figure(4)
subplot(2,1,1)
imshow(A1)
subplot(2,1,2)
imshow(A2)

toc