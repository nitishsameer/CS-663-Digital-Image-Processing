function output = myHEretina(input, mask)

[row, col, channel] = size(input);
output = input;

%% Calculating the pdf of the image
intensity_levels = 256; %Assumed 8-bit image
pdf = zeros(intensity_levels, channel);
for d = 1:channel
    for i=1:row
        for j=1:col
            if (mask(i,j))
                ind = ceil(input(i, j, d)+1); 
                pdf(ind, d) = pdf(ind, d) + 1;
            end
        end
    end
end
pdf = pdf/(sum(mask(:)));

%% Calculating cdf
cdf = cumsum(pdf);

%% Obtaining the Output Image
for d = 1:channel
    for i=1:row
        for j=1:col
            if (mask(i, j))
                output(i, j, d) = double(255* cdf(ceil(input(i, j, d)+1), d));
            else
                output(i, j, d) = input(i, j, d);
            end
        end
    end
end

end