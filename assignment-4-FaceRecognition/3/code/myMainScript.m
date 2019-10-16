%% MyMainScript
%% IMPORTANT REMARK
% The database for the code needs to be in the assignment main directory
% (where question folders are present). If the database is kept separately,
% please change the following lines appopriately to run the mainScript:
% Line 19, 50, 79
%% Constants
img_height = 112;
img_width = 92;
num_subjects = 32;
num_test_subjects = 8;
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

%% Optimal k
k = 30;     % in Q1 it was seen that recog rate is max at k=30
%% 

false_positive = 0;
false_negative = 0;
match = 0;
U_k = U_norm(:, 1:k);
coeff = U_k'*X_mean_pixel;
mean_coeff = zeros(k,num_subjects);
var_coeff = zeros(1,num_subjects);
for i=1:num_subjects
        mean_coeff(:,i) = sum(coeff(:,train_samples*(i-1)+1:train_samples*i),2)/train_samples;
        dummy = coeff(:,train_samples*(i-1)+1:train_samples*i) - mean_coeff(:,i);   % kx6 matrix
        var_coeff(i) = sum(sum(dummy.*dummy))/train_samples;
end
for i=(num_subjects+1):(num_test_subjects+num_subjects)
        for j =(train_samples+1):(test_samples+train_samples)
            input = im2double(imread(strcat('../../att_faces', '/s', num2str(i), '/',num2str(j), '.pgm')));
            Y = input(:);       %one column vector
            Y_mean_pixel = Y - X_mean;
            coeff_Y = U_k'*Y_mean_pixel;    %Coeff of input image
            match = 0;
            distance = sum((coeff_Y-mean_coeff).*(coeff_Y-mean_coeff));
            [min_dist,index]= min(distance);
            
                if min_dist < 2*var_coeff(index)
                    match=1;
                end
            false_positive = false_positive+match;
        end
end
identified = false_positive/(test_samples*num_test_subjects)*100;
disp(strcat('False Positive: ', num2str(identified)));
%% -
no_match = 0;
U_k = U_norm(:, 1:k);
coeff = U_k'*X_mean_pixel;
mean_coeff = zeros(k,num_subjects);
var_coeff = zeros(1,num_subjects);
for i=1:num_subjects
        mean_coeff(:,i) = sum(coeff(:,train_samples*(i-1)+1:train_samples*i),2)/train_samples;
        dummy = coeff(:,train_samples*(i-1)+1:train_samples*i) - mean_coeff(:,i);   % kx6 matrix
        var_coeff(i) = sum(sum(dummy.*dummy))/train_samples;
end
for i=1:num_subjects
        for j =(train_samples+1):(train_samples+test_samples)
            input = im2double(imread(strcat('../../att_faces', '/s', num2str(i), '/',num2str(j), '.pgm')));
            Y = input(:);       %one column vector
            Y_mean_pixel = Y - X_mean;
            coeff_Y = U_k'*Y_mean_pixel;    %Coeff of input image
            no_match = 0;
            distance = sum((coeff_Y-mean_coeff).*(coeff_Y-mean_coeff));
            [min_dist,index]= min(distance);
            
                if min_dist > 2*var_coeff(index)
                    no_match=1;
                end
            false_negative = false_negative+no_match;
        end
end
not_identified = false_negative/(num_subjects*test_samples)*100;
disp(strcat('False Negative: ', num2str(not_identified)));
