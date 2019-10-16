%% IMPORTANT REMARK
% The database for the code needs to be in the assignment main directory
% (where question folders are present). If the database is kept separately,
% please change the following lines appopriately to run the mainScript:
% Line 17, 46
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

%% Get eigenvectors (using L matrix)
L = X_mean_pixel'*X_mean_pixel;
[W,D] = eig(L);
D_new = diag(sort(diag(D),'descend'));  %sorting in descending order
[~,ind] = sort(diag(D),'descend');
W_new = W(:,ind);
V = X_mean_pixel*W_new;        %get v from W of L matrix
V_norm = V ./ sqrt(sum(V.*V));        %V or eigenvectors are normalized

%% Extracting k eigenvalues
k = [1, 2, 3, 5, 10, 15, 20, 30, 50, 75, 100, 150, 170];
rate = zeros(size(k));
for l = 1:length(k)
    V_k = V_norm(:,1:k(l));     %extracting first k eigenvectors
    eigen_coeff = (V_k)'*X_mean_pixel;      %dxN matrix with one column as coeffs of that image
    %% Recognition Rate
    input = zeros(img_height, img_width);
    Y = zeros(img_height*img_width, 1);
    for i = 1:num_subjects
        for j = (train_samples+1):(train_samples+test_samples)
            input = im2double(imread(strcat('../../att_faces', '/s', num2str(i), '/',num2str(j), '.pgm')));
            Y = input(:);       %one column vector
            Y_mean_pixel = Y - X_mean;
            eigen_coeff_test = (V_k)'*Y_mean_pixel;
            %define squared error
            error = eigen_coeff - eigen_coeff_test;
            error_sq = error.*error;
            error_sq_sum = sum(error_sq);       %every element will be sum of square of error of coeffs of one image
            [min_error, index] = min(error_sq_sum);
            if (i == ceil((index-0.5)/train_samples))
                rate(l) = rate(l) +1;
            end
        end
    end    
end
rate = rate./(num_subjects*test_samples*0.01)        %converting rate to percent
%% Graph of rate vs k
figure
plot(k,rate);
title('Recognition Rate vs k');
xlabel('k');
ylabel('Recognition Rate');
axis([0 180 0 100]);
