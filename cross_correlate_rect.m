function [c] = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth)

% temprorary solution
a2 = a2 - mean2(a2);
b2 = b2 - mean2(b2);

b2 = b2(end:-1:1,end:-1:1);

ffta=fft2(single(a2),NfftHeight,NfftWidth);
fftb=fft2(single(b2),NfftHeight,NfftWidth);

c = real(ifft2(ffta.*fftb));
c(c<0) = 0;
