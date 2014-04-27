function [ tr ] = transy( i,j,dx,dy )
%TRANS Calculates the geometric transmissibility term for a cell
[~,xmax] = size(dx);
[~,ymax] = size(dy);
delta_x = dx(1);
delta_y = dy(1);
if i~=0 && i~=xmax
    delta_x = dx(i+1)-dx(i);
end
if j~=0 && j~=ymax
    delta_y = dy(j+1)-dy(j);
end
tr = ky(i,j)*delta_x*hij(i,j)/delta_y;
return;
end

