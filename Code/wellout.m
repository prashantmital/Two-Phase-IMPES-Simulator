function [ Q1well,Q2well,Pwf ] = wellout( Q1well,Q2well,Pwf,welldata,numwells,S0,P0,mu1,mu2,nx,ny )
%WELLOUT Generates well outputs

Q1add = zeros(1,numwells);
Q2add = zeros(1,numwells);
Pwfadd = zeros(1,numwells);

for i = 1:numwells
    iwell = welldata(1,i);
    jwell = welldata(2,i);
    pos = index(iwell,jwell,nx,ny);
    relmob1 = relperm1(S0(pos))/mu1;
    relmob2 = relperm2(1-S0(pos))/mu2;
    P1 = P0(pos);
    P2 = P1 + cpress(S0(pos));
    if welldata(6,i)==1
        Q1 = welldata(5,i)*welldata(7,i);
        Q2 = welldata(5,i)*welldata(8,i);
        Pw = Q1/(welldata(16,i)*relmob1)+P1;
    end
    if welldata(6,i)==-1
        Pw = welldata(9,i);
        Q1 = welldata(16,i)*relmob1*(Pw-P1);
        Q2 = welldata(16,i)*relmob2*(Pw-P2);
    end
    Q1add(i) = Q1;
    Q2add(i) = Q2;
    Pwfadd(i) = Pw;
end

Q1well = [Q1well;Q1add];
Q2well = [Q2well;Q2add];
Pwf = [Pwf;Pwfadd];

return;

end

