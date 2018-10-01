function im = openpiv_imread(path,filename)
% openpiv_imread encapsulates all the image reading functions
% that can be imread for 'jpg','bmp', etc. or 'tiffread2' for TIFF
% images from Insight (tm)
% Usage:
% >>  im = openpiv_imread('test1', 'exp1_001_b.bmp');
% >>  imshow(im);

if endsWith(filename,'.tif')
    tmp = tiffread2(fullfile(handles.path,handles.files{filenum}));
    im = im2double(tmp.data);
else
    im = imread(fullfile(path,filename));
end

if ndims(im) == 3
    im = rgb2gray(im);
end

