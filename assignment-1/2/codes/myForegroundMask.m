function [mask, maskedImage] = myForegroundMask(input, I)
%%
mask = logical(input);
maskedImage = input; % To maintain datatype
[row, col] = size(input);

%% Binary Mask
for i = 1: row
    for j = 1:col
        if (input(i,j)< I)
            mask(i,j) = 0;
        else
            mask(i, j) = 1;
        end
    end
end

%% Masked image
for i = 1: row
    for j = 1:col
        if (mask(i,j))
            maskedImage(i,j) = input(i, j);
        else
            maskedImage(i,j) = 0;
        end
    end
end

end