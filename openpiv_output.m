function openpiv_output(res, no_filt_res, filt_res, dt, sclt, ...
    numrows, numcols, filepath,basename,baseext)

% scale the pixels and apply the dt

if sclt ~= 0
    res = res * sclt; % pixels to meters
    no_filt_res = no_filt_res * sclt;
    filt_res = filt_res * sclt;
    xUnits = 'm';
else
    xUnits = 'pix';
end

if dt ~= 0
    res(:,3:4) = res(:,3:4)/dt;
    no_filt_res(:,3:4) = no_filt_res(:,3:4)/dt;
    filt_res(:,3:4) = filt_res(:,3:4) /dt;
    tUnits = 's';
else
    tUnits = 'dt';
end

% Save results as ASCII (text) files:
% Final (filtered, interpolated) results
% fid = fopen([dirname,filesep,filenames(fileind,1:end-4),baseext],'w');


final = fullfile(filepath,[basename,baseext]);
write_openpiv_vec(final,res,xUnits,tUnits,numrows,numcols);

% Unfiltered, uninterpolated: (comment with % sign if you don't need it)
nofilt = fullfile(filepath,[basename,'_noflt.txt']);
write_openpiv_vec(nofilt,no_filt_res,xUnits,tUnits,numrows,numcols);


% Filtered, but not interpolated:
filtered = fullfile(filepath,[basename,'_flt.txt']);
write_openpiv_vec(filtered,filt_res,xUnits,tUnits,numrows,numcols);