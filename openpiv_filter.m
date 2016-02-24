function [res, filt_res] = openpiv_filter(res,numcols,numrows,outl)
% openpiv_filter(res)
% filters the results of the openpiv processing
% of two images using the 1) global filter, 2) median filter
% and also stores the data in several files
% VEC file with the filtered and interpolated data
% TXT files with the raw, not filtered and not interpolated data
% Last modified: Feb 24, 2016
% Author: Alex Liberzon alex dot liberzon at gmail dot com
% 


% Reshape U and V matrices in two-dimensional grid and produce
% velocity vector in U + i*V form (real and imaginary parts):


u = reshape(res(:,3), numcols,numrows);
v = reshape(res(:,4), numcols,numrows);
vector = u + sqrt(-1)*v;

vector(isnan(vector)) = 0;

% vector = fill_holes(vector);

% Remove outlayers - GLOBAL FILTERING
vector(abs(vector)>mean(abs(vector(vector~=0)))*outl) = 0;
% vector = fill_holes(vector);

u = real(vector);
v = imag(vector);

% Adaptive Local Median filtering

kernel = [-1 -1 -1; -1 8 -1; -1 -1 -1];
tmpv = abs(conv2(v,kernel,'same'));
tmpu = abs(conv2(u,kernel,'same'));

% WE HAVE TO DECIDE WHICH LIMIT TO USE:
% 1. Mean + 3*STD for each one separately OR
% 2. For velocity vector length (and angle)
% 3. OR OTHER.

lmtv = mean(tmpv(tmpv~=0)) + 3*std(tmpv(tmpv~=0));
lmtu = mean(tmpu(tmpu~=0)) + 3*std(tmpu(tmpu~=0));

u_out = find(tmpu>lmtu);
v_out = find(tmpv>lmtv);

% Let's throw the outlayers out:
u(u_out) = 0; u(v_out) = 0;
v(v_out) = 0; v(u_out) = 0;
vector = u + sqrt(-1)*v;

res(:,3) = reshape(real(vector),numrows*numcols,1);
res(:,4) = reshape(imag(vector),numrows*numcols,1);

% Filtered results will be stored in '.._flt.txt' file
filt_res = res;

vector = fill_holes(vector);
res(:,3) = reshape(real(vector),numrows*numcols,1);
res(:,4) = reshape(imag(vector),numrows*numcols,1);

% draw a bit nicer quiver with two colors




% Results visualization
% Only for final, filtered and interpolated data
%    imshow(a,[]);
%    hold on
%             quiverm(res,2,'g','LineWidth',1);
%             drawnow
%    F(:,fileind) = getframe;
