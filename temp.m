
    
    cNAadd=cNA(2:end-1,2:end-1,2:end-1)*0;
    uxc=(ux(1:end-1,2:end,1:end)+ux(2:end,2:end,1:end))/2;
    cNAadd=cNAadd-uxc.*(cNA(3:end,2:end-1,2:end-1)-cNA(1:end-2,2:end-1,2:end-1))/(2*dx);
    clear uxc;
    uyc=(uy(1:end,1:end-1,1:end)+uy(1:end,2:end,1:end))/2;
    cNAadd=cNAadd-uyc.*(cNA(2:end-1,3:end,2:end-1)-cNA(2:end-1,1:end-2,2:end-1))/(2*dx);
    clear uyc;
    uzc=(uz(1:end,2:end,1:end-1)+uz(1:end,2:end,2:end))/2;
    cNAadd=cNAadd-uzc.*(cNA(2:end-1,2:end-1,3:end)-cNA(2:end-1,2:end-1,1:end-2))/(2*dx);
    clear uzc;
    
    cNAadd=cNAadd+DsNA*(cNA(3:end,2:end-1,2:end-1)-2*cNA(2:end-1,2:end-1,2:end-1)+cNA(1:end-2,2:end-1,2:end-1))/(dx*dx);
    cNAadd=cNAadd+DsNA*(cNA(2:end-1,3:end,2:end-1)-2*cNA(2:end-1,2:end-1,2:end-1)+cNA(2:end-1,1:end-2,2:end-1))/(dx*dx);
    cNAadd=cNAadd+DsNA*(cNA(2:end-1,2:end-1,3:end)-2*cNA(2:end-1,2:end-1,2:end-1)+cNA(2:end-1,2:end-1,1:end-2))/(dx*dx);
    
    ncNA(2:end-1,2:end-1,2:end-1)=cNA(2:end-1,2:end-1,2:end-1)+cNAadd*dt;
    ncNA(1,:,:)=ncNA(3,:,:);
    ncNA(end,:,:)=ncNA(end-2,:,:);
    ncNA(:,1,:)=ncNA(:,3,:);
    ncNA(:,end,:)=ncNA(:,end-2,:);
    ncNA(:,:,1)=ncNA(:,:,3);
    ncNA(:,:,end)=ncNA(:,:,end-2);