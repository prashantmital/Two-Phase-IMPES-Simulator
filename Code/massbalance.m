function [ massbal ] = massbalance( massbal,S0,S1,P0,P1,curtim,deltim,c_disc,dx,dy,nx,ny,ct,c1,c2,welldata,Q1well,Q2well,numwells,phi )
%MASSBALANCE Calculate and print global mass balance

oil_lhs = 0;
wat_lhs = 0;
for i = 1:nx
    for j = 1:ny
        pos = index(i,j,nx,ny);
        if ismember(pos,c_disc)==1
            continue;
        end
        S0ij = S0(pos);
        S1ij = S1(pos);
        P0ij = P0(pos);
        P1ij = P1(pos);
        wat_lhs = wat_lhs + S1ij - S0ij + (ct-c2)*(P1ij - P0ij)*S0ij;
        oil_lhs = oil_lhs + S0ij - S1ij + (ct-c1)*(P1ij + cpress(S1ij) - P0ij - cpress(S0ij))*(1-S0ij);
    end
end

oil_rhs = 0;
wat_rhs = 0;
for i = 1:numwells
    iwell = welldata(1,i);
    jwell = welldata(2,i);
    vol = (dx(iwell+1)-dx(iwell))*(dy(jwell+1)-dy(jwell))*phi*hij(iwell,jwell);
    wat_rhs = wat_rhs+deltim*Q1well(i)/vol;
    oil_rhs = oil_rhs+deltim*Q2well(i)/vol;
end

massbal = [massbal ; curtim wat_lhs-wat_rhs oil_lhs-oil_rhs];

return;

end

