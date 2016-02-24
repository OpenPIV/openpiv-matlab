function vector = fill_holes(vector)
% Filling holes in the 2D matrix 'vector'
% using inpaint_nans, thanks to John D'Errico
% Note: openpiv-matlab marks the bad vectors by zero values
% in the future to be replaced by NaNs
% Last modified: Feb 24, 2016
% Author: Alex Liberzon (alex.liberzon@gmail.com)
%
% See also INPAINT_NANS
%
vector(abs(vector) == 0) = NaN;

while any(isnan(vector(:))) 
    % vector = inpaint_nans(real(vector)) + 1i*inpaint_nans(imag(vector));
    vector = inpaint_nans(vector); % works for complex values out of the box
end
