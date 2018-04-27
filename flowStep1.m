function flowStep1(ro,mmEG,mmNA,CsEG,dt,dx)
    global cEG ux uy uz uzOutIs uzInIs uzIn uzOut;
    global vx vy vz;
    %先计算mu分布
    %mu=mmNA+(mmEG-mmNA)*cEG/CsEG;
    mu=mmNA;
    
    
    uxadd=ux(2:end-1,2:end-1,2:end-1)*0;
    uxc=ux(2:end-1,2:end-1,2:end-1);
    uxdxux=uxc.*(ux(3:end,2:end-1,2:end-1)-ux(1:end-2,2:end-1,2:end-1))/(2*dx);
    uxadd=uxadd-uxdxux;
    clear uxdxux uxc;
    uyc=0.25*(uy(1:end-1,1:end-2,2:end-1)+uy(2:end,1:end-2,2:end-1)+uy(1:end-1,2:end-1,2:end-1)+uy(2:end,2:end-1,2:end-1));
    uydyux=uyc.*(ux(2:end-1,3:end,2:end-1)-ux(2:end-1,1:end-2,2:end-1))/(2*dx);
    uxadd=uxadd-uydyux;
    clear uyc uydyux;
    uzc=0.25*(uz(1:end-1,2:end-1,2:end-2)+uz(2:end,2:end-1,2:end-2)+uz(1:end-1,2:end-1,3:end-1)+uz(2:end,2:end-1,3:end-1));
    uzdzux=uzc.*(ux(2:end-1,2:end-1,3:end)-ux(2:end-1,2:end-1,1:end-2))/(2*dx);
    uxadd=uxadd-uzdzux;
    clear uzc uzdzux;
    
    %mux=(mu(2:end-2,2:end-2,3:end-2)+mu(3:end-1,2:end-2,3:end-2))/2;
    dxdxux=(ux(3:end,2:end-1,2:end-1)-2*ux(2:end-1,2:end-1,2:end-1)+ux(1:end-2,2:end-1,2:end-1))/(dx*dx);
    %uxadd=uxadd+mux.*dxdxux;
    uxadd=uxadd+mu*dxdxux;
    clear dxdxux;
    dydyux=(ux(2:end-1,3:end,2:end-1)-2*ux(2:end-1,2:end-1,2:end-1)+ux(2:end-1,1:end-2,2:end-1))/(dx*dx);
    %uxadd=uxadd+mux.*dydyux;
    uxadd=uxadd+mu*dydyux;
    clear dydyux;
    dzdzux=(ux(2:end-1,2:end-1,3:end)-2*ux(2:end-1,2:end-1,2:end-1)+ux(2:end-1,2:end-1,1:end-2))/(dx*dx);
    %uxadd=uxadd+mux.*dzdzux;
    uxadd=uxadd+mu*dzdzux;
    clear dzdzux mux;
    vx=ux;
    vx(2:end-1,2:end-1,2:end-1)=vx(2:end-1,2:end-1,2:end-1)+uxadd*dt;
    vx(1,:,:)=-vx(2,:,:);
    vx(end,:,:)=-vx(end-1,:,:);
    vx(:,1,:)=vx(:,3,:);
    clear uxadd;
    
    uyadd=uy(2:end-1,2:end-1,2:end-1)*0;
    uxc=0.25*(ux(2:end-2,2:end-1,2:end-1)+ux(2:end-2,3:end,2:end-1)+ux(3:end-1,2:end-1,2:end-1)+ux(3:end-1,3:end,2:end-1));
    uxdxuy=uxc.*(uy(3:end,2:end-1,2:end-1)-uy(1:end-2,2:end-1,2:end-1))/(2*dx);
    uyadd=uyadd-uxdxuy;
    clear uxdxuy uxc;
    uyc=uy(2:end-1,2:end-1,2:end-1);
    uydyuy=uyc.*(uy(2:end-1,3:end,2:end-1)-uy(2:end-1,1:end-2,2:end-1))/(2*dx);
    uyadd=uyadd-uydyuy;
    clear uyc uydyuy;
    uzc=0.25*(uz(2:end-1,2:end-1,3:end-1)+uz(2:end-1,3:end,3:end-1)+uz(2:end-1,2:end-1,2:end-2)+uz(2:end-1,3:end,2:end-2));
    uzdzuy=uzc.*(uy(2:end-1,2:end-1,3:end)-uy(2:end-1,2:end-1,1:end-2))/(2*dx);
    uyadd=uyadd-uzdzuy;
    clear uzc uzdzuy;
    
    %muy=(mu(3:end-2,2:end-2,3:end-2)+mu(3:end-2,3:end-1,3:end-2))/2;
    dxdxuy=(uy(3:end,2:end-1,2:end-1)-2*uy(2:end-1,2:end-1,2:end-1)+uy(1:end-2,2:end-1,2:end-1))/(dx*dx);
    %uyadd=uyadd+muy.*dxdxuy;
    uyadd=uyadd+mu*dxdxuy;
    clear dxdxuy;
    dydyuy=(uy(2:end-1,3:end,2:end-1)-2*uy(2:end-1,2:end-1,2:end-1)+uy(2:end-1,1:end-2,2:end-1))/(dx*dx);
    %uyadd=uyadd+muy.*dydyuy;
    uyadd=uyadd+mu*dydyuy;
    clear dydyuy;
    dzdzuy=(uy(2:end-1,2:end-1,3:end)-2*uy(2:end-1,2:end-1,2:end-1)+uy(2:end-1,2:end-1,1:end-2))/(dx*dx);
    %uyadd=uyadd+muy.*dzdzuy;
    uyadd=uyadd+mu*dzdzuy;
    clear dzdzuy muy;
    vy=uy;
    vy(2:end-1,2:end-1,2:end-1)=vy(2:end-1,2:end-1,2:end-1)+uyadd*dt;
    vy(:,1,:)=-vy(:,2,:);
    vy(:,end,:)=-vy(:,end-1,:);
    clear uyadd;
    
    
      
    uzadd=uz(2:end-1,2:end-1,2:end-1)*0;
    uxc=0.25*(ux(2:end-2,2:end-1,1:end-1)+ux(2:end-2,2:end-1,2:end)+ux(3:end-1,2:end-1,1:end-1)+ux(3:end-1,2:end-1,2:end));
    uxdxuz=uxc.*(uz(3:end,2:end-1,2:end-1)-uz(1:end-2,2:end-1,2:end-1))/(2*dx);
    uzadd=uzadd-uxdxuz;
    clear uxdxuz uxc;
    uyc=0.25*(uy(2:end-1,1:end-2,1:end-1)+uy(2:end-1,2:end-1,1:end-1)+uy(2:end-1,1:end-2,2:end)+uy(2:end-1,2:end-1,2:end));
    uydyuz=uyc.*(uz(2:end-1,3:end,2:end-1)-uz(2:end-1,1:end-2,2:end-1))/(2*dx);
    uzadd=uzadd-uydyuz;
    clear uyc uydyuz;
    uzc=uz(2:end-1,2:end-1,2:end-1);
    uzdzuz=uzc.*(uz(2:end-1,2:end-1,3:end)-uz(2:end-1,2:end-1,1:end-2))/(2*dx);
    uzadd=uzadd-uzdzuz;
    clear uzc uzdzuz;
    
    %muz=(mu(3:end-2,2:end-2,3:end-1)+mu(3:end-2,2:end-2,2:end-2))/2;
    dxdxuz=(uz(3:end,2:end-1,2:end-1)-2*uz(2:end-1,2:end-1,2:end-1)+uz(1:end-2,2:end-1,2:end-1))/(dx*dx);
    %uzadd=uzadd+muz.*dxdxuz;
    uzadd=uzadd+mu*dxdxuz;
    clear dxdxuy;
    dydyuz=(uz(2:end-1,3:end,2:end-1)-2*uz(2:end-1,2:end-1,2:end-1)+uz(2:end-1,1:end-2,2:end-1))/(dx*dx);
    %uzadd=uzadd+muz.*dydyuz;
    uzadd=uzadd+mu*dydyuz;
    clear dydyuy;
    dzdzuz=(uz(2:end-1,2:end-1,3:end)-2*uz(2:end-1,2:end-1,2:end-1)+uz(2:end-1,2:end-1,1:end-2))/(dx*dx);
    %uzadd=uzadd+muz.*dzdzuz;
    uzadd=uzadd+mu*dzdzuz;
    clear dzdzuy muz;
    vz=uz;
    vz(2:end-1,2:end-1,2:end-1)=vz(2:end-1,2:end-1,2:end-1)+uzadd*dt;
    vz(:,:,1)=-vz(:,:,2);
    vz(:,:,end)=-vz(:,:,end-1);
    vz(:,1,:)=vz(:,3,:);
    clear uzadd;  
    
    vz(:,:,end)=vz(:,:,end).*(1-uzOutIs)+uzOut;
    %vz(:,:,end-1)=vz(:,:,end-1).*(1-uzOutIs)+uzOut;
    vz(:,:,end)=vz(:,:,end).*(1-uzInIs)+uzIn;
    %vz(:,:,end-1)=vz(:,:,end-1).*(1-uzInIs)+uzIn;
    
    
end