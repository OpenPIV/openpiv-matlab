function [peak2,pixi2,pixj2] = find_second_peak(c, pixi, pixj)
% find second peak in the matrix c 
% typically c is an output of the cross-correlation
%
% Author: Alex Liberzon
% Copyright (c) 2016 OpenPIV - www.openpiv.net


% the logic is:
% 1. find the peak
% 2. make it a valley by flipping the peaks/valleys
% 3. fill the hole, or fill the valey
% 4. flip again, the peaks now are the secondary mountains only. 

if all(isnan(c(:)))
    peak2 = NaN; 
    pixi2 = NaN; 
    pixj2 = NaN;
    return
end

d = c(pixi,pixj) - c;
e = imfill(d);
f = max(e(:)) - e;

[tmp,tmpi] = max(f);
[peak2, pixj2] = max(tmp);
pixi2 = tmpi(pixj2);