function readURAPIVdata(dirname)
% READURAPIVDATA reads the directory of the experiment, 
% where URAPIV saves the output and converts it to the 
% 3D matrix of U,V and 2D matrices of X,Y. The files 
% would be read and saved: *_flt.txt, *_noflt.txt, *.txt
%
% READURAPIVDATA('Y:\UraPIV\images','flt')
%
% Author: Alex Liberzon
% Copyright (c) 2004, IHW, ETH Zurich
% Last modified: April 23, 2004
%
%

if ~nargin % debug run
     % dirname = 'Y:\UraPIV\images'
     disp('Usage: readURAPIVdata(''E:\aneurism\piv23apr_C001S0003'')');
     return
end

wd = cd;

try 
cd(dirname);


direcflt = dir(fullfile(dirname,'*_flt.txt'));
direcnoflt = dir(fullfile(dirname,'*_noflt.txt'));
direc = dir(fullfile(dirname,'*.txt'));
filenames = {};
filenamesflt = {};
filenamesnoflt = {};
[filenames{1:length(direc),1}] = deal(direc.name);
[filenamesflt{1:length(direcflt),1}] = deal(direcflt.name);
[filenamesnoflt{1:length(direcnoflt),1}] = deal(direcnoflt.name);
[junk,i,j1] = intersect(filenamesflt,filenames);
[junk2,i,j2] = intersect(filenamesnoflt,filenames);
ind = 1:length(filenames);
ind = setdiff(setdiff(ind,j1),j2);
filenames = filenames(ind);

filenames = sortrows(filenames);
filenamesflt = sortrows(filenamesflt);
filenamesnoflt = sortrows(filenamesnoflt);



i = 1;
data = load(filenames{i});
x = data(:,1); y = data(:,2);
u = repmat(0,[length(data),length(filenames)]);
v = u;
u(:,i) = data(:,3);
v(:,i) = data(:,4);

for i = 2:length(filenames)
    data = load(filenames{i});
    u(:,i) = data(:,3);
    v(:,i) = data(:,4);
end

cols = length(unique(x))-1; % notice the directions
rows = length(unique(y))-1;

x = reshape(x,[rows cols]);
y = reshape(y,[rows cols]);
u = reshape(u,[rows cols length(filenames)]);
v = reshape(v,[rows cols length(filenames)]);

save([filenames{1,1}(1:end-14)],'x','y','u','v');

u = repmat(0,[length(data),length(filenamesflt)]);
v = u;
for i = 1:length(filenamesflt)
    data = load(filenamesflt{i});
    u(:,i) = data(:,3);
    v(:,i) = data(:,4);
end
u = reshape(u,[rows cols length(filenamesflt)]);
v = reshape(v,[rows cols length(filenamesflt)]);
save([filenames{1,1}(1:end-14),'_flt'],'x','y','u','v');


u = repmat(0,[length(data),length(filenamesnoflt)]);
v = u;

for i = 1:length(filenamesnoflt)
    data = load(filenamesnoflt{i});
    u(:,i) = data(:,3);
    v(:,i) = data(:,4);
end
u = reshape(u,[rows cols length(filenamesnoflt)]);
v = reshape(v,[rows cols length(filenamesnoflt)]);
save([filenames{1,1}(1:end-14),'_noflt'],'x','y','u','v');

cd(wd);

catch
    cd(wd);
    error('Something wrong')
end


