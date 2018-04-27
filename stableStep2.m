function stableStep2(mmu,dt,dx)
    global ux uy uz P uzInIs uzOutIs uzIn uzOut;
    
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
    uxadd=uxadd+mmu*dxdxux;
    clear dxdxux;
    dydyux=(ux(2:end-1,3:end,2:end-1)-2*ux(2:end-1,2:end-1,2:end-1)+ux(2:end-1,1:end-2,2:end-1))/(dx*dx);
    %uxadd=uxadd+mux.*dydyux;
    uxadd=uxadd+mmu*dydyux;
    clear dydyux;
    dzdzux=(ux(2:end-1,2:end-1,3:end)-2*ux(2:end-1,2:end-1,2:end-1)+ux(2:end-1,2:end-1,1:end-2))/(dx*dx);
    %uxadd=uxadd+mux.*dzdzux;
    uxadd=uxadd+mmu*dzdzux;
    clear dzdzux mux;
    ux(2:end-1,2:end-1,2:end-1)=ux(2:end-1,2:end-1,2:end-1)+uxadd*dt;
    ux(1,:,:)=-ux(2,:,:);
    ux(end,:,:)=-ux(end-1,:,:);
    ux(:,1,:)=ux(:,3,:);
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
    uyadd=uyadd+mmu*dxdxuy;
    clear dxdxuy;
    dydyuy=(uy(2:end-1,3:end,2:end-1)-2*uy(2:end-1,2:end-1,2:end-1)+uy(2:end-1,1:end-2,2:end-1))/(dx*dx);
    %uyadd=uyadd+muy.*dydyuy;
    uyadd=uyadd+mmu*dydyuy;
    clear dydyuy;
    dzdzuy=(uy(2:end-1,2:end-1,3:end)-2*uy(2:end-1,2:end-1,2:end-1)+uy(2:end-1,2:end-1,1:end-2))/(dx*dx);
    %uyadd=uyadd+muy.*dzdzuy;
    uyadd=uyadd+mmu*dzdzuy;
    clear dzdzuy muy;
    uy(2:end-1,2:end-1,2:end-1)=uy(2:end-1,2:end-1,2:end-1)+uyadd*dt;
    uy(:,1,:)=-uy(:,2,:);
    uy(:,end,:)=-uy(:,end-1,:);
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
    uzadd=uzadd+mmu*dxdxuz;
    clear dxdxuy;
    dydyuz=(uz(2:end-1,3:end,2:end-1)-2*uz(2:end-1,2:end-1,2:end-1)+uz(2:end-1,1:end-2,2:end-1))/(dx*dx);
    %uzadd=uzadd+muz.*dydyuz;
    uzadd=uzadd+mmu*dydyuz;
    clear dydyuy;
    dzdzuz=(uz(2:end-1,2:end-1,3:end)-2*uz(2:end-1,2:end-1,2:end-1)+uz(2:end-1,2:end-1,1:end-2))/(dx*dx);
    %uzadd=uzadd+muz.*dzdzuz;
    uzadd=uzadd+mmu*dzdzuz;
    clear dzdzuy muz;
    uz(2:end-1,2:end-1,2:end-1)=uz(2:end-1,2:end-1,2:end-1)+uzadd*dt;
    uz(:,:,1)=-uz(:,:,2);
    uz(:,:,end)=-uz(:,:,end-1);
    uz(:,1,:)=uz(:,3,:);
    clear uzadd;  
    
    ux(2:end-1,2:end-1,2:end-1)=ux(2:end-1,2:end-1,2:end-1)+dt*(P(1:end-1,1:end-1,2:end-1)-P(2:end,1:end-1,2:end-1))/dx;
    uy(2:end-1,2:end-1,2:end-1)=uy(2:end-1,2:end-1,2:end-1)+dt*(P(2:end-1,1:end-1,2:end-1)-P(2:end-1,2:end,2:end-1))/dx;
    uz(2:end-1,2:end-1,2:end-1)=uz(2:end-1,2:end-1,2:end-1)+dt*(P(2:end-1,1:end-1,1:end-1)-P(2:end-1,1:end-1,2:end))/dx;
    
        
    uz(:,:,end)=uz(:,:,end).*(1-uzOutIs)+uzOut;
    uz(:,:,end)=uz(:,:,end).*(1-uzInIs)+uzIn;
%    uz(:,:,end-1)=uz(:,:,end-1).*(1-uzOutIs)+uzOut;
%    uz(:,:,end-1)=uz(:,:,end-1).*(1-uzInIs)+uzIn;

end