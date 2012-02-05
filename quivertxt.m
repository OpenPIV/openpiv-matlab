function [h] = quivertxt(txtfile,varargin)
% QUIVERTXT Uses QUIVERM file and original
% Mathworks' QUIVER function and plots
% quiver plot of the text file produced by
% URAPIV program.
% 
% Author: Alex Liberzon
% Date:   July '99
% 

[~,~,ext] = fileparts(txtfile);
if isempty(ext)
    x = load([txtfile,'.txt']);
else
    x = load(txtfile);
end
quiverm(x,varargin{:});
axis ij
axis tight


