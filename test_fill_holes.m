function test_fill_holes
% test of fill_holes function


vector = ones(5,5) + 1i*ones(5,5);
vector(3,3) = 0 + 1i*0;
tmp = fill_holes(vector);
assert(isclose(tmp(3,3), 1+1i));



vector = zeros(5,5) + 1i*zeros(5,5);
vector(1,2) = 1;
vector(2,3) = 1;
vector(5,5) = 1;
vector(3,4) = 1;
tmp = fill_holes(vector);
assert(all(tmp(:)));