function [ Pc ] = cpress( S1 )
%CPRESS Returns the capillary pressure (least dense-most dense)
psi_to_mpa = 6894.7573*10^-6;

x = S1;
p1 =       -1490;  
p2 =        4190; 
p3 =       -4621;
p4 =        2509;
p5 =      -679.8;
p6 =       76.27;
Pc = p1*x^5 + p2*x^4 + p3*x^3 + p4*x^2 + p5*x + p6;
if x>=0.8
    Pc = 0;
end
if x <=0.2
    Pc = 10;
end
Pc = psi_to_mpa*Pc;

return;
end

