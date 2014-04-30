function [ kr1 ] = relperm1( S1 )
%RELPERM1 
x = S1;
p1 =       4.615;
p2 =      -11.25;
p3 =       11.34;
p4 =      -5.231;
p5 =       1.165;
p6 =    -0.09912;
kr1 = p1*x^5 + p2*x^4 + p3*x^3 + p4*x^2 + p5*x + p6;
if x<=0.2
    kr1 = 0;
end
if x>=0.8
    kr1 = 0.2;
end
return;
end

