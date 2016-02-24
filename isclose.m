function out = isclose(a,b)
% isclose complements isequal 
% for tests with assert in the case
% where the differences are very small
% 

EPS = 1e-6;

out = abs(a-b) < EPS;