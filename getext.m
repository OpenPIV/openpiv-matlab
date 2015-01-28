function ext = getext(filename)
% ext = getext(filename) returns the extension of the filename
[~,~,ext] = fileparts(filename);
ext = ext(2:end);