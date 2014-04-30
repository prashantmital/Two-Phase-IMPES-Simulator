function [ Sn ] = satstep( i,j,nx,ny,dx,dy,sat,pwat,pos,c_disc,ctot,c2,mu1,deltim,S0,p0,spwt1,phi )
%SATSTEP This function takes one saturation step for the (i,j) cell
%Add well rates in this module

%--------------------------------------------------------------------------
% FUNCTION TO CALCULATE POTENTIAL
%--------------------------------------------------------------------------
pot = @(p1,p0,d1,d0,spwt1) (p1-p0)-spwt1*(d1-d0);

%Return illegal sat value if (i,j) is inactive
if ismember(pos(1),c_disc)==1
    Sn=-1;
    return
end

%--------------------------------------------------------------------------
% TRANSMISSIBILITIES
%--------------------------------------------------------------------------
a1=transx(i,j,dx,dy);
a2=transx(i+1,j,dx,dy);
a3=transx(i-1,j,dx,dy);
trans = [2*a1*a2/(a1+a2) 0 2*a1*a3/(a1+a3) 0];
a1=transy(i,j,dx,dy);
a2=transy(i,j+1,dx,dy);
a3=transy(i,j-1,dx,dy);
trans(2) = 2*a1*a2/(a1+a2);
trans(4) = 2*a1*a3/(a1+a3);

%--------------------------------------------------------------------------
% HANDLE INACTIVE CELLS AND BOUNDARY CELLS
%--------------------------------------------------------------------------
%Checking cell (i+1,j)
if ismember(pos(2),c_disc) || i==nx
    trans(1) = 0;
end
%Checking cell (i,j+1)
if ismember(pos(3),c_disc) || j==ny
    trans(2) = 0;
end
%Checking cell (i-1,j)
if ismember(pos(4),c_disc) || i==1
    trans(3) = 0;
end
%Checking cell (i,j-1)
if ismember(pos(5),c_disc) || j==1
    trans(4) = 0;
end

%--------------------------------------------------------------------------
% UPWINDING OF RELATIVE MOBILITY
%--------------------------------------------------------------------------
%Calculation of cell relative mobility
a1=relperm1(sat(1))/mu1;
a2=relperm1(sat(2))/mu1;
a3=relperm1(sat(3))/mu1;
a4=relperm1(sat(4))/mu1;
a5=relperm1(sat(5))/mu1;
a = [a1 a2 a3 a4 a5];

%Determination of upwind direction
upwind = [ 0 0 0 0 ];

%Construct depth vector
D = [depth(i,j) depth(i+1,j) depth(i,j+1) depth(i-1,j) depth(i,j-1)];

%Construct potential and upwinding vectors
potentials = [ 0 0 0 0 ];
for k=1:4
    temp = pot(pwat(k+1),pwat(1),D(k+1),D(1),spwt1);
    if temp<=0
        upwind(k) = 1;
    end
    potentials(k) = temp;
end

%--------------------------------------------------------------------------
% COMPUTE NEW SATURATION
%--------------------------------------------------------------------------
term3 = 0;
for k=1:4
    term3 = term3 + (a(1)*(upwind(k))+a(k+1)*(1-upwind(k)))*trans(k)*potentials(k);
end
vol = (dx(i+1)-dx(i))*(dy(j+1)-dy(j))*phi*hij(i,j);

Sn = S0 + deltim*term3/vol - (ctot-c2)*(pwat(1)-p0)*S0;
%Add well data
return;
end

