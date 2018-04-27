function [n]=calPosi(x,y,z,nx,ny)
    n=x+y*nx+z*ny*nx;
end