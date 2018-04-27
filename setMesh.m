function setMesh(xmin,ymin,zmin,xmax,ymax,zmax,dx)
    global x y z P ux uy uz;
    x=xmin:dx:xmax;
    y=ymin:dx:ymax/2;
    z=zmin:dx:zmax;
    P=zeros(size(x,2),size(y,2),size(z,2));
    ux=zeros(size(x,2)+1,size(y,2)+1,size(z,2));
    uy=zeros(size(x,2),size(y,2)+1,size(z,2));
    uz=zeros(size(x,2),size(y,2)+1,size(z,2)+1);

end