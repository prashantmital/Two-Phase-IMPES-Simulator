function [ kr2 ] = relperm2( S2 )
%RELPERM2 
x = S2;
p1 =       155.2;
p2 =      -344.6;
p3 =       296.1;
p4 =      -121.6;
p5 =       23.83;
p6 =      -1.775;
kr2 = p1*x^5 + p2*x^4 + p3*x^3 + p4*x^2 + p5*x + p6;
if x>=0.8
    kr2 = 0.8;
end
if x<=0.2
    kr2 = 0;
end
return;
end

