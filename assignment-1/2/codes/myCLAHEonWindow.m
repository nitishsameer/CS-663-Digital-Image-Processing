function output = myCLAHEonWindow(input, pixel_intensity, thresh, nbins)

[row, col] = size(input);

%% Calculating PDF
pdf = zeros(1, nbins);
intensity_levels = 256; %Assumed 8-bit image
bin_size = intensity_levels/nbins;
for i=1:row
    for j=1:col
        ind = ceil(input(i, j)+1)/bin_size; 
        pdf(ind) = pdf(ind) + 1;
    end
end
pdf = pdf/(row*col);

%% Modifying PDF
extra_mass = sum(pdf((pdf - thresh) > 0) - thresh);
pdf(pdf>thresh) = thresh;
pdf = pdf + (extra_mass/nbins)*ones(size(pdf));

%% Calculating CDF
cdf = cumsum(pdf);

%% New Intensities
hist_corrected = cdf*(nbins-1); % nbins ya intensity_levels
hist_corrected = uint8(round(hist_corrected));

%% Find desired intensity of the pixel
pixel_bin = ceil(pixel_intensity+1)/bin_size;
output = hist_corrected(pixel_bin); % This gives bin number and not the intensity

end