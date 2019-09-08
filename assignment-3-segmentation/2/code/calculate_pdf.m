function pdf = calculate_pdf(image, h)

image = double(image);
[row, col, depth] = size(image);
pdf = zeros(row, col);
pre_factor = 1/(row*col*(h^depth));

%Calculating difference in spatial coordinates
index_vector = 1:(row*col);
rem_row = rem(index_vector-1, row) + 1;
y_index_array = reshape(rem_row, row, col);
index_vector = index_vector.';
rem_column = rem(index_vector-1, col) + 1;
x_index_array = reshape(rem_column, col, row).';
        
for row_iter = 1:row
    disp(row_iter)
    for col_iter = 1:col
        intensity_diff = image - image(row_iter, col_iter);
        x_diff = x_index_array - row_iter;
        y_diff = y_index_array - col_iter;
        sum_square = intensity_diff(:, :, 1).*intensity_diff(:, :, 1) + intensity_diff(:, :, 2).*intensity_diff(:, :, 2) + intensity_diff(:, :, 3).*intensity_diff(:, :, 3) + x_diff.*x_diff + y_diff.*y_diff;
        gaussian_kernel = exp(-(1/(h*h*2.0)).*sum_square);
        sum_kernel = sum(sum(gaussian_kernel));
        pdf(row_iter, col_iter) = pre_factor * sum_kernel;
    end
end

pdf = pdf./(sum(sum(pdf)));
end