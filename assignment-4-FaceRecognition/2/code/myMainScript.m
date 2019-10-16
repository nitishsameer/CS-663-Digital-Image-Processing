%% MyMainScript
%% IMPORTANT REMARK
% The database for the code needs to be in the assignment main directory
% (where question folders are present). If the database is kept separately,
% please change the following lines appopriately to run the mainScript:
% Line 18, 33
%% Constants
img_height = 112;
img_width = 92;
num_subjects = 32;
train_samples = 6;
test_samples = 4;
%% define X and take image inputs
X = zeros(img_height*img_width, num_subjects*train_samples);    %define dimension of X  %every column is data of one image
I = zeros(img_height, img_width);
for i = 1:num_subjects
    for j = 1:train_samples
        I = im2double(imread(strcat('../../att_faces', '/s', num2str(i), '/',num2str(j),'.pgm')));
        X(:, j+train_samples*(i-1)) = I(:);
    end
end
    
%% Calculate average and subtract
X_mean = sum(X,2)/(num_subjects*train_samples);     %N=192 i.e. # of images
X_mean_pixel = X - X_mean;

%% Get eigenvectors (using SVD)
[U,S,V] = svd(X_mean_pixel);        %svd function returns values in descending order
U_norm = U ./ sqrt(sum(U.*U));        %U or eigenvectors are normalized


%% input image for reconstruction
input = im2double(imread(strcat('../../att_faces', '/s', num2str(8), '/',num2str(2),'.pgm')));  %2nd image of 8th person
image = input(:);

image_mean_pixel = image - X_mean;

%% Extracting k eigenvalues 
k = [2, 10, 20, 50, 75, 100, 125, 150, 175];

for l = 1:length(k)
    U_k = U_norm(:,1:k(l));     %extracting first k eigenvectors
    eigen_coeff = (U_k)'*image_mean_pixel;
    reconstr_image = X_mean + U_k*eigen_coeff;     %reconstructing image
    subplot(3,3,l)
    imshow((reshape(reconstr_image,[112 92])));
    title(num2str(k(l)));
end    

figure
for i = 1:25
    subplot(5,5,i);
    imshow(mat2gray(reshape(U_k(:,i),[112 92])));
    title(num2str(i));
end
    