function [peak1,peak2,pixi,pixj] = find_displacement_rect(c,s2ntype)
% FIND_DISPLACEMENT - Finds the highest peak in cross-correlation
% matrix and the second peak (or mean value) for signal-to-noise
% ratio calculation.
% Inputs:
%         c - cross-correlation matrix
%         s2ntype - method (1 or 2) of S2N ratio calculation
% Outputs:
%         peak1 = highest peak
%         peak2 = second highest peak (or mean value)
%         pixi,pixj = row,column indeces of the peak1
%
% Authors: Alex Liberzon, Roi Gurka, OpenPIV - www.openpiv.net


% Find your majour peak = mean pixel displacement between
% two interrogation areas:

[NfftHeight,NfftWidth] = size(c);

[peak1, pixi, pixj] = find_peak(c);

% If the peak is found on the border, we should not accept it:
if pixi==1 || pixj==1 || pixi == NfftHeight || pixj == NfftWidth
    peak2 = peak1; % we'll not accept this peak later, by means of SNR
else
    % Look for the Signal-To-Noise ratio by
    % 1. Peak detectability method: First-to-second peak ratio
    % 2. Peak-to-mean ratio - Signal-to-noise estimation
    
    if s2ntype == 1		% First-to-second peak ratio
        [peak2,x2,y2] = find_second_peak(c,pixi,pixj);
        % If second peak is on the borders
        if x2 ==  1 || y2 == 1 || x2 == NfftHeight || y2 == NfftWidth
            peak2 = peak1;
        end
        
    elseif s2ntype == 2   % PEAK-TO-MEAN VALUE RATIO:
        peak2 = mean2(abs(c));
    end		% end of second peak search, both methods.
end			% end of if highest peak on the border
