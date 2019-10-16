%% IMPORTANT REMARK
% The database for the code needs to be in the assignment main directory
% (where question folders are present). If the database is kept separately,
% please change the following lines appopriately to run the mainScript:
% Line 16, 18, 20, 48, 50
%% Constants
img_height = 192;
img_width = 168;
num_subjects = 38;
train_samples = 40;
test_samples = 24;

%% define X and take image inputs
X = zeros(img_height*img_width, num_subjects*train_samples);    %define dimension of X  %every column is data of one image
I = zeros(img_height, img_width);
person = dir([ '../../CroppedYale/yaleB*']);
for i = 1:num_subjects
    yaleFiles = dir(['../../CroppedYale/' person(i).name '/*.pgm']);    
    for j = 1:train_samples
        image = strcat(['../../CroppedYale/' person(i).name '/' yaleFiles(j).name]);
        I = im2double(imread(image));
        X(:, j+train_samples*(i-1)) = I(:);
    end
end

%% Calculate average and subtract
X_mean = sum(X,2)/(num_subjects*train_samples);     %N=1520 i.e. # of images
X_mean_pixel = X - X_mean;

%% Get eigenvectors (using SVD)
[U,S,V] = svd(X_mean_pixel,'econ');        %svd function returns values in descending order
U_sq = U.*U;
U_n = sqrt(sum(U_sq));
U_norm = U ./ sqrt(sum(U.*U));        %U or eigenvectors are normalized

%% Extracting k eigenvalues
k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 60, 65, 75, 100, 200, 300, 500, 1000];

rate = zeros(size(k));
rate_new = zeros(size(k));
for l = 1:length(k)
    U_k = U_norm(:,1:k(l));     %extracting first k eigenvectors
    eigen_coeff = (U_k)'*X_mean_pixel;      %dxN matrix with one column as coeffs of that image
    %% Recognition Rate
    input = zeros(img_height, img_width);
    Y = zeros(img_height*img_width, 1);
    for i = 1:num_subjects   
        yaleFiles = dir(['../../CroppedYale/' person(i).name '/*.pgm']); 
        for j = 41:size(yaleFiles,1)
            image = strcat(['../../CroppedYale/' person(i).name '/' yaleFiles(j).name]);
            input = im2double(imread(image));
            Y = input(:);       %one column vector
            Y_mean_pixel = Y - X_mean;
            eigen_coeff_test = (U_k)'*Y_mean_pixel;
            %define squared error
            error = eigen_coeff - eigen_coeff_test;
            error_sq = error.*error;
            error_sq_sum = sum(error.*error);       %every element will be sum of square of error of coeffs of one image
            [min_error, index] = min(error_sq_sum);
            error_sq_sum_new = sum(error_sq(4:k(l),:));    %excluding error for first 3 eigencoeffs
            [min_error_new, index_new] = min(error_sq_sum_new);
            if (i == ceil((index-0.5)/train_samples))
                rate(l) = rate(l) +1;
            end
            if (i == ceil((index_new-0.5)/train_samples))
                rate_new(l) = rate_new(l) +1;
            end
        end
    end    

end
rate = rate./(num_subjects*test_samples*0.01);
rate_new = rate_new./(num_subjects*test_samples*0.01);       %converting rate to percent

%% Graph of rate vs k
figure
plot(k,rate);
title('Recognition Rate vs k');
xlabel('k');
ylabel('Recognition Rate');
axis([0 1000 0 100]);

figure
plot(k,rate_new);
title('Recognition Rate vs k [excluding first 3 eigenvectors]');
xlabel('k');
ylabel('Recognition Rate');
axis([0 1000 0 100]);
