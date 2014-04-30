t_plot = 282;
t = t_plot/deltim;

xstep = dx(2) - dx(1);
xstart = xstep/2;
xend = dx(end) - xstart;
xvec = [xstart:xstep:xend];
xvec = xvec/dx(end);

% plot(xvec,Sstore(:,t),'LineWidth',2);
% grid on;
% xlabel('Dimensionless Position x_D');
% ylabel('Saturation S_1');
% title('Saturation Profile at Water Breakthrough');

f = [];
for i = 1:nx
    a1 = relperm1(Sstore(i,t))/mu1;
    a2 = relperm2(1-Sstore(i,t))/mu2;
    f = [f a1/(a1+a2)];
end

plot(Sstore(:,t),f,'LineWidth',2);
grid on;
xlabel('Saturation S_1');
xlim([0 1]);
ylabel('Fractional Flow f_1');
title('Fractional Flow Curve at Water Breakthrough');