%----INPUT SPECIFICATION

%Script to read Basic Inputs

%------------------------------------------------
%Porosity, Kx, Ky, Height are input as functions
%------------------------------------------------

disp('inputfile.m executed!');

inp_data = xlsread('./datainput.xlsx','BasicInput');

% Mesh Parameters
dx = [];
for i = 1:inp_data(1,1)
    dx = [dx inp_data(1,(i-1)*3+2):inp_data(1,(i-1)*3+3):inp_data(1,(i-1)*3+4)];
end
[~,nx] = size(dx);
nx = nx-1;

dy = [];
for i = 1:inp_data(2,1)
    dy = [dy inp_data(2,(i-1)*3+2):inp_data(2,(i-1)*3+3):inp_data(2,(i-1)*3+4)];
end
[~,ny] = size(dy);
ny = ny-1;

% Physical Parameters
phi = inp_data(6,1);
mu1 = inp_data(7,1)*10^(-9)/(3600*24);
mu2 = inp_data(8,1)*10^(-9)/(3600*24);
c1 = inp_data(9,1)*10^(-3);
c2 = inp_data(10,1)*10^(-3);
ct = inp_data(11,1)*10^(-3);
spwt1 = inp_data(16,1)*10^(-6);
spwt2 = inp_data(17,1)*10^(-6);

% Time Stepping Parameters
endtim = inp_data(13,1);
deltim = inp_data(14,1);

% Initial Conditions
P0 = inp_data(19,1);
S0 = inp_data(20,1);

%Inactive Cells Module
inactive_cells = xlsread('./datainput.xlsx','InactiveCells');
