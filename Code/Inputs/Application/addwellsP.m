function [ A,B ] = addwellsP( A,B,welldata,numwells,deltim,nx,ny,S0,mu1,mu2 )
%ADDWELLS adds well data to matrices A and B 
for i=1:numwells
    position = index(welldata(1,i),welldata(2,i),nx,ny);
    if (welldata(6,i)==1)
        B(position,1)=B(position,1)+welldata(5,i)*deltim*(welldata(7,i)+welldata(8,i));
    end
    if (welldata(6,i)==-1)
        rel_mob1 = relperm1(S0(position))/mu1;
        rel_mob2 = relperm2(1-S0(position))/mu2;
        A(position,position)=A(position,position)+deltim*welldata(16,i)*rel_mob1;
        B(position,1)=B(position,1)+deltim*welldata(16,i)*welldata(9,i)*rel_mob1;
        A(position,position)=A(position,position)+deltim*welldata(16,i)*rel_mob2;
        B(position,1)=B(position,1)+deltim*welldata(16,i)*(welldata(9,i)-cpress(S0(position)))*rel_mob2;
    end
end

end

