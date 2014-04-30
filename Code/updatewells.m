function [ welldata,curschedule ] = updatewells( scheduletime,schedulebook,curschedule,curtim,raw_data,welldata,numwells,Q1well,Q2well )
%SCHEDULER schedule handler
[~,nc]=size(scheduletime);
for i=1:nc
    elt = scheduletime(i);
    if curtim==elt
        wellid = schedulebook(i);
        curschedule(i) = curschedule(i)+1;
        welliter = curschedule(i);
        temp_ind = 18 + (welliter-1)*6;
        welldata(5:9,wellid)=raw_data(temp_ind:temp_ind+4,wellid);
    end
end

for i = 1:numwells
    if welldata(10,i)==-1
        continue;
    end
    Q1 = Q1well(i);
    Q2 = Q2well(i);
    if Q1/(Q1+Q2)>=welldata(10,i)
        disp('Updating Well! Watercut = ');
        Q1/(Q1+Q2)
        curtim
        welldata(5:9,i) = welldata(11:15,i);
    end
end
end
