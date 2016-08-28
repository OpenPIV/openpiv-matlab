function [F_sigma, sigma_A, sigma_n, SNR] = get_snr_for_piv(A)
% MATLAB code for the estimation of PIV image noise
% Author: Sven Scharnowski
% Date: 25-May-2016
% Copied by Alex Liberzon from the PDF of the article
% in Exp Fluids (2016) 57:119
% The input is a section of a PIV image with homogeneous noise "A"
% (typically 128 x 128 px or larger) 
% the output is the loss-of-correlation due to image
% noise "F_sigma", the standard deviation of the noise-free
% image "sigma_A", the standard deviation of the image
% noise "sigma_n" and the signal-to-noise ratio "SNR" ( = sigma_A/sigma_n)
%
% Pseudo Code: 
% 
% - computer normalized auto-correlation function
% - select radius for fit function
% - exclude center peak
% - apply Gaussian 2D fit to extract F_sigma
% - compute SNR, sigma_A and sigma_n

R = normxcorr2_general(A,A);

[xi,psi] = meshgrid(-size(A,2)+1:size(A,2)-1,...
    -size(A,1)+1:size(A,1)-1);
fit_radius = 8;
a = find(abs(xi)<=fit_radius & ...
    abs(psi)<=fit_radius & ~(xi == 0 & psi == 0));

ft = fittype('F_s*exp( - ((xi/D)^2 + (psi/D)^2)*4)',...
    'indep',{'xi','psi'},'depend','z');

opts = fitoptions (ft);
opts.MaxFunEvals = 1000;
opts.MaxIter = 1000;
opts.Tolx = 1e-8;
opts.Lower =      [0            0];
opts.Upper =      [2*fit_radius 2];
opts.StartPoint = [3            1];
fitresult = fit( [xi(a) psi(a)], R(a), ft, opts);

F_sigma = min(1,fitresult.F_s);
SNR = (1/F_sigma-1)^(-0.5);
sigma_A = std(double(A(:)))*sqrt(F_sigma);
sigma_n = std(double(A(:)))*sqrt(1-F_sigma);

