%------------------
% VISUALIZE
% The Data Visualization Module
%------------------

% IMPORTANT
%------------------
% These scripts only work if driver.m has already completed execution
% Please mark your modifications in this script clearly for easy use later
% Use Right-Click --> Comment to enable disable segments of the code
% Please add to the code capabilties section to keep track of changes

% CODE CAPABILITIES
%------------------
% 1. Plot Bottomhole Pressures vs Time
% 2. Plot Well Flow Rates vs Time
% 3. Plot Contours of Pressure at a particular Time



timestrand = [0:deltim:endtim];

%--------------------------------------------------------------------------
% Saturation Profile at Time t_plot
%--------------------------------------------------------------------------
% t_plot = 


%--------------------------------------------------------------------------
% Bottom Hole Pressure Profiles With Time
%--------------------------------------------------------------------------
% wellid = 2; % Well ID of well for which plot is desired
% plotdata = Pwf(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Bottomhole Pressure [MPa]');
% leg1 = strcat('Well# -',int2str(wellid));
% l1=legend(leg1);
% title('Bottomhole Pressure vs Time');
% hold all;
% % 
% wellid = 4; % Well ID of well for which plot is desired
% plotdata = Pwf(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Bottomhole Pressure [MPa]');
% leg2 = strcat('Well# -',int2str(wellid));
% legend(leg1,leg2);
% hold all;
% 
% wellid = 7; % Well ID of well for which plot is desired
% plotdata = Pwf(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Bottomhole Pressure [MPa]');
% leg3 = strcat('Well# -',int2str(wellid));
% legend(leg1,leg2,leg3);
% hold off;

%--------------------------------------------------------------------------
% Well Flow Rate [Water] With Time
%--------------------------------------------------------------------------
wellid = 2; % Well ID of well for which plot is desired
plotdata = (Q1well(:,wellid));
plot(timestrand,plotdata,'LineWidth',2);
grid on;
xlabel('Time [days]');
ylabel('Well Flow Rate [m^3/day]');
leg1 = strcat('Well# -',int2str(wellid));
l1=legend(leg1);
hold all;
% 
% wellid = 10; % Well ID of well for which plot is desired
% plotdata = Q1well(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Well Flow Rate [m^3/day]');
% leg2 = strcat('Well# -',int2str(wellid));
% legend(leg1,leg2);
% hold all;
%  
% wellid = 2; % Well ID of well for which plot is desired
% plotdata = Q1well(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Well Flow Rate [m^3/day]');
% title('Well Flow Rate vs Time');
% leg3 = strcat('Well# -',int2str(wellid));
% legend(leg1,leg2,leg3);
% hold off;

%--------------------------------------------------------------------------
% Well Flow Rate [Oil] With Time
% %--------------------------------------------------------------------------
% wellid = 2; % Well ID of well for which plot is desired
% plotdata = Q2well(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Well Flow Rate [m^3/day]');
% leg1 = strcat('Well# -',int2str(wellid));
% l1=legend(leg1);
% hold all;
% 
% wellid = 10; % Well ID of well for which plot is desired
% plotdata = Q2well(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Well Flow Rate [m^3/day]');
% leg2 = strcat('Well# -',int2str(wellid));
% legend(leg1,leg2);
% hold all;
%  
% wellid = 2; % Well ID of well for which plot is desired
% plotdata = Q2well(:,wellid);
% plot(timestrand,plotdata,'LineWidth',2);
% grid on;
% xlabel('Time [days]');
% ylabel('Well Flow Rate [m^3/day]');
% title('Well Flow Rate vs Time');
% leg3 = strcat('Well# -',int2str(wellid));
% legend(leg1,leg2,leg3);
% hold off;

%--------------------------------------------------------------------------
% Pressure Contours and Heat Map at a Particular Time
%--------------------------------------------------------------------------
% plottime = 2; %Select time step at which to plot pressure contours
% tstep = floor(plottime/deltim);
% X = [dx/2:dx:xdim-dx/2];
% Y = [dy/2:dy:ydim-dy/2];
% plotdata = reshape(Psim(tstep,:),nx,ny);
% plotdata(plotdata==-9999) = NaN;
% contourf(Y,X,plotdata,12,'LineWidth',1);
% xlabel('Domain X-dimension');
% ylabel('Domain Y-dimension');
% tempstring = 'Contour Map of Pressure [MPa] at time=';
% tempstring2 = 'days';
% tempstring = strcat(tempstring,num2str(plottime),tempstring2);
% title(tempstring);
% colormap jet;
% colorbar('location','southoutside');