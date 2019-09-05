function output = calculate_rmsd(A, B)
%Function to calculate RMSD between two images A and B

[row, col, depth] = size(A);
diff = A-B;
sq_diff = diff.*diff;
output = sqrt((1/(row*col*depth*1.0))*(sum(sq_diff(:))));

end