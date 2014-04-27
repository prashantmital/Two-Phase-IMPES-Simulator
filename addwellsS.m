function [ S ] = addwellsS( S,welldata,numwells,deltim,nx,ny,S0,P0,mu1,dx,dy,phi )
%ADDWELLS adds well data to matrices A and B 

for i=1:numwells
    iwell = welldata(1,i);
    jwell = welldata(2,i);
    position = index(iwell,jwell,nx,ny);
    vol = (dx(iwell+1)-dx(iwell))*(dy(jwell+1)-dy(jwell))*phi*hij(iwell,jwell);
    if (welldata(6,i)==1)
        S(position,1)=S(position,1)+welldata(5,i)*deltim*welldata(7,i)/vol;
    end
    if (welldata(6,i)==-1)
        rel_mob1 = relperm1(S0(position))/mu1;
        S(position,1)=S(position,1)+deltim*welldata(16,i)*(welldata(15,i)-P0(position))*rel_mob1/vol;
    end
end

end

