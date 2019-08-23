function output = myLinearContrastStretching(input)
%%
[row, col, channel] = size(input);

output = input;
intensity_levels = 256; %Assumed 8-bit image

for d=1:channel
    %% Redefining intensity by linear map
    i_max = max(max(input(:, :, d)));
    i_min = min(min(input(:, :, d)));
    diff = i_max - i_min;
    % line between (0, i_min) and (255, i_max)
    for i = 1: row
        for j = 1: col
            I = input(i, j, d);
            output(i, j, d) = double(I- i_min) * (double(intensity_levels-1)/diff);
        end
    end
end
end