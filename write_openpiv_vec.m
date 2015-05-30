function success = write_openpiv_vec(filename,data,xUnits,tUnits,numrows,numcols)
% success = write_openpiv_txt(filename,data,,xUnits,uUnits)
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

% print the header
% example of the VEC header
% TITLE="E:\2CM_FP500_5%G_68K\C001H001S0015CC\Soapfilmone\Analysis\Run00000
% 1.T000.D000.P000.H001.L.vec" VARIABLES="X mm", "Y mm", "U m/s", "V m/s",
% "CHC", DATASETAUXDATA Application="PIV" DATASETAUXDATA
% SourceImageWidth="1024" DATASETAUXDATA SourceImageHeight="1024"
% DATASETAUXDATA MicrometersPerPixelX="19.530001" DATASETAUXDATA
% MicrometersPerPixelY="19.530001" DATASETAUXDATA LengthUnit="mm"
% DATASETAUXDATA OriginInImageX="0.000000" DATASETAUXDATA
% OriginInImageY="0.000000" DATASETAUXDATA
% MicrosecondsPerDeltaT="2000.000000" DATASETAUXDATA TimeUnit="ms"
% DATASETAUXDATA SecondaryPeakNumber="0" DATASETAUXDATA
% DewarpedImageSource="0" ZONE I=63, J=63, F=POINT

zone = sprintf('ZONE I=%d, J=%d',numrows,numcols);
header = sprintf('VARIABLES= "X %s", "Y %s", "U %s/%s", "V %s/%s", "CHC", %s\n',...
    xUnits,xUnits,xUnits,tUnits,xUnits,tUnits,zone);

% "CHC"

fprintf(fid,'%s',header);
% print the data
fprintf(fid,'%3d %3d %7.4f %7.4f %7.4f\n',data);
fclose(fid);

if fid ~= -1, success = true; else success = false; end