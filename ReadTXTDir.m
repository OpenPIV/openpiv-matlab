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

if ~isempty(str2num(direc(1).name(1:length(direc(1).name)-4)))
    for i = 1:length(direc)
        n(i) = str2num(direc(i).name(1:length(direc(i).name)-4));
    end
    [junk,j] = sort(n);
    direc = direc(j);
end

filenames={};
[filenames{1:length(direc),1}] = deal(direc.name);
% filenames = sortrows(filenames);





