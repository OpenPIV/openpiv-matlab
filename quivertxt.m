function [h] = quivertxt(txtfile,varargin)
% QUIVERTXT(TEXTFILENAME,VARARGIN) plots
% quiver plot of the text file produced by the
% OPENPIV program.
%
% Usage:
% quivertxt('test_001_b.txt')
% 
% See also: QUIVERM, QUIVER, OPENPIV

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


