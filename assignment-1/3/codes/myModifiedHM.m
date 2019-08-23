function output = myModifiedHM(input)
output = input; %To maintain the datatype

[row_in, col_in, channel_in] = size(input);

%% Calculating PDF of input image
intensity_levels = 256; %Assumed 8-bit image
pdf_in = zeros(intensity_levels, channel_in);  %input image
for d = 1:channel_in
    for i=1:row_in
        for j=1:col_in
            ind = ceil(input(i, j, d)+1); 
            pdf_in(ind, d) = pdf_in(ind, d) + 1;
        end
    end
end
pdf_in = pdf_in/(row_in*col_in);

%% Calculating cdf
cdf_in = cumsum(pdf_in);

%% Finding a
[~, arg] = min(abs(cdf_in - 0.5)); %arg is the required position
a = arg-1;

%% Mapping of Histogram
new_intensity = zeros(intensity_levels, channel_in);
for d = 1:channel_in
    for iter = 1:arg
        new_intensity(iter, d) = 2*a*cdf_in(iter);
    end
    for iter = arg+1:intensity_levels
        new_intensity(iter, d) = a + (cdf_in(iter)-0.5)*2*(255-a);
    end
end
%% Output image
for r = 1: row_in
    disp(r)
    for c = 1:col_in
        for d = 1: channel_in
            output(r, c, d) = new_intensity(ceil(input(r, c, d)+1), d);
        end
    end
end
end