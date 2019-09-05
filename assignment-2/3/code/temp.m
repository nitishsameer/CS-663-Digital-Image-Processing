

h_range = [2.07, 2.3, 2.53];
[~, h_len] = size(h_range);
rmsd_2 = zeros(1, h_len);
input = imread('../data/honeyCombReal.png');
input = double(input);
noise_output = add_noise(input);
[row, col] = size(input);
output_2 = zeros(row, col, h_len);
for h = 1:h_len
    disp(h)
    [out, iso_mask] = myPatchBasedFiltering(noise_output, h_range(h));
    output_2(:, :, h) = out;
    rmsd_2(h) = calculate_rmsd(out, input);
end