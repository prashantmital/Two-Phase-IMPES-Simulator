%----------------
% INPUT
%----------------
disp('readwells.m executed!');
%Gamma
gam = 1.781;

%Dietz Shape Factor
dief = 31.62;

%Script to read the well data
raw_data = xlsread('./datainput.xlsx','WellInput');

%----------------------------
% NO INPUTS BEYOND THIS POINT
%----------------------------

[~,numwells] = size(raw_data);

welldata = raw_data(1:16,:); %Well Data at time t=0 days

wellindex = [1:numwells]; %Keep track of wells

%Calculating Productivity Indices
for i = 1:numwells
    welldata(1,i)
    welldata(2,i)
    hiwell = hij(welldata(1,i),welldata(2,i));
    kxwell = kx(welldata(1,i),welldata(2,i));
    kywell = ky(welldata(1,i),welldata(2,i));
    Aijwell = (dx(welldata(1,i)+1)-dx(welldata(1,i)))*(dy(welldata(2,i)+1)-dy(welldata(2,i)));
    bradwell = welldata(3,i);
    sfactorwell = welldata(4,i);
    temp1 = 2*pi*sqrt(kxwell*kywell)*hiwell;
    temp2 = 0.5*log(4*Aijwell/(gam*dief*bradwell^2))+0.25+sfactorwell;
    welldata(16,i) = temp1/temp2;
end

%Bookkeeping for Scheduling Tasks
schedulebook = []; %Well associated with each schedule change
scheduletime = []; %Time at which schedule changes
productivity_index = [];

for i=1:numwells
    
    for j=1:raw_data(16,i)
        scheduletime = [scheduletime,raw_data(17+(j-1)*6,i)];
        schedulebook = [schedulebook,i];
    end
end

curschedule = zeros(1,numwells); %Number of schedule updates per well



