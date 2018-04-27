function calUC()
    global uxc uyc uzc ux uy uz;
    global uxA uyA uzA;
    global uxB uyB uzB;
    uxc=(ux(1:end-1,2:end,1:end)+ux(2:end,2:end,1:end))/2;
    uyc=(uy(1:end,1:end-1,1:end)+uy(1:end,2:end,1:end))/2;
    uzc=(uz(1:end,2:end,1:end-1)+uz(1:end,2:end,2:end))/2;
    uxa=ux(1:end-1,2:end,1:end);
    uxb=ux(2:end,  2:end,1:end);
    uya=uy(1:end,1:end-1,1:end);
    uyb=uy(1:end,2:end  ,1:end);
    uza=uz(1:end,2:end,1:end-1);
    uzb=uz(1:end,2:end,2:end  );
    uxA=uxa.*(uxa>0);
    uxB=uxb.*(uxb<0);
    uyA=uya.*(uya>0);
    uyB=uyb.*(uyb<0);
    uzA=uza.*(uza>0);
    uzB=uzb.*(uzb<0);
    
    
end