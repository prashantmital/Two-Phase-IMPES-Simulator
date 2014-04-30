function [ pos ] = index( i,j,nx,ny )
%INDEX Returns the matrix location of (i,j) cell
pos = i+(j-1)*nx;

if pos<1 || pos>nx*ny
    pos = 1; %ensures that function always returns a valid matrix index
end

return;
end

