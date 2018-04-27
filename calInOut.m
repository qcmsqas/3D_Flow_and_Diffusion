function calInOut(speed1,r1,x1,r2,x2,dx)
    global x y uz;
    global uzIn uzOut uzInIs uzOutIs uzOutC;
%    xx=(x(1:end-1)+x(2:end))/2;
%    yy=(y(1:end-1)+y(2:end))/2;
    [X,Y]=meshgrid(x,y);
    dd1=(((X-x1).^2+Y.^2).^0.5)';
    is=(dd1<r1)*1;
    sp=cos(dd1/2/r1*pi).*is;
    nm=sum(sum(sp(:,1:end)))+sum(sum(sp(:,2:end)));
    uzIn=zeros(size(uz,1),size(uz,2),1);
    uzIn(:,2:end,1)=sp/nm;
    uzIn(:,1,1)=sp(:,2)/nm;
%    uzIn(:,end,1)=-sp(:,end)/nm;
    uzIn=-uzIn*speed1/dx/dx;
    uzInIs=zeros(size(uz,1),size(uz,2),1);
    uzInIs(:,2:end,1)=is;
    uzInIs(:,1,1)=is(:,2);
    dd1=(((X-x2).^2+Y.^2).^0.5)';
    is=(dd1<r2)*1;
    sp=cos(dd1/2/r2*pi).*is;
    nm=sum(sum(sp(:,1:end)))+sum(sum(sp(:,2:end)));
    uzOut=zeros(size(uz,1),size(uz,2),1);
    uzOut(:,2:end,1)=sp/nm;
    uzOut(:,1,1)=sp(:,2)/nm;
    uzOut=uzOut*speed1/dx/dx;
    uzOutIs=zeros(size(uz,1),size(uz,2),1);
    uzOutIs(:,2:end,1)=is;
    uzOutIs(:,1,1)=is(:,2);
    uzOutC=zeros(size(uzOutIs));
    
    
    uzOutC(:,2:end,1)=(dd1==min(min(dd1)))*1;
    uzOut=uzOut-uzOutC*(sum(sum(uzIn+uzOut)));
    
end
