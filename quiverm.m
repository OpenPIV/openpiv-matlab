function quiverm(x,varargin)
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
% Modified on Jan 8, 2013, to avoild the unneccesary toolbox
% added very useful prctile function (GPL)
% see below - the user doesn't need the Stats toolbox anymore
%

if isstr(x)
    x = eval(x);
end

x(abs(x(:,3)) > prctile(abs(x(:,3)),99),3) = NaN;
x(abs(x(:,4)) > prctile(abs(x(:,4)),99),4) = NaN;
quiver(x(:,1),x(:,2),x(:,3),x(:,4),varargin{1:end});

% quiver(x(:,1),x(:,2),x(:,3),x(:,4),varargin{:});
return
end


function a = prctile(x, p)

%{
## Copyright (C) 2001 Paul Kienzle
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

## A = prctile(X,p)
##
## Computes the value associated with the p-th percentile of X.  If X is
## a matrix, computes p for each column of X.  If p is a vector, the
## returned value is a matrix with one row for each element of p and one
## column for each column of X.
##
## The first and last values are pegged at 0 percent and 100 percent
## respectively, and the rest of the values are uniformly spaced between
## them, with linear interpolation between the points.  This is
## consistent with the definition of quantile given in the R statistics
## package, but inconsistent with that of the statistics toolbox from
## Matlab.
%}

y = sort(x);
if size (y,1) == 1, y = y.'; end
    trim = 1 + (size(y,1)-1)*p(:)*0.01;
    delta = (trim - floor(trim))*ones(1,size(y,2));
    a = y(floor(trim), :) .* delta + y(ceil(trim), :) .* (1-delta);

end