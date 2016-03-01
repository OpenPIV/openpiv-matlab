function [c,c2] = cross_correlate_rect(a2,b2,NfftHeight,NfftWidth)

% temprorary solution
a2 = a2 - mean2(a2);
b2 = b2 - mean2(b2);

b2 = b2(end:-1:1,end:-1:1);

ffta=fft2(single(a2),NfftHeight,NfftWidth);
fftb=fft2(single(b2),NfftHeight,NfftWidth);

c = real(ifft2(ffta.*fftb));

% another option not implemented yet, but b2 shall be larger than a2
% see >> help normxcorr2
a3=a2(2:end-1,2:end-1); %taglio bordi di a2
b2 = b2(end:-1:1,end:-1:1); %raddrizzo l'immagine
c2 = normxcorr2(a3,b2); %calcolo correlazione normalizzata
% c = normxcorr2(b2,a2);

c(c<0) = 0;
c2(c2<0) = 0;
return
