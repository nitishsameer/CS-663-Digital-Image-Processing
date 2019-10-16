function [U,S,V] = mySVD(A)
    [U,eig_left] = eig(A*A');
    [d,ind] = sort(diag(eig_left),'descend');
    eig_left = eig_left(ind,ind);
    U = U(:,ind);
    [V,eig_right] = eig(A'*A);
    [d,ind] = sort(diag(eig_right),'descend');
    eig_right = eig_right(ind,ind);
    V = V(:,ind);
    eig_left = sqrt(nonzeros((diag(eig_left)>1E-6).*diag(eig_left)));
    S1 = diag(inv(U)*A*inv(V'));
    change = diag(double(abs(S1+eig_left)<1E-6));
    change = change*-2 + eye(length(eig_left));
    if ((size(change) == size(V)) == [1 1])
    V = V*change;
    else
    U = U*change;
    end
    S = zeros(size(A));
    for i = 1:length(eig_left)
        S(i,i) = eig_left(i);
    end  
end