function [c] = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth)
% C = CROSS_CORRELATE_RECT(I,J,NX,NY)
% A sort of normalized cross correlation of two images, I,J
% using convolution of conjugates and inverse FFT
% only the real and non-negative part is preserved
% Average intensity of each image is subtracted (a sort of highpass)
% NX is not necessarily equal to NY (NX = 32; NY = 128)
% NX,NY are recommended to be a power of 2: 32,64,128,256, ...


% temprorary solution
a2 = a2 - mean2(a2);
b2 = b2 - mean2(b2);

b2 = b2(end:-1:1,end:-1:1);

ffta = fft2(a2,NfftHeight,NfftWidth);
fftb = fft2(b2,NfftHeight,NfftWidth);

c = real(ifft2(ffta.*fftb));

% another option not implemented yet, but b2 shall be larger than a2
% see >> help normxcorr2
% c = normxcorr2(b2,a2);

c(c < 0) = 0;