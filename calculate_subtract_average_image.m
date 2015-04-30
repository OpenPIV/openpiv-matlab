% CALCULATE_SUBTRACT_AVERAGE_IMAGE
% reads through the image files in the selected directory (using UIGETDIR)
% and calculates the average image. The average image is saved in the same directory
% under AVERAGE.JPG
% The average image is subtracted from all the files selected and the result images
% are written in subdirectory /TEST with the same file names
% It does both contrast enhancement and uneven background illumination correction
% (including reflections)
% 
% Author: Alex Liberzon
% Copyright (c) 1999 alex.liberzon@gmail.com




% d = dir('*.tif');
[d,pth] = readImdir; % use the OpenPIV function with GUI

success = mkdir(pth,'test');
if success 
    newdir = fullfile(pth,'test');
else
    error('new directory is not created')
end

a = im2double(imread(fullfile(pth,d{1})));

for i = 2:length(d)
    imfile = fullfile(pth,d{i});
    a = imadd(a,medfilt2(im2double(imread(imfile)))); 
end

averageImage = a/length(d);
imwrite(averageImage,fullfile(newdir,'average.jpg'),'jpg');

for i = 1:length(d)
    imfile = fullfile(pth,d{i});
    newfile = fullfile(newdir,d{i});
    imwrite(imsubtract(im2double(imread(imfile)),averageImage),newfile);
end