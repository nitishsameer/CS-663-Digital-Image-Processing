function [D,A] = mySpatiallyVaryingKernel(dth,BW,im)
    D = bwdist(BW);
    D = ((D(:,:) <= dth).*D(:,:)) + ((D(:,:)> dth)*dth);
    D = double(D);
    im_pad = im2double(padarray(im,[2*dth 2*dth],0,'both'));
    %to run over all i,j 
    % at each point i,j: multiple the matrix with elements of image and add
    % them
    [rows,cols] = size(D);
    A= zeros(size(im_pad));
    for i = 1:rows
        for j= 1:cols
            if D(i,j)==0
                A(i,j,:)= im_pad(i+(2*dth),j+(2*dth),:);
                continue;
            end
            M_ij = fspecial('disk',D(i,j));
            factor = M_ij(round(end/2),round(end/2)); 
            r = round(D(i,j)/2);
            A(i,j,:) = sum(sum(im_pad(-r+i+(2*dth):r+i+(2*dth),-r+j+(2*dth):r+j+(2*dth),:).*factor*3));
        end
    end
    A = A(1:rows,1:cols,:);
end