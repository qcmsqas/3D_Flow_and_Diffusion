function flowStep2(dt,dx)
    global P vx vy vz pm uzOutC;
    [nx,ny,nz]=size(P);
    nxy=nx*ny;
    rro=(vx(2:end,2:end,1:end)-vx(1:end-1,2:end,1:end)+vy(1:end,2:end,1:end)-vy(1:end,1:end-1,1:end)+vz(1:end,2:end,2:end)-vz(1:end,2:end,1:end-1))*dt*dx;
    rro(:,:,end)=rro(:,:,end).*(1-uzOutC(:,2:end));%+uzOutC(:,2:end);
    RRO=zeros(nx*ny*nz,1);
    for i=1:nx
        for j=1:ny
            for k=1:nz
                RRO(1+(i-1)+(j-1)*nx+(k-1)*nxy)=rro(i,j,k);
            end
        end
    end
    PP=pm*RRO;
    for i=1:nx
        for j=1:ny
            for k=1:nz
                P(i,j,k)=PP(1+(i-1)+(j-1)*nx+(k-1)*nxy);
            end
        end
    end
end