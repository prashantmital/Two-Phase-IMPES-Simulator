function [ kr1 ] = relperm1( S1 )
%RELPERM1 
kr0 = 0.2;
S1r = 0.2;
S2r = 0.3;
n = 2;
kr1 = kr0*((S1-S1r)/(1-S1r-S2r))^n;
end

