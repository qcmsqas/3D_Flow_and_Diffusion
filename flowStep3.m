function flowStep3(dt,dx)
    global ux uy uz vx vy vz P uzOut uzOutIs uzIn uzInIs;
    ux(2:end-1,2:end-1,2:end-1)=vx(2:end-1,2:end-1,2:end-1)+dt*(P(1:end-1,1:end-1,2:end-1)-P(2:end,1:end-1,2:end-1))/dx;
    uy(2:end-1,2:end-1,2:end-1)=vy(2:end-1,2:end-1,2:end-1)+dt*(P(2:end-1,1:end-1,2:end-1)-P(2:end-1,2:end,2:end-1))/dx;
    uz(2:end-1,2:end-1,2:end-1)=vz(2:end-1,2:end-1,2:end-1)+dt*(P(2:end-1,1:end-1,1:end-1)-P(2:end-1,1:end-1,2:end))/dx;
    ux(1,:,:)=-ux(2,:,:);
    ux(end,:,:)=-ux(end-1,:,:);
    ux(:,1,:)=ux(:,3,:);
    uy(:,1,:)=-uy(:,2,:);
    uy(:,end,:)=-uy(:,end-1,:);
    uz(:,:,1)=-uz(:,:,2);
    uz(:,:,end)=-uz(:,:,end-1);
    uz(:,1,:)=uz(:,3,:);

    
    uz(:,:,end)=uz(:,:,end).*(1-uzOutIs)+uzOut;
    uz(:,:,end)=uz(:,:,end).*(1-uzInIs)+uzIn;
    uz(:,:,end-1)=uz(:,:,end-1).*(1-uzOutIs)+uzOut;
    uz(:,:,end-1)=uz(:,:,end-1).*(1-uzInIs)+uzIn;

end