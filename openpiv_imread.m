function im = openpiv_imread(image_name)
% openpiv_imread encapsulates all the image reading functions
% that can be imread for 'jpg','bmp', etc. or 'tiffread2' for TIFF
% images from Insight (tm)
% Usage:
% >>  im = openpiv_imread(directory, image_name);
% >>  imshow(im);

try
    im = imread(image_name);
catch
    tmp = tiffread2(image_name);
    im = im2double(tmp.data);
end

if ndims(im) == 3
    im = rgb2gray(im);
end

% % Custom pre-processing of images, default = 'imadjust'
% preprocess = get(handles.checkbox_preprocess,'Value');
% if preprocess
%     prepfun = str2func(handles.preprocess);
% else
%     prepfun = @(x)imadjust(x); % default is to stretch the image
% end
% im = prepfun(im);