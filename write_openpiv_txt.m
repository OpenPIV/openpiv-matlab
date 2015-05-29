function success = write_openpiv_txt(filename,data)
% success = write_openpiv_txt(filename,data,parameters)
% originally it was just
% fid = fopen(fullfile(handles.path,[handles.files{fileind}(1:end-4),'.txt']),'w');
% fprintf(fid,'%3d %3d %7.4f %7.4f %7.4f\n',res');
% fclose(fid);

% minimal implementation
% filename is a full path
% fullfile(handles.path,[handles.files{fileind}(1:end-4),'.txt'])
fid = fopen(filename,'w');

% data is called res in OpenPIV and it shall be N rows x 5 cols
% in print, it's rotated to 5 rows x N cols
if size(data,2) == 5
     data = data';
elseif size(data,1) ~= 5
    error('Wrong number of columns');
end
fprintf(fid,'%3d %3d %7.4f %7.4f %7.4f\n',data);
fclose(fid);

if fid ~= -1, success = true; else success = false; end