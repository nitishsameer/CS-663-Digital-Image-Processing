%% Function
function [output, image] = myBilateralFiltering(input, win_l, sigma_d, sigma_i)

%% Corrupt the image
image = add_noise(input); 

%% 
output = input;
[row, col] = size(input);
half_window = ceil((win_l - 1)/2); %Odd window length preferred          
padded_input = padarray(image, [half_window half_window], 'replicate', 'both');

%% 
for i = 1+half_window: row+half_window
    for j = 1+half_window: col+half_window
            
         W = padded_input(i-half_window:i+half_window, j-half_window:j+half_window);
         %% 
         I_diff = W - padded_input(i,j);
         weight = zeros(size(I_diff));
         xc = (win_l+1)/2;
         yc = (win_l+1)/2;
         num = 0; den = 0;
         %% 
         for k = 1: win_l
             for l = 1: win_l
                 weight(k,l) = exp(-(((k-xc)^2 + (l-yc)^2)/(2*sigma_d^2))-(I_diff(k,l)^2/(2*sigma_i^2)));
                 num = num + (W(k,l) * weight(k,l));
                 den = den + (weight(k,l));
             end
         end
         output(i-half_window ,j-half_window ) = num/den;
    end
end
 rmsd = calculate_rmsd(input, output)
