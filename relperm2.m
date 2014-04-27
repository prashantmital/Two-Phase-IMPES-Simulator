function [ kr2 ] = relperm2( S2 )
%RELPERM2 
kr0 = 0.8;
S1r = 0.2;
S2r = 0.3;
n = 2;
kr2 = kr0*((S2-S2r)/(1-S1r-S2r))^n;

end

