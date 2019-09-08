function final_output = myMeanShiftSegmentation(input, h_spatial, h_intensity, n_iterations)
input = double(input);

%Flower data is 128*128
[row, col, depth] = size(input);
output = zeros(row, col, depth);

for mean_shift_iterator = 1:n_iterations
    % Unraveling the input
    red_intensity = input(:, :, 1);
    green_intensity = input(:, :, 2);
    blue_intensity = input(:, :, 3);

    red_intensity = red_intensity(:);
    green_intensity = green_intensity(:);
    blue_intensity = blue_intensity(:);

    index = 1:(row*col);
    x_list = ceil(index/row)';
    y_list = rem(index-1, row)' + 1;

    data_matrix = [red_intensity green_intensity blue_intensity x_list y_list];

    %Since image is 128*128, k of 500 is good
    k = 500;
    knn_matches = knnsearch(data_matrix, data_matrix, 'k', k);

    for data_iter = 1:(row*col)
        weights = zeros(1, k);
        intensities = zeros(k, depth);
        base_data = data_matrix(data_iter, :);
        for neighbour_iter = 1:k
            neighbour_data = data_matrix(knn_matches(data_iter, neighbour_iter), :);
            intensities(neighbour_iter, :) = neighbour_data(1:3);
            difference = base_data - neighbour_data;
            sum_square_intensity = sum(sum(difference(1:3).*difference(1:3)));
            sum_square_spatial = sum(sum(difference(4:5).*difference(4:5)));
            weights(neighbour_iter) = exp(-sum_square_intensity/(2*h_intensity*h_intensity) -sum_square_spatial/(2*h_spatial*h_spatial));
        end
        output(rem(data_iter-1, row)+1, ceil(data_iter/row), :) = (weights*intensities)/sum(sum(weights));
    end
    input = output; %For next loop
    %toc
end
final_output = output;
end