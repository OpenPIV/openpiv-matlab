function testFindSecondPeak
%testFindPeak Unit test for find_peak in 2D matrix

c = peaks(32);

[~,pixi,pixj] = find_peak(c);

[second_peak,pixi2,pixj2] = find_second_peak(c,pixi,pixj);

if abs(second_peak - 6.8019) > 1e-4
    error('testFindPeak:notEqual', 'Incorrect output for peak.');
end


if ~isequal(pixi2, 25)
    error('testFindPeak:notEqual', 'Incorrect output for pixi.');
end


if ~isequal(pixj2, 8)
    error('testFindPeak:notEqual', 'Incorrect output for pixj.');
end


[~,pixi,pixj] = find_peak(ones(32));
if ~isnan(pixi) || ~isnan(pixj)
    [second_peak,pixi2,pixj2] = find_second_peak(ones(32),pixi,pixj);
    
    if abs(second_peak - 0) > 1e-4
        error('testFindPeak:notEqual', 'Incorrect output for peak.');
    elseif ~isequal(pixi2, 1)
        error('testFindPeak:notEqual', 'Incorrect output for pixi.');
    elseif ~isequal(pixj2, 1 )
        error('testFindPeak:notEqual', 'Incorrect output for pixj.');
    end
end



