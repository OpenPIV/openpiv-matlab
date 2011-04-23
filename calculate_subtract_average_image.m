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

directory = uigetdir('Directory to read images from');
curdir = cd;
try 
cd(directory);
mkdir(directory,'test');
newdir = [directory,filesep,'test'];

d = dir('*.tif');
a = im2double(imread(d(1).name)); 
for i = 2:length(d)
    a = imadd(a,im2double(imread(d(i).name))); 
end; 
averageImage = a/length(d);
imwrite(averageImage,'average.jpg','jpg');

for i = 1:length(d)
    imwrite(imsubtract(im2double(imread(d(i).name)),averageImage),[newdir,filesep,d(i).name],'tiff');
end; 
catch
    cd(curdir);
end