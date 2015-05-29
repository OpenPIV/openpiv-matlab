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
% Authors: Alex Liberzon & Roi Gurka
% Date: 20-Jul-99
% Last modified:
%

% Find your majour peak = mean pixel displacement between
% two interrogation areas:

[NfftHeight,NfftWidth] = size(c);

[tmp,tmpi] = max(c);
[peak1, pixj] = max(tmp);
pixi = tmpi(pixj);


% Temproraly matrix without the maximum peak:
tmp = c;
tmp(pixi,pixj) = 0;
% If the peak is found on the border, we should not accept it:
if pixi==1 || pixj==1 || pixi == NfftHeight || pixj == NfftWidth
    peak2 = peak1; % we'll not accept this peak later, by means of SNR
else
    % Look for the Signal-To-Noise ratio by
    % 1. Peak detectability method: First-to-second peak ratio
    % 2. Peak-to-mean ratio - Signal-to-noise estimation

    if s2ntype == 1		% First-to-second peak ratio
        % Remove 3x3 pixels neighbourhood around the peak
        tmp(pixi-1:pixi+1,pixj-1:pixj+1) = NaN;
        % Look for the second highest peak
        peak2 = max(tmp(:));
        [x2,y2] = find(tmp==peak2);
        tmp(x2,y2) = NaN;
        % Only if second peak is within the borders
        if x2 > 1 && y2 > 1 && x2 < NfftHeight && y2 < NfftWidth

            % Look for the clear (global) peak, not for a local maximum:
            while peak2 < max(max(c(x2-1:x2+1,y2-1:y2+1)))
                peak2 = max(tmp(:));
                [x2,y2] = find(tmp==peak2);
                if min(x2) == 1 || min(y2)==1 || max(x2) == NfftHeight || max(y2) == NfftWidth
                    peak2 = peak1;	% will throw this one out later
                    break;
                end
                tmp(x2,y2) = NaN;
            end		% end of while
        else			% second peak on the border means "second peak doesn't exist"
            peak2 = peak1;
        end    % if x2 >1 ......end
        % PEAK-TO-MEAN VALUE RATIO:
    elseif s2ntype == 2
        peak2 = mean2(abs(tmp));
    end		% end of second peak search, both methods.
end				% end of if highest peak on the border
return