function [ cell ] = getdata( i,j,dx,nx,dy,ny,sat,pos,c_disc,ct,mu1,mu2,deltim,Pij,spwt1,spwt2,phi )
%GETDATA This function accepts an i,j coordinate and returns
%           an array with 6 entries (5 for matrix A and 1 for B).
%           If the cell is at a boundary the corresponding return value is
%           0 and no special treatment is necessary in the calling
%           function. Function returns -1 if current cell is deactivated.

%if (i,j) is inactive return -1
if ismember(pos(1),c_disc)==1
    cell=-1;
    return
end

%--------------------------------------------------------------------------
% RELATIVE MOBILITIES AND UPWINDING
%--------------------------------------------------------------------------

%rel_mob construction defines how the scheme is upwinded for pressure eq
rel_mob1=[];
rel_mob2=[];

%Scheme 1: All interfaces use i,j values. No Weighting.
% a1=relperm1(sat(1))/mu1;
% a2=relperm2(1-sat(1))/mu2;
% rel_mob1=a1*ones(1,4);
% rel_mob2=a2*ones(1,4);

%DEFUNCT--Scheme 2: Mid point weighting of total mobility
% a1=relperm1(sat(1))/mu1 + relperm2(1-sat(1))/mu2;
% a2=relperm1(sat(2))/mu1 + relperm2(1-sat(2))/mu2;
% a3=relperm1(sat(3))/mu1 + relperm2(1-sat(3))/mu2;
% a4=relperm1(sat(4))/mu1 + relperm2(1-sat(4))/mu2;
% a5=relperm1(sat(5))/mu1 + relperm2(1-sat(5))/mu2;
% rel_mob = [2*a1*a2/(a1+a2) 2*a1*a3/(a1+a3)...
%     2*a1*a4/(a1+a4) 2*a1*a5/(a1+a5)];

%Scheme 3: Mid point weighting of each mobility and then total
a1=relperm1(sat(1))/mu1;
a2=relperm1(sat(2))/mu1;
a3=relperm1(sat(3))/mu1;
a4=relperm1(sat(4))/mu1;
a5=relperm1(sat(5))/mu1;
rel_mob1 = [2*a1*a2/(a1+a2) 2*a1*a3/(a1+a3)... 
    2*a1*a4/(a1+a4) 2*a1*a5/(a1+a5)];
a1=relperm2(1-sat(1))/mu2;
a2=relperm2(1-sat(2))/mu2;
a3=relperm2(1-sat(3))/mu2;
a4=relperm2(1-sat(4))/mu2;
a5=relperm2(1-sat(5))/mu2;
rel_mob2 = [2*a1*a2/(a1+a2) 2*a1*a3/(a1+a3)... 
    2*a1*a4/(a1+a4) 2*a1*a5/(a1+a5)];

%Deal with divide by zero
rel_mob1(isnan(rel_mob1))=0;
rel_mob2(isnan(rel_mob2))=0;
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
% CALCULATE COEFFICIENTS
%--------------------------------------------------------------------------
cell = zeros(1,6);
%Ti,j
vol = (dx(i+1)-dx(i))*(dy(j+1)-dy(j))*phi*hij(i,j);
cell(1) = vol*ct;
for k = 1:4
    cell(1) = cell(1) + deltim*(rel_mob1(k)+rel_mob2(k))*trans(k);
end
%Ti+1,j
cell(2) = -deltim*(rel_mob1(1)+rel_mob2(1))*trans(1);    
%Ti,j+1
cell(3) = -deltim*(rel_mob1(2)+rel_mob2(2))*trans(2);
%Ti-1,j
cell(4) = -deltim*(rel_mob1(3)+rel_mob2(3))*trans(3);
%Ti,j-1
cell(5) = -deltim*(rel_mob1(4)+rel_mob2(4))*trans(4);

%--------------------------------------------------------------------------
% CALCULATE FORCING FUNCTION
%--------------------------------------------------------------------------
b = ct*vol*Pij;
%construct capillary pressure vector
Pc = [cpress(sat(1)) cpress(sat(2)) cpress(sat(3))...
    cpress(sat(4)) cpress(sat(5))];
%construct depth vector
D = [depth(i,j) depth(i+1,j) depth(i,j+1) depth(i-1,j) depth(i,j-1)];
%add Pc terms
b = b + deltim*(Pc(2)-Pc(1))*rel_mob2(1)*trans(1) ...
    + deltim*(Pc(3)-Pc(1))*rel_mob2(2)*trans(2) ...
    + deltim*(Pc(4)-Pc(1))*rel_mob2(3)*trans(3) ...
    + deltim*(Pc(5)-Pc(1))*rel_mob2(4)*trans(4);
%add depth terms
temp = (D(2)-D(1))*trans(1)*(spwt1*rel_mob1(1)+spwt2*rel_mob2(1))...
    + (D(3)-D(1))*trans(2)*(spwt1*rel_mob1(2)+spwt2*rel_mob2(2))...
    + (D(4)-D(1))*trans(3)*(spwt1*rel_mob1(3)+spwt2*rel_mob2(3))...
    + (D(5)-D(1))*trans(4)*(spwt1*rel_mob1(4)+spwt2*rel_mob2(4));
b = b - deltim*temp;
cell(6) = b;


return;
end

