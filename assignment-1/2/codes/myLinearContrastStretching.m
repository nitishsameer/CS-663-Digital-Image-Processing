function output = myLinearContrastStretching(input)
%%
[row, col, channel] = size(input);
%output = input;
intensity_levels = 256; %Assumed 8-bit image

%% Redefining intensity by linear map
i_max = max(max(input));
i_min = min(min(input));
diff = i_max - i_min;

% line between (0, i_min) and (255, i_max)
for i = 1: row
    for j = 1: col
        for d = 1: channel
            I = input(i, j, d);
            output(i, j, 1) = (I- i_min) * ((intensity_levels-1)/diff);
        end      
    end
end
end

end