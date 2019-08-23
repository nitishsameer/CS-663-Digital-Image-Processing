function output = myHM(input, mask, ref, refmask)
output = input; %To maintain the datatype

[row_in, col_in, channel_in] = size(input);
[row_ref, col_ref, channel_ref] = size(ref);

%% Calculating PDF of input image
intensity_levels = 256; %Assumed 8-bit image
pdf_in = zeros(intensity_levels, channel_in);  %input image
for d = 1:channel_in
    for i=1:row_in
        for j=1:col_in
            ind = ceil(input(i, j, d)+1); 
            if (mask(i,j))
            pdf_in(ind, d) = pdf_in(ind, d) + 1;
            end
        end
    end
end
pdf_in = pdf_in/(sum(mask(:)));
%% Calculating PDF of reference image
pdf_ref = zeros(intensity_levels, channel_ref);
for d = 1:channel_ref
    for i=1:row_ref
        for j=1:col_ref
            index = ceil(ref(i, j, d)+1); 
            if (refmask(i,j))
            pdf_ref(index, d) = pdf_ref(index, d) + 1;
            end
        end
    end
end
pdf_ref = pdf_ref/(sum(refmask(:)));

%% Calculating cdf
cdf_in = cumsum(pdf_in);
cdf_ref = cumsum(pdf_ref);

%% Mapping of Histogram
cdf_in_corrected = cdf_in; %To match the dimension
new_intensity = zeros(intensity_levels, channel_in);
for d = 1:channel_in
    for iter = 1:intensity_levels
        [~, argmin] = min(abs(cdf_ref(:, d) - cdf_in(iter, d)));
        cdf_in_corrected(iter, d) = cdf_in(argmin, d); %Argmin is bin number. argmin - 1 is the intensity level
        new_intensity(iter, d) = argmin - 1;
    end
end
%% Output image
for r = 1: row_in
    disp(r)
    for c = 1:col_in
        for d = 1: channel_in
            if mask(r, c)
            output(r, c, d) = new_intensity(ceil(input(r, c, d)+1), d);
            else
            output(r ,c, d) = input (r, c, d);
            end
        end
    end
end
end

