function [] = quiverm(x,varargin)
% QUIVERM - plots quiver plot of matrix,
% assuming first column as X, second as Y
% third as U, and forth as V.
% 
% QUIVERM(A,'r') - plots quiver plot
% of matrix A.
% Used by QUIVERTXT function.
%
% 
%
% Author: Alex Liberzon
% Modified at 23.06.05, to show only 'normal' vectors,
% without outliers.
% on IHW_Video

if ischar(x)
	x = eval(x);
end

x(abs(x(:,3)) > prctile(abs(x(:,3)),90),3) = NaN;
x(abs(x(:,4)) > prctile(abs(x(:,4)),90),4) = NaN;
quiver(x(:,1),x(:,2),x(:,3),x(:,4),varargin{1:end});

% quiver(x(:,1),x(:,2),x(:,3),x(:,4),varargin{:});

