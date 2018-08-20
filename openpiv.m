function varargout = openpiv(varargin)

images_list = openpiv_imread(directory);
% imshow(im);


preprocess = 0;
if preprocess
    im = preprocess_function(im);
end

if crop_vec_flag
    cropvec = rect;
else
    cropvec = [0 0 0 0];
end

if jump_flag
    if jump == -1
        jump = 0;
    end

% Main loop
image1 = fullfile(images_path,images_list{1});
image2 = fullfile(images_path,images_list{1});

[a,b] = read_pair_of_images_rect(,1,1,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);
if isempty(a) || isempty(b)
    errordlg('Something wrong with your images')
end

switch recording_type % sequence of pairs? 
    case{'sequence'}
        for fileind = 1:amount-jump	% main loop, for whole file list
            openpiv_main_loop(, fileind, jump, cropvec,ittWidth,...
    ittHeight,ovlapHor,ovlapVer, prepfun, s2ntype, s2nl, outl, sclt, dt)
        end
    case{'pairs'}
        for fileind = 1:2:amount	% main loop, for whole file list
            openpiv_main_loop(, fileind, 1, cropvec,ittWidth,...
    ittHeight,ovlapHor,ovlapVer, prepfun, s2ntype, s2nl, outl, sclt, dt)
        end
    otherwise
        
end


% -- Main loop --- %
function openpiv_main_loop(, fileind, jump, cropvec,ittWidth,...
    ittHeight,ovlapHor,ovlapVer, prepfun, s2ntype, s2nl, outl, sclt, dt)
% OPENPIV_MAIN_LOOP is the main PIV processing, post-processing and
% plotting subroutines calls

set(edit_num,'string',sprintf('%d',fileind));



[a,~,a1,b1,origin] = read_pair_of_images_rect(,fileind,jump,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);

% a1 = prepfun(a1);
% b1 = prepfun(b1);

[verSize,horSize]= size(a1);

% Prepare the results storage;

rows = 1:ovlapVer:verSize - ittHeight + 1;
cols =  1:ovlapHor:horSize - ittWidth + 1;

numcols = length(rows);
numrows = length(cols);

res = zeros(numcols*numrows,5);
resind = 0;

% a2 = zeros(ittHeight,ittWidth);
% b2 = zeros(ittHeight,ittWidth);
NfftWidth = 2*ittWidth;
NfftHeight = 2*ittHeight;

axes(axes1);
% imshow(imadjust(a),[]);
imshow(a,[]);
hold on
h1 = animatedline('Color','y');
h2 = animatedline('Color','y');

for m = rows % vertically
    for k = cols % horizontally
        % if Stop button pressed:
        if (get(pushbutton_start,'UserData') == 0)
            return;
        end
        
        a2 = a1(m:m+ittHeight-1,k:k+ittWidth-1);
        b2 = b1(m:m+ittHeight-1,k:k+ittWidth-1);
        
        
        c = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth);
        % c = cross_correlate_rect(a2,b2,Nfftx,Nffty);
        if ~any(c(:)), % completely "black"
            u = 0;
            v = 0;
            y = origin(2) + m + ittHeight/2 - 1;
            x = origin(1) + k + ittWidth/2 -  1;
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
        if u ~= 0 || v ~= 0
            plotarrow(h1,h2,x,y,u,v,10);
        end
    end
end

no_filt_res = res;

[res, filt_res] = openpiv_filter(res,numcols,numrows,outl);

% imshow(prepfun(a),[]);
imshow(a,[]);
hold on
clearpoints(h1);
clearpoints(h2);
% for i = 1:length(res)
%     plotarrow(h1,h2,res(i,1),res(i,2),res(i,3),res(i,4));
% end
quiverm(res,'color','g','AutoScaleFactor',2);
ind = (filt_res(:,3) ~= no_filt_res(:,3) | filt_res(:,4) ~= no_filt_res(:,4));
if ~any(ind)
    quiverm(no_filt_res(ind,:),'color','r','AutoScaleFactor',1.25);
end
% for i = 1:length(res)
%     plotarrow(h1,h2,res(i,1),res(i,2),res(i,3),res(i,4));
% end
% drawnow

basename = files{fileind}(1:end-4);
baseext = '.vec';

openpiv_output(res,no_filt_res,filt_res,dt,sclt,numrows, numcols, ...
    path,basename,baseext);

hold off
