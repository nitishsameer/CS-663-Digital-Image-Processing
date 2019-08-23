function [A] = myBilinearInterpolation(inputImage)
    A = kron(double(inputImage),[1,0;0,0;0,0]);  % padding matrix with 0s in between elements to be interpolated
    A(end,:)= [];A(end,:)= [];A(:,end)= [];  % removing excess rows and columns at the end
    A(1:3:end,2:2:end) = (A(1:3:end,1:2:end-1) + A(1:3:end,3:2:end))/2;
    A(2:3:end,:) =  (2*A(1:3:end-1,:) + 1*A(4:3:end,:))/3;
    A(3:3:end,:) =  (1*A(1:3:end-1,:) + 2*A(4:3:end,:))/3;
    A = uint8(A);
end
