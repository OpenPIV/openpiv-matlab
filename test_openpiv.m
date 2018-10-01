% test of openpiv command line
% read two images
a = openpiv_imread('test1','exp1_001_b.bmp');
b = openpiv_imread('test1','exp1_001_c.bmp');

% run the OpenPIV
[x,y,u,v] = openpiv(a,b);

% plot the result
figure;
imshow(a)
hold on
quiver(x,y,u,v,'r');