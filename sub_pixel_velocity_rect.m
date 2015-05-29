function [peakx,peaky,s2n] = sub_pixel_velocity_rect(c,pixi,pixj,peak1,peak2,s2nl,ittWidth,ittHeight)
% SUB_PIXEL_VELOCITY - Calculates Signal-To-Noise Ratio, fits Gaussian
% bell, find sub-pixel displacement and scales it to the real velocity
% according the the time interval and real-world-to-image-scale.
%
% Authors: Alex Liberzon & Roi Gurka
% Date: Jul-20-99
% Last Modified:

% If peak2 equals to zero, it means that nothing was found,
% and we'll divide by zero:
if ~peak2
    s2n = Inf;		% Just to protect from zero dividing.
else
    s2n = peak1/peak2;
end

% If Signal-To-Noise ratio is lower than the limit, "mark" it:
if s2n < s2nl
    peakx = ittHeight;
    peaky = ittWidth;
else            % otherwise, calculate the velocity

    % Sub-pixel displacement definition by means of
    % Gaussian bell.

    if pixi < 2 || pixi > size(c,1) - 2 || pixj < 2 || pixj > size(c,2) - 2
        peakx = ittHeight;
        peaky = ittWidth;
        return
    end

    try
        f0 = log(c(pixi,pixj));
        f1 = log(c(pixi-1,pixj));
        f2 = log(c(pixi+1,pixj));
        peakx = pixi + (f1-f2)/(2*f1-4*f0+2*f2);
        f0 = log(c(pixi,pixj));
        f1 = log(c(pixi,pixj-1));
        f2 = log(c(pixi,pixj+1));
        peaky = pixj+ (f1-f2)/(2*f1-4*f0+2*f2);
    catch
        peakx = ittHeight;
        peaky = ittWidth;
    end

    if ~isreal(peakx) || ~isreal(peaky)
        peakx = ittHeight;
        peaky = ittWidth;
    end

end


return