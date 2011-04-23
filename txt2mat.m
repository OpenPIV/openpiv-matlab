function txt2mat(dirname,data,varargin)
% TXT2MAT
% dirname = 'F:\ftproot\Chris\1-ED26_jump10';
% select if you want to process:
% data = '_noflt.txt' % a) raw
% data = '_flt.txt' % b) filtered, no interpolated or
% data = 'txt' % c)filtered and interpolated.

if ~nargin 
    dirname = uigetdir;
    data = 'txt';
end


filenames = ReadTXTDir(dirname,data);
if length([filenames{:}]) < 1, error('Files are not found'), return, end

N = length(filenames);

d = load(fullfile(dirname,filenames{1}));
d = repmat(d,[1 1 N]);
for i = 2:N
    d(:,:,i) = load(fullfile(dirname,filenames{i}));
end

x = d(:,1,:);
x = x(x~=0);
unX = unique(x);

minX = min(unX);
maxX = max(unX);
dX = ceil((maxX-minX)/(length(unX)-1));

y = d(:,2,:);
y = y(y~=0);
unY = unique(y);

minY = min(unY);
maxY = max(unY);
dY = ceil((maxY-minY)/(length(unY)-1));

[X,Y] = meshgrid(minX:dX:maxX,minY:dY:maxY);
[r,c] = size(X);

[U,V,dudx,dudy,dvdx,dvdy] = deal(zeros(r,c,N));

for i = 1:N
    x = d(:,1,i);
    tmp = d(x~=0,:,i);
    y = tmp(:,2);
    x = tmp(:,1);
    for j = 1:length(x)
        [m,n] = find(X == x(j) & Y == y(j));
        U(m,n,i) = tmp(j,3);
        V(m,n,i) = tmp(j,4);
    end
end

if nargin < 3 | isempty(varargin{:})
    save(fullfile(dirname,'coordinates.mat'), 'X','Y');
    save(fullfile(dirname,'velocity.mat'), 'U', 'V');
%    zip(fullfile(dirname,'results.zip'),'*.txt');
    delete([dirname,filesep,'*.txt']);
else
    save(fullfile(dirname,['coordinates',varargin{1},'.mat']), 'X','Y');
    save(fullfile(dirname,['velocity', varargin{1},'.mat']), 'U', 'V');
    zip(fullfile(dirname,['results', varargin{1},'.zip']),'*.txt',dirname);
    delete([dirname,filesep,'*.txt']);
end
disp('MAT files saved successfully,  TXT is zipped')
end


function [filenames] = ReadTXTDir(dirname,data)
if nargin < 2
    data = 'txt';
end

switch data
    case{'_noflt.txt'} % a)
        direc = dir([dirname,filesep,'*_noflt.txt']);
    case{'_flt.txt'} %b)
        direc = dir([dirname,filesep,'*_flt.txt']);
    case{'txt'} % c)
        direc = dir([dirname,filesep,'*.txt']);
        tmp = struct('name',[]);
        k = 0;
        for i=1:length(direc)
            if length(findstr(direc(i).name,'_')) < 2
                k = k + 1;
                tmp(k).name = direc(i).name;
            end
        end
        direc = tmp;
end

if ~isempty(direc(1).name) && ~isempty(str2num(direc(1).name(1:length(direc(1).name)-4)))
    for i = 1:length(direc)
        n(i) = str2num(direc(i).name(1:length(direc(i).name)-4));
    end
    [junk,j] = sort(n);
    direc = direc(j);
end

filenames={};
[filenames{1:length(direc),1}] = deal(direc.name);
% filenames = sortrows(filenames);
end

