function disStep(inNA,inEG,dx,dt)
    global cEG cNA uzInIs DsNA DsEG uxA uxB uyA uyB uzA uzB uzOutIs uxc uyc uzc;
    dv=dt/dx;
    dvox=dv/dx;
    cEG(2:end-1,1:end-1,end)=cEG(2:end-1,1:end-1,end).*(1-uzInIs)+uzInIs*inEG;
    cNA(2:end-1,1:end-1,end)=cNA(2:end-1,1:end-1,end).*(1-uzInIs)+uzInIs*inNA;
    ncEG=cEG;
    ncNA=cNA;
    
    
    cEGadd=cEG(2:end-1,2:end-1,2:end-1)*0;
    cEGadd=cEGadd+dv*uxA.*(cEG(1:end-2,2:end-1,2:end-1)-cEG(2:end-1,2:end-1,2:end-1)) ...
                 -dv*uxB.*(cEG(3:end  ,2:end-1,2:end-1)-cEG(2:end-1,2:end-1,2:end-1)) ...
                 +dv*uyA.*(cEG(2:end-1,1:end-2,2:end-1)-cEG(2:end-1,2:end-1,2:end-1)) ...
                 -dv*uyB.*(cEG(2:end-1,3:end  ,2:end-1)-cEG(2:end-1,2:end-1,2:end-1)) ...
                 +dv*uzA.*(cEG(2:end-1,2:end-1,1:end-2)-cEG(2:end-1,2:end-1,2:end-1)) ...
                 -dv*uzB.*(cEG(2:end-1,2:end-1,3:end  )-cEG(2:end-1,2:end-1,2:end-1));

    
    cEGadd=cEGadd+DsEG*(cEG(3:end,2:end-1,2:end-1)-2*cEG(2:end-1,2:end-1,2:end-1)+cEG(1:end-2,2:end-1,2:end-1))*dvox;
    cEGadd=cEGadd+DsEG*(cEG(2:end-1,3:end,2:end-1)-2*cEG(2:end-1,2:end-1,2:end-1)+cEG(2:end-1,1:end-2,2:end-1))*dvox;
    cEGadd=cEGadd+DsEG*(cEG(2:end-1,2:end-1,3:end)-2*cEG(2:end-1,2:end-1,2:end-1)+cEG(2:end-1,2:end-1,1:end-2))*dvox;
    
    ncEG(2:end-1,2:end-1,2:end-1)=cEG(2:end-1,2:end-1,2:end-1)+cEGadd;
    ncEG(1,:,:)=ncEG(3,:,:);
    ncEG(end,:,:)=ncEG(end-2,:,:);
    ncEG(:,1,:)=ncEG(:,3,:);
    ncEG(:,end,:)=ncEG(:,end-2,:);
    ncEG(:,:,1)=ncEG(:,:,3);
    ncEG(:,:,end)=ncEG(:,:,end-2);
    ncEG(2:end-1,1:end-1,end)=ncEG(2:end-1,1:end-1,end).*(1-uzOutIs)+ncEG(2:end-1,1:end-1,end-1).*(uzOutIs);
    cEG=ncEG;
        
    cNAadd=cNA(2:end-1,2:end-1,2:end-1)*0;
    cNAadd=cNAadd+dv*uxA.*(cNA(1:end-2,2:end-1,2:end-1)-cNA(2:end-1,2:end-1,2:end-1)) ...
                 -dv*uxB.*(cNA(3:end  ,2:end-1,2:end-1)-cNA(2:end-1,2:end-1,2:end-1)) ...
                 +dv*uyA.*(cNA(2:end-1,1:end-2,2:end-1)-cNA(2:end-1,2:end-1,2:end-1)) ...
                 -dv*uyB.*(cNA(2:end-1,3:end  ,2:end-1)-cNA(2:end-1,2:end-1,2:end-1)) ...
                 +dv*uzA.*(cNA(2:end-1,2:end-1,1:end-2)-cNA(2:end-1,2:end-1,2:end-1)) ...
                 -dv*uzB.*(cNA(2:end-1,2:end-1,3:end  )-cNA(2:end-1,2:end-1,2:end-1));
    
    cNAadd=cNAadd+DsNA*(cNA(3:end,2:end-1,2:end-1)-2*cNA(2:end-1,2:end-1,2:end-1)+cNA(1:end-2,2:end-1,2:end-1))*dvox;
    cNAadd=cNAadd+DsNA*(cNA(2:end-1,3:end,2:end-1)-2*cNA(2:end-1,2:end-1,2:end-1)+cNA(2:end-1,1:end-2,2:end-1))*dvox;
    cNAadd=cNAadd+DsNA*(cNA(2:end-1,2:end-1,3:end)-2*cNA(2:end-1,2:end-1,2:end-1)+cNA(2:end-1,2:end-1,1:end-2))*dvox;
    
    ncNA(2:end-1,2:end-1,2:end-1)=cNA(2:end-1,2:end-1,2:end-1)+cNAadd;
    ncNA(1,:,:)=ncNA(3,:,:);
    ncNA(end,:,:)=ncNA(end-2,:,:);
    ncNA(:,1,:)=ncNA(:,3,:);
    ncNA(:,end,:)=ncNA(:,end-2,:);
    ncNA(:,:,1)=ncNA(:,:,3);
    ncNA(:,:,end)=ncNA(:,:,end-2);
    ncNA(2:end-1,1:end-1,end)=ncNA(2:end-1,1:end-1,end).*(1-uzOutIs)+ncNA(2:end-1,1:end-1,end-1).*(uzOutIs);
    cNA=ncNA;

end