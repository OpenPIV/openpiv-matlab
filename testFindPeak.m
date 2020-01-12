function testFindPeak
%testFindPeak Unit test for find_peak in 2D matrix

[peak,pixi,pixj] = find_peak(peaks(32));


if abs(peak - 7.9770) > 1e-3
    error('testFindPeak:notEqual', 'Incorrect output for peak.');
end


if ~isequal(pixi, 25)
    error('testFindPeak:notEqual', 'Incorrect output for pixi.');
end


if ~isequal(pixj, 16)
    error('testFindPeak:notEqual', 'Incorrect output for pixj.');
end

[peak,pixi,pixj] = find_peak(ones(32));
if ~isnan(peak)
    error('testFindPeak:notEqual', 'Incorrect output for peak.');
elseif ~isnan(pixi)
    error('testFindPeak:notEqual', 'Incorrect output for pixi.');
elseif ~isnan(pixj)
    error('testFindPeak:notEqual', 'Incorrect output for pixj.');
end


[peak,pixi,pixj] = find_peak(NaN*ones(32));
if ~isnan(peak)
    error('testFindPeak:notEqual', 'Incorrect output for peak.');
elseif ~isnan(pixi)
    error('testFindPeak:notEqual', 'Incorrect output for pixi.');
elseif ~isnan(pixj )
    error('testFindPeak:notEqual', 'Incorrect output for pixj.');
end



