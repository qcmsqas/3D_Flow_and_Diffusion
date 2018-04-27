function stableStep1(dt,dx,bb)
    global P ux uy uz;
    P=P-bb*dt*(ux(2:end,2:end,1:end)-ux(1:end-1,2:end,1:end)+uy(:,2:end,:)-uy(:,1:end-1,:)+uz(:,2:end,2:end)-uz(:,2:end,1:end-1))/dx;
    
    
    
end