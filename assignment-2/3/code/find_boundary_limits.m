function [left_limit, right_limit, top_limit, bottom_limit] = find_boundary_limits(row_iter, col_iter, window, nrows, ncols)

half_window = (window-1)/2;

if row_iter+half_window > nrows
    left_limit = nrows-window+1;
else
    left_limit = max(1, row_iter-half_window);
end
right_limit = left_limit + window - 1;

if col_iter+half_window > ncols
    top_limit = ncols-window+1;
else
    top_limit = max(1, col_iter-half_window);
end
bottom_limit = top_limit + window -1;

end