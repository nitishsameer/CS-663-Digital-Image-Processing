function output = myHE(input)

[row, col, channel] = size(input);
output = input;

%% Calculating the pdf of the image
intensity_levels = 256; %Assumed 8-bit image
pdf = zeros(intensity_levels, channel);
for d = 1:channel
    for i=1:row
        for j=1:col
            ind = ceil(input(i, j, d)+1); 
            pdf(ind, d) = pdf(ind, d) + 1;
        end
    end
end
pdf = pdf/(row*col);

%% Calculating cdf
cdf = cumsum(pdf);

%% Obtaining the Output Image
for d = 1:channel
    for i=1:row
        for j=1:col
            output(i, j, d) = double(255* cdf(ceil(input(i, j, d)+1), d));
        end
    end
end

end