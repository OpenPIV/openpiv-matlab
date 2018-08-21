function openpiv(directory, image_ext, cropvec, ittWidth, ittHeight, ...
    ovlapHor, ovlapVer, pairs, jump, s2ntype, s2nl, outl)

if ~nargin
    directory = 'test2';
    % image_ext = {'jpg','bmp','jpeg','tif','tiff','png'}; % all types
    image_ext = {'bmp'};
    cropvec = [0,0,0,0];
    ittWidth = 32;
    ittHeight =  32;
    ovlapHor = 16;
    ovlapVer = 16;
    pairs = 0; % if pairs _b, _a, then true, otehrwise (sequence) is false
    jump = 1;  % if sequence we can process 1-2, 2-3 or 1-3, 2-4 and so on
    % change jump from 1 to any number which is smaller than the
    % number of files
    s2ntype = 1;
    s2nl = 100;
    outl = 10;
    
end


for i = 1:length(image_ext)
    images_list = dir(fullfile(directory, ['*.',image_ext{i}]));
end

% if crop_vec_flag
%     cropvec = rect;
% else
%     cropvec = [0 0 0 0];
% end

% if jump_flag
%     if jump == -1
%         jump = 0;
%     end
% end

% prepare the list of pairs of images to process
% depending on the sequence or pairs type of the list
%
if pairs % pairs, _a,_b or _b,_c or _LA, _LB, etc.
    A_list = 1:2:length(images_list)-jump;
    B_list = 2:2:length(images_list);
else % sequence
    A_list = 1:length(images_list)-jump;
    B_list = 1+jump:length(images_list);
end

for i = 1:length(A_list)
    
    disp([A_list(i),B_list(i)])
    
    image1 = fullfile(directory,images_list(A_list(i)).name);
    image2 = fullfile(directory,images_list(B_list(i)).name);
    
    [a,b,a1,b1,origin] = read_pair_of_images_rect(image1,image2,cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer);
    if isempty(a) || isempty(b)
        error('Something wrong with your images')
    end
    if isempty(a1) || isempty(b1)
        disp('Something is wrong with the cropped images');
    end
    
    
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
    
    figure, hold on
    % imshow(imadjust(a),[]);
    imshow(a,[]);
    % hold on
    % h1 = animatedline('Color','y');
    % h2 = animatedline('Color','y');
    
    for m = rows % vertically
        for k = cols % horizontally
            
            a2 = a1(m:m+ittHeight-1,k:k+ittWidth-1);
            b2 = b1(m:m+ittHeight-1,k:k+ittWidth-1);
            
            
            c = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth);
            % c = cross_correlate_rect(a2,b2,Nfftx,Nffty);
            if ~any(c(:)) % completely "black"
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
            
        end
    end
    
    no_filt_res = res;
    
    [res, filt_res] = openpiv_filter(res,numcols,numrows,outl);
    
    % imshow(prepfun(a),[]);
    % imshow(a,[]);
    % hold on
    % clearpoints(h1);
    % clearpoints(h2);
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
    
    basename = image1(1:end-4);
    baseext = '.vec';
    
    openpiv_output(res,no_filt_res,filt_res,dt,sclt,numrows, numcols, ...
        path,basename,baseext);
    
end

