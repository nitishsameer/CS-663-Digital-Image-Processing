function output = myCLAHE(input, window, thresh, nbins)

output = input; %To maintain the datatype
[row, col, depth] = size(input);
half_window = ceil((window - 1)/2); %Odd window length preferred

for r=1:row
    disp(r)
    for c=1:col
        for d=1:depth
            %% Finding window bounds and calling myCLAHEonWindow
            x_limit = [max(1, r - half_window) min(row, r + half_window)];
            y_limit = [max(1, c - half_window) min(col, c + half_window)];
            
            sub_image = input(x_limit(1):x_limit(2), y_limit(1):y_limit(2), d);
            output(r, c, d) = myCLAHEonWindow(sub_image, input(r, c, d), thresh, nbins);
        end
    end
end
figure
imshow(output);
end