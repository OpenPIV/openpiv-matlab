function [x,y,u,v] = openpiv(a1,b1,ittWidth,ittHeight,ovlapHor,ovlapVer,s2ntype,s2nl,sclt,dt,outl)
% OpenPIV cross-correlation routine, see http://www.openpiv.net
% 
%
% How to cite: 
% Taylor, Z.J.; Gurka, R.; Kopp, G.A.; Liberzon, A.; ,
% "Long-Duration Time-Resolved PIV to Study Unsteady Aerodynamics,"
% Instrumentation and Measurement, IEEE Transactions on , vol.59, no.12,
% pp.3262-3269, Dec. 2010 doi: 10.1109/TIM.2010.2047149
% URL: http://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=5464317&isnumber=5609237


% OpenPIV uses Matlab FFT that works faster with single than double
a1 = im2single(a1);
b1 = im2single(b1);

if nargin == 6
    s2ntype = 1;
    s2nl = 1;
    sclt = 1;
    dt = 1;
    outl = 10;
    origin = [0,0]; % origin is bottom left
    % cropvec = [0,0,0,0];
end

[verSize,horSize]= size(a1);

% Prepare the results storage;
numcols = floor((horSize-ittWidth)/ovlapHor+1);
numrows = floor((verSize-ittHeight)/ovlapVer+1);
res = zeros(numcols*numrows,5);
resind = 0;


NfftWidth = 2*ittWidth;
NfftHeight = 2*ittHeight;

for m = 1:ovlapVer:verSize - ittHeight + 1 % vertically
    for k = 1:ovlapHor:horSize-ittWidth+1 % horizontally
                
        a2 = a1(m:m+ittHeight-1,k:k+ittWidth-1);
        b2 = b1(m:m+ittHeight-1,k:k+ittWidth-1);
        
        
        c = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth);
        % c = cross_correlate_rect(a2,b2,Nfftx,Nffty);
        if ~any(c(:)), % completely "black"
            u = 0; %#ok<NASGU>
            v = 0; %#ok<NASGU>
            y = origin(1) + m + ittHeight/2 - 1; %#ok<NASGU>
            x = origin(2) + k + ittWidth/2 -  1; %#ok<NASGU>
            continue
        end
        
        [peak1,peak2,pixi,pixj] = find_displacement_rect(c,s2ntype);
        
        [peakVer,peakHor,s2n] = sub_pixel_velocity_rect(c,pixi,pixj,peak1,peak2,s2nl,ittWidth,ittHeight);
        
        % Scale the pixel displacement to the velocity
        u = (ittWidth-peakHor);
        v = (ittHeight-peakVer);
        y = origin(2) + m + ittHeight/2-1;
        x = origin(1) + k + ittWidth/2-1;
        
        resind = resind + 1;
        res(resind,:) = [x y u v s2n];
        % quiver(x+cropvec(1),y+cropvec(2),u,v,'y');
%         if u ~= 0 || v ~= 0
%             %                             quiver(x,y,u,v,5,'y','Linewidth',1);
%             %                             drawnow;
%             % plotarrow(x,y,u,v,'g',10);
%             % draw_arrow([x,y],[x+u,y+v],20)
%             % drawnow
%         end
    end
end




% Reshape U and V matrices in two-dimensional grid and produce
% velocity vector in U + i*V form (real and imaginary parts):

u = reshape(res(:,3), numrows,numcols);
v = reshape(res(:,4), numrows,numcols);
vector = u + sqrt(-1)*v;

% Remove outlayers - GLOBAL FILTERING
ind = isfinite(abs(vector)) & abs(vector) ~= 0;
limit = mean(abs(vector(ind)))*outl;
outliers = abs(vector) > limit;
vector(outliers) = 0;
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
ind = isfinite(abs(tmpv)) & abs(tmpv) ~= 0;
lmtv = mean(tmpv(ind)) + 3*std(tmpv(ind));

ind = isfinite(abs(tmpu)) & abs(tmpu) ~= 0;
lmtu = mean(tmpu(ind)) + 3*std(tmpu(ind));

u_out = find(tmpu>lmtu);
v_out = find(tmpv>lmtv);

% Let's throw the outlayers out:
u(u_out) = 0; u(v_out) = 0;
v(v_out) = 0; v(u_out) = 0;
vector = u + sqrt(-1)*v;

res(:,3) = reshape(real(vector),numrows*numcols,1);
res(:,4) = reshape(imag(vector),numrows*numcols,1);


vector = fill_holes(vector,numrows,numcols);
res(:,3) = reshape(real(vector),numrows*numcols,1);
res(:,4) = reshape(imag(vector),numrows*numcols,1);


% scale the pixels and apply the dt

if sclt ~= 0
    res = res * sclt; % pixels to meters
    xUnits = 'm';
else
    xUnits = 'pix';
end

if dt ~= 0
    res(:,3:4) = res(:,3:4)/dt;
    tUnits = 's';
else
    tUnits = 'dt';
end

% Save results as ASCII (text) files:
% Final (filtered, interpolated) results
% fid = fopen([dirname,filesep,filenames(fileind,1:end-4),baseext],'w');

baseext = '.vec';

% final = fullfile([imfile1,baseext]);
% write_openpiv_vec(final,res,xUnits,tUnits,numrows,numcols);

x = reshape(res(:,1),numcols,numrows);
y = reshape(res(:,2),numcols,numrows);
u = reshape(res(:,3),numcols,numrows);
v = reshape(res(:,4),numcols,numrows);

