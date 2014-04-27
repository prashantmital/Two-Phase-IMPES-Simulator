function [ x,y ] = locxy( i,j,dx,dy )
%LOCXY Returns the cell center location of cell (i,j)
x = dx(i)+(dx(i+1)-dx(i))/2;
y = dy(j)+(dy(j+1)-dy(j))/2;
return;
end

