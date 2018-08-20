function [peak,x,y] = find_peak(c)
% basic function that just finds the 2D maximum
% and returns it x,y position in pixels.
% The edges are removed, the maximum cannot be on the border
%
% Inputs:
%       c - double or single matrix (of size MxN)
%       peak - amplitude the maximum value
%       x,y  - pixel positions (i,j < M,N) of the maximum value
%       the function returns NaNs for all matrices without the mean:
%       if all is NaN or the data is flat.
%
%
%
if all(isnan(c(:))) || min(c(:)) == max(c(:))
    peak = NaN;
    x = NaN;
    y = NaN;
    return
else
    
    [tmp,tmpi] = max(c);
    [peak, y] = max(tmp);
    x = tmpi(y);
end
