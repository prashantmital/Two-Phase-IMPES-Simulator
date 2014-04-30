%--------------------------------------------------------------------------
%   FUNCTION DEFINITIONS
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
%   INPUTS
%       Lengths [m], Pressures [MPa]
%--------------------------------------------------------------------------
%Read inputs
inputfile
%Read well data
readwells

%--------------------------------------------------------------------------
%   PROCESS INPUTS
%--------------------------------------------------------------------------
%Generate Initial Matrices
P0 = P0*ones(nx*ny,1); %initial pressure
S0 = S0*ones(nx*ny,1); %initial saturation
%loop to convert inactive cell input to a 1-D array of matrix indices
[n_inactive,~]=size(inactive_cells);
c_disc = [];
for i=1:n_inactive
    c_disc = [c_disc index(inactive_cells(i,1),...
        inactive_cells(i,2),nx,ny)];
end

Pstore = [];
Sstore = [];
Q1well = [];
Q2well = [];
Pwf = [];
massbal = [];

for curtim = deltim:deltim:endtim
    Pstore = [Pstore P0];
    Sstore = [Sstore S0];
    %----------------------------------------------------------------------
    %   ASSEMBLING MATRICES
    %----------------------------------------------------------------------
    A = zeros(nx*ny,nx*ny);
    B = zeros(nx*ny,1);
    for i=1:nx
        for j=1:ny
            pos = [index(i,j,nx,ny) index(i+1,j,nx,ny) ...
                index(i,j+1,nx,ny) index(i-1,j,nx,ny) index(i,j-1,nx,ny)];
            sat = [S0(pos(1)) S0(pos(2)) S0(pos(3)) S0(pos(4)) S0(pos(5))]; %construct saturations vector

            cell = getdata(i,j,dx,nx,dy,ny,sat,pos,c_disc,ct,mu1,mu2,deltim,P0(pos(1)),spwt1,spwt2,phi);

            if cell==-1
                A(pos(1),pos(1))=1;
                B(pos(1),1)=99999; %junk pressure value to identify inactive cell
                continue;
            end
            
            for k = 1:5
                if cell(k)~=0
                    A(pos(1),pos(k)) = cell(k);
                end
            end
            B(pos(1),1) = cell(6);
        end
    end
    %Add well data to the matrix
    [ A,B ] = addwellsP( A,B,welldata,numwells,deltim,nx,ny,S0,mu1,mu2 );
    P1 = A\B; %Direct solve the matrix equation
    %Store the solution here or at the previous comment
    S1 = ones(nx*ny,1);
    for i=1:nx
        for j=1:ny
            pos = [index(i,j,nx,ny) index(i+1,j,nx,ny) ...
                index(i,j+1,nx,ny) index(i-1,j,nx,ny) index(i,j-1,nx,ny)];
            pwat = [P1(pos(1)) P1(pos(2)) P1(pos(3)) P1(pos(4)) P1(pos(5))];
            sat = [S0(pos(1)) S0(pos(2)) S0(pos(3)) S0(pos(4)) S0(pos(5))];
            S1(pos(1)) = satstep(i,j,nx,ny,dx,dy,sat,pwat,pos,c_disc,ct,c2,mu1,deltim,S0(pos(1)),P0(pos(1)),spwt1,phi);
        end
    end
    [ S1 ] = addwellsS( S1,welldata,numwells,deltim,nx,ny,S0,P1,mu1,dx,dy,phi );
    %Generate well outputs Pwf,Q1,Q2
    [ Q1well,Q2well,Pwf ] = wellout( Q1well,Q2well,Pwf,welldata,numwells,S1,P1,mu1,mu2,nx,ny );
    %Global Mass Balance
    [ massbal ] = massbalance( massbal,S0,S1,P0,P1,curtim,deltim,c_disc,dx,dy,nx,ny,ct,c1,c2,welldata,Q1well(end,:),Q2well(end,:),numwells,phi );
    P0 = P1;
    S0 = S1;
    %Check watercut and update well data
    [ welldata,curschedule ] = updatewells( scheduletime,schedulebook,curschedule,curtim,raw_data,welldata,numwells,Q1well(end,:),Q2well(end,:) );
    disp(curtim)
end

[ Q1well,Q2well,Pwf ] = wellout( Q1well,Q2well,Pwf,welldata,numwells,S0,P0,mu1,mu2,nx,ny );        