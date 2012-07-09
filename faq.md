---
layout: default
title: OpenPIV-Matlab Frequently Asked Questions
---

# Frequently Asked Questions about OpenPIV semantics

## Important parameters

### `sclt` or `scale` or `scaling` parameter: 

This is a conversion constant from pixel/dt displacement to the velocity units. E.g. 
if the time between the two consecutive image is dt = 0.5 seconds and 1 pixel in 
the image corresponds to 50 cm, the value of `sclt` would be:


PIV gives displacement in pixels, therefore first multiply the displacement in pixels 
by the scaling of cm/pixel, i.e. by 50 cm/pixel. To know the speed, the displacement 
is divided by the time separation, i.e. by 0.5 seconds, then we get: 
	scaling = sclt = 50 cm/pixels / 0.5 = 100 (cm/seconds/pixels]

For example, if the vector is 10 pixels, then the result will be 100 * 10 = 1000 cm/s


### `crop vector` not existing in GUI version 

This is a vector that includes a number of rows or columns of interrogation windows to crop 
from the borders of the image. For example, if I do 32 x 32 interrogation windows and 
I want to remove the top 100 pixels, I use 
	`crop_vector = [0 3 0 0]`

i.e. (3 x 32 = 96 pixels). 


### S/N type: 
1 - peak-to-mean = the ratio of the peak in the correlation plan to the mean of the correlation window is estimated
2 - peak-to-peak = the ratio of the first peak to the second peak is estimated

### S/N value: 
this is a threshold of the S/N type, above which the vector is accepted or rejected if S/N type value is below the threshold

### Outlier filter:
a threshold of the velocity in the point of interest as compared to the neighbors - above this value the velocity vector is rejected

### Jump:
1 - if you use every second image or every pair
N - if you want to correlate image i with image i+N, e.g. useful for oversampled cases and for time-resolved PIV analysis


##  General PIV questions:

### Whats the purpose of the local and global filtering?

Global filtering supposingly removes the obvious outliers, i.e. the vectors which length 
is different from the mean of the flow field by at least 3  times its standard deviation. 
These are global outliers in the statistical sense.

Local filtering is performed on small neighborhoods of vectors, e.g. 3 x 3 or 5 x 5, 
in order to find local outliers - the vectors that are dissimilar from the close neighbors.
 Typically there are about 5 per-cent of erroneous vectors and these are removed and later
  the missing values are interpolated from the neighbor vector values. This is also a
   reason for the Matlab version to generate three lists of files:
Raw data in `_noflt.txt`
Filtered (after global and local filters) - `_flt.txt`
Filtered and interpolated data - `.txt`



### In the ``cross_correlate`` function, why the average value of the pixels are subtracted 
from the sub images (`a2,b2`):
	a2 = a2 - mean2(a2);
	b2 = b2 - mean2(b2);


This is well described in the book by Raffel et al. (2007) and others. In one sentence, if
 your images have not absolutely black background (zero), then the background 
(which is a kind of noise) contributes to the correlation and this is 
undesirable. you're welcome to change it and check. maybe in some
cases it is not true. I didn't find such a case.



### Also in the same function while taking the FFT:

    ffta = fft2(a2,Nfft,Nfft);            
    fftb = fft2(b2,Nfft,Nfft);


why the size has been specified as Nfft which is twice the interrogation
window size.

In PIV  correlation analysis is applied to finite size windows therefore, the input `Nfft`
is given to create first padding of the window with zeros followed by correlation.



### Why sub image `b2` is rotated before taking the correlation
	b2 = b2(end:-1:1,end:-1:1);
	
Without rotation the inverse FFT of the product of two FFTs gives a convolution. 
Correlation needs a conjugate term, therefore: 

	ifft( fft(a) x fft(conj(b)) )	
	
For images `conj ( )` is replaced by rotation in the case of real values. 
It is more computationally efficient.



### In the `find_displacement(c,s2nm)` function for finding `peak2`, why neighbourhood pixels 
around `peak1` are removed?   


We need to search for the "real" second peak that is not a part of the same first `peak1` 
hey appear as 'false second peak', but they are the part <br />



### The `.txt` files contain the variable `vel`. Is it in metres/second?


It is not in general case, it depends on the `scaling` or `sclt` variable. If it's 1, then
it `vel` is still in pixels/dt



= How to read OpenPIV files =

OpenPIV files are simple ASCII files with the 5 columns:

{{{
x, y, u, v, signal-to-noise-ratio
}}}

If you're going to analyze multiple PIV files, we recommend the two options:

  1. If you're [http://www.tsi.com TSI] user, you have an access to our post-processing toolbox, called [http://www.tsi.com/en-1033/applications/spray_diagnostics/3672/insight_3g%E2%84%A2_data_acquisition,_analysis,_and_display_software.aspx SpatialBox], developed specially for TSI's Insight 3G software in Matlab. It has pretty serious GUI options and the manual is available from TSI.
  1. Use free, open-source Matlab toolbox called [http://www.fast.u-psud.fr/pivmat/ PIVMAT]

For the option 2, we prepared a small Matlab utility function that converts OpenPIV (for Matlab and other software) files into PIVMAT compatible structure. Warning - it assumes that the proper scaling was applied during the OpenPIV run and the data is stored in mm/sec and mm units. If it's not, please, apply scaling manually by adding the lines:

{{{
    v(i).x = unique(tmp(:,1)).'; % reshape(tmp.data(:,2),lx,ly);
    v(i).y = unique(tmp(:,2)).'; % reshape(tmp.data(:,3),lx,ly);
    v(i).vx = reshape(tmp(:,3),lx,ly);
    v(i).vy = reshape(tmp(:,4),lx,ly);
}}}

=== The function '''loadOpenPIVTXT.m''' ===

{{{
function [v] = loadopenpivtxt(dirname,type)
%LOADOPENPIVTXT  Loads vector fields created by OpenPIV (www.openpiv.net)
%   software.
%
%   F = LOADOPENPIVTXT(FILENAME) loads the vector fields matching FILENAME
%   into the structure array F.
%
%   The resulting structure array F can be displayed using SHOWVEC or
%   SHOWSCAL. For multi-frame images, only the first frame is loaded. Use
%   VEC2SCAL to compute scalar fields from vector fields.
%
%   F = LOADOPENPIVTXT(DIRNAME,TYPE) loads all the vector fields matching TYPE
%   in the directory DIRNAME into the structure array F.
%   TYPE: 'raw' (or 'noflt')
%         'filtered' (or 'flt')
%         'final' (or 'txt') <- default
%
%   Examples:
%           v = loadopenpivtxt('hipivdata') % reads all TXT files by default
%           v = loadopenpivtxt('.','raw')
%           v = loadopenpivtxt('.','txt')
%           v = loadopenpivtxt('hipivdata','raw')
%           v = loadopenpivtxt('hipivdata/00020359.txt') % single file
%
%   Note: When used with DaVis files, LOADVEC works only under Windows
%   32-bits edition. See VEC2MAT to convert DaVis files into Mat-files in
%   order to load them on other plateforms (Windows 64-bits, Linux, Mac...)
%
%   See also LOADVEC, SHOWVEC

%   A. Liberzon, alexlib_at_eng.tau.ac.il
%   Revision: x.xx,  Date: July 26, 2009


% default inputs
if ~nargin
    dirname = '.';
    type = 'txt';
end

% default type input
if nargin < 2 | isempty(type)
    type = 'txt';
end

if exist(dirname,'file') == 2
    fileList = {dirname};
    dirname = '.';
else
    % get the fileList
    fileList = listTXTfiles(dirname,type);
end
[v] = loadtopivmatstructure(dirname,fileList)

% % make quiver of the files
% for i = 1:numel(onlyTxtFiles)
%     data = load(onlyTxtFiles{i});
%     quiver(data(:,1),data(:,2),data(:,3),data(:,4));
% end

% % if in a single file, the data is like this:
% plot(data(:,3).^2 + data(:,4).^2)
end

function [v] = loadtopivmatstructure(dirname,fileList)
wd = cd;
cd(dirname);

v = repmat(struct('x','y','vx','vy','choice','unitx','unity','namex','namey',...
    'unitvx','unitvy','namevx','namevy','pivmat_version','ysign','Attributes',...
    'name','setname','history','source'),1,length(fileList));

tmp = load(fileList{1});
x =  tmp(:,1);
y =  tmp(:,2);

lx = length(unique(x));
ly = length(unique(y));


for i = 1:length(fileList)

    % Import the file
    tmp = load(fileList{i});

    % convert into PIVMAT structure

    v(i).x = unique(tmp(:,1)).'; % reshape(tmp.data(:,2),lx,ly);
    v(i).y = unique(tmp(:,2)).'; % reshape(tmp.data(:,3),lx,ly);
    v(i).vx = reshape(tmp(:,3),lx,ly);
    v(i).vy = reshape(tmp(:,4),lx,ly);
    v(i).history = {['load_dpiv(',fileList{i},')']};
    v(i).unitx = 'mm';
    v(i).unitx = 'mm';
    v(i).unitvx = 'm/s';
    v(i).unitvx = 'm/s';
    v(i).namex = 'x';
    v(i).namey = 'y';
    v(i).namevx = 'u_x';
    v(i).namevy = 'u_y';
    v(i).setname = 'tmp';
    v(i).ysign = 'Y axis upward';
    v(i).pivmat_version = '1.80';
end
cd(wd);

end

function [fileList] = listTXTfiles(dirname,type)
% reading the files from the directory of the TYPE only
% TYPE: 'txt' or 'final'
%       'noflt' or 'raw'
%        'flt'  or 'filtered'
wd = cd;
cd(dirname);
fileList = dir('*.txt'); % list all files
fltFileList = dir('*_flt.txt'); % only filtered (before interpolation)
noFltFileList = dir('*_noflt.txt'); % only raw files (before filtering and interpolation)
% list only final files, after filtering and interpolation
switch type
    case{'txt','final'}
        fileList = setdiff(setdiff({fileList.name},{fltFileList.name}),{noFltFileList.name});
    case{'noflt','raw'}
        fileList = {noFltFileList.name};
    case{'flt','filtered'}
        fileList = {fltFileList.name};
end
cd(wd);
end
}}}
Easy to use with PIVMAT, e.g. animate your flow fields by:

{{{
showf(loadopenpivtxt('.','txt'))
}}}

The output is something like:

[[Image(MiscWikiFiles:readopenpivtxt.png, width=487, height=365, align=center)]]

Best OpenPIVing ...
