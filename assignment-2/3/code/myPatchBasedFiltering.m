function [output, isotrophic_gaussian_mask] = myPatchBasedFiltering(input, h)
%% Preprocessing
output = zeros(size(input));
[nrows, ncols, ndepths] = size(input);

%% Padding the input matrix
search_size = 25;
half_search_size = round((search_size-1)/2);
window_size = 9;
half_window_size = round((window_size-1)/2);

pad_size = half_search_size + half_window_size;
% Pad by search_size+window_size
padded_input = padarray(input,[pad_size pad_size],'replicate','both');

%% Tuned Parameters
isotrophic_std = 1.5;

%% Applying Patch Based Filtering
isotrophic_gaussian_mask = fspecial('gaussian', window_size, isotrophic_std);
isotrophic_gaussian_mask = isotrophic_gaussian_mask/(sum(isotrophic_gaussian_mask(:))); %Since the sum of elements should be 1

for depth_iter = 1:ndepths
    for row_iter = pad_size + 1:pad_size + nrows
        %disp(row_iter)
        for col_iter = pad_size + 1: pad_size + ncols
            % Setting window limits
            base_patch = padded_input(row_iter-half_window_size:row_iter+half_window_size, col_iter-half_window_size:col_iter+half_window_size, depth_iter);
            base_patch_isotrophic = base_patch .* isotrophic_gaussian_mask;
            % Patch extraction around p done
            % Now we need to find patch centres q within approimately 25*25
            % array
            weight_mask = zeros(search_size);
            mu = [13 13]; %For a 25*25 grid, center is at 13, 13
            sigma = [18 0;0 18]; %Tuned parameter sigma
            n_random_points = 400; %Tuned parameter
            random_gaussian_points = round(mvnrnd(mu, sigma, n_random_points));
            random_gaussian_points(random_gaussian_points > search_size) = search_size;
            random_gaussian_points(random_gaussian_points < 1) = 1;
            for n=1:n_random_points
                weight_mask(random_gaussian_points(n_random_points, :)) = 1;
            end
            weight_mask = ones(search_size); % Remove this later
            %Weight mask of 25*25 with some elements 1 ready.
            weights = zeros(search_size);
            search_patch = padded_input(row_iter-half_search_size:row_iter+half_search_size, col_iter-half_search_size:col_iter+half_search_size, depth_iter);
            %Add target patch 25*25 and multiply with the line 67
            for weight_x_iter=(row_iter-half_search_size):(row_iter+half_search_size)
                for weight_y_iter=(col_iter-half_search_size):(col_iter+half_search_size)
                    if weight_mask(weight_x_iter-row_iter+half_search_size+1, weight_y_iter-col_iter+half_search_size+1) == 1
                        target_patch = padded_input(weight_x_iter-half_window_size:weight_x_iter+half_window_size, weight_y_iter-half_window_size:weight_y_iter+half_window_size, depth_iter);
                        target_patch_isotrophic = target_patch.*isotrophic_gaussian_mask;
                        weights(weight_x_iter-row_iter+half_search_size+1, weight_y_iter-col_iter+half_search_size+1) = exp(-1*sum(sum((target_patch_isotrophic - base_patch_isotrophic).^2))/(2*h^2));
                    end
                end
            end
            weights = weights/sum(weights(:));
            %disp(size(weights))
            %disp(size(search_patch))
            output(row_iter-pad_size, col_iter-pad_size, depth_iter) = sum(sum(weights.*search_patch));
        end
    end
end
end