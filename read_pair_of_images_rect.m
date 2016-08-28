function [A,B,A1,B1,origin] = read_pair_of_images_rect(handles,fileind,jump, cropvec,ittWidth,ittHeight,ovlapHor,ovlapVer)
% READ_PAIR_OF_IMAGES - reads two images (image1,image2) as BMP files
% and crops them according to 'cropvec'
% Inputs:
%         image1,image2 - BMP file names (string)
%         cropvec - 4 x 1 vector of follwoing values:
%         [left,top,right,bottom] - each value is a number of lines
%                                   of interrogation areas (ittWidthITT pixels)
%                                   which should be removed before the analysis.
%         itt - interrogation area size in pixels
%         spc - grid spacing (overlapping) size in pixels
%
% Authors: Alex Liberzon & Roi Gurka
% Date: 20-Jul-99
% Last modified:
% Copyright(c) 1999, Alex Liberzon

% A = double(imread(image1,'bmp'))/255;
% B = double(imread(image2,'bmp'))/255;
origin = [0,0];

% image1 = fullfile(handles.path,handles.files{fileind});
 %image2 = fullfile(handles.path,handles.files{fileind+jump});

% try
    A = openpiv_imread(handles,fileind); % ,'tif'); 8 June 2005, no extension is necessary
    B = openpiv_imread(handles,fileind+jump); % ,'tif'); % more flexibility for different image formats
% catch
%     warning off
%     tmp = tiffread2(image1);
%     A = im2double(tmp.data);
%     tmp = tiffread2(image2);
%     B = im2double(tmp.data);
% end
% if ndims(A) == 3
%     A = rgb2gray(A);
%     B = rgb2gray(B);
% elseif ndims(A) == 2
%     A = double(A)/255;
%     B = double(B)/255;
% end



% Crop the images to the desired size and
% cut the last couple of pixels, so we'll get the
% integer number of interrogation areas
%
%       ---- t ---
%      |          |
%      |          |
%      l          r
%      |          |
%      |          |
%       --- b ----
%
%

[verSizeA,horSizeA] = size(A);
[verSizeB,horSizeB]=size(B);
% A & B matrices HAVE to be of the same size, we take smallest:
verSize = min(verSizeA,verSizeB); horSize = min(horSizeA,horSizeB);
if any(cropvec)
    %     A = imcrop(A,cropvec);
    %     B = imcrop(B,cropvec);
    top = max([0,round(cropvec(2)/ittHeight)]); % top side of the image
    left = max([0,round(cropvec(1)/ittWidth)]); % left side of the image
    bottom = max([0,floor((verSize - cropvec(2) - cropvec(4))/ittHeight)]); % bottom side of the image
    right = max([0,floor((horSize - cropvec(1) - cropvec(3))/ittWidth)]); % right of the image
    
    A1 = A(1 + top*ittHeight:ovlapVer*floor(verSize/ovlapVer) - bottom*ittHeight,...
        1+left*ittWidth:ovlapHor*floor(horSize/ovlapHor) - right*ittWidth);
    B1 = B(1 + top*ittHeight:ovlapVer*floor(verSize/ovlapVer) - bottom*ittHeight, ...
        1+left*ittWidth:ovlapHor*floor(horSize/ovlapHor) - right*ittWidth);
else
    A1 = A;
    B1 = B;
    left = 0;
    top = 0;
end

% [rows,cols]=size(A);

if min(size(A1)) < 1
    error('Zero image or too large interrogation windows');
end
origin = [left*ittWidth,top*ittHeight];

return
