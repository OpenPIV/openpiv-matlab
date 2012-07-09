function [v] = loadopenpivtxtdir(dirname,type)

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

v = repmat(struct('x','y','vx','vy','choice','unitx','unity','namex','namey',...
    'unitvx','unitvy','namevx','namevy','pivmat_version','ysign','Attributes',...
    'name','setname','history','source'),1,length(fileList));

tmp = load(fullfile(dirname,fileList{1}));
x =  tmp(:,1);
y =  tmp(:,2);

lx = length(unique(x));
ly = length(unique(y));


for i = 1:length(fileList)

    % Import the file
tmp = load(fullfile(dirname,fileList{i}));

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
    v(i).ysign = 'Y axis downward';
    v(i).pivmat_version = '1.90';
end


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
