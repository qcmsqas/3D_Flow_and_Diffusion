%%%������
%����������е�λ�����ù��ʵ�λ��
global DsNA DsEG;
ro=1000;
xmin=0;xmax=0.055;
ymin=0;ymax=0.002;
zmin=0;zmax=0.001;
dx=0.0001;
dt=0.0002;
t1=240;
t2=720;
mEG=5*1.48e-3;
mNA=1.05e-3;
DsEG=5.23e-10;
DsNA=7.1e-10;
CsEG=1;
CsNA0=0.154;
CsNA=0.462;
x1=0.001;
x2=xmax-0.001;
r1=0.00065;
r2=0.00065;
speed=15e-9/60;
mmEG=mEG/ro;
mmNA=mNA/ro;
%�趨mesh
global x y z P ux uy uz cNA cEG uzOutIs uzInIs uzIn uzOut;
global vx vy vz;
setMesh(xmin,ymin,zmin,xmax,ymax,zmax,dx);
calInOut(speed,r1,x1,r2,x2,dx);
setInit(CsNA0);
%calPM();
%flowStep1(ro,mmEG,mmNA,CsEG,dt,dx);
%flowStep2(dt,dx);
%flowStep3(dt,dx);
markold=1;
for ii=1:100000
    stableStep1(dt,dx,0.01);
    mark=(sum(sum(ux(140,2:end,:)))+sum(sum(ux(140,3:end,:))))*dx*dx/speed;
    itt=abs(mark-markold)/markold;
    if itt<1e-7
        break;
    end
    if mark==0
        markold=1;
    else
        markold=mark;
    end
    
    disp(['���ڼ������ٷֲ���������=' num2str(itt)]);
    stableStep2(mmEG,dt,dx);
end


cNA=ones(size(x,2)+2,size(y,2)+2,size(z,2)+2)*CsNA0;
cEG=cNA*0;

Nrec=2000;
dt=0.02;
%��������������¼Ũ��ͼ
recNA=zeros(size(x,2),size(y,2),1+floor((t1+t2)/dt/Nrec));
recEG=zeros(size(x,2),size(y,2),1+floor((t1+t2)/dt/Nrec));
%����һ��������¼����EGŨ�ȱ仯
recEGcenter=zeros(1+floor(t1+t2)/dt,1);
%�������������¼���NaClŨ�ȱ仯
recNAP1=zeros(1+floor(t1+t2)/dt,1);
recNAP2=zeros(1+floor(t1+t2)/dt,1);
recNAP3=zeros(1+floor(t1+t2)/dt,1);
recNAP4=zeros(1+floor(t1+t2)/dt,1);
recNAP5=zeros(1+floor(t1+t2)/dt,1);
calUC();
for t=1:(t1/dt)
    disp(['���ڼ����' num2str(t*dt) '��']);
    %Ũ����ɢ
    disStep(CsNA,0,dx,dt);
    %�����¼
    if rem(t,Nrec)==0
        recNA(:,:,floor(t/Nrec)+1)=cNA(2:end-1,2:end-1,round(size(cNA,3)/2));
        recEG(:,:,floor(t/Nrec)+1)=cEG(2:end-1,2:end-1,round(size(cEG,3)/2));
        mesh(cNA(2:end-1,2:end-1,round(size(cNA,3)/2)));
        view(2);
        drawnow;
    end
    recEGcenter(t)=cEG(round(size(cEG,1)/2),2,round(size(cEG,3)/2));
    recNAP1(t)=cNA(round(size(cNA,1)/4),2,round(size(cNA,3)/2));
    recNAP2(t)=cNA(round(size(cNA,1)*2/4),round(size(cNA,2)/2-0.5),round(size(cNA,3)/2));
    recNAP3(t)=cNA(round(size(cNA,1)*2/4),2,round(size(cNA,3)/2));
    recNAP4(t)=cNA(round(size(cNA,1)*2/4),round(size(cNA,2)/2-0.5),round(size(cNA,3)/2));
    recNAP5(t)=cNA(round(size(cNA,1)*3/4),2,round(size(cNA,3)/2));
end
for t=(t1/dt+1):((t1+t2)/dt)
    disp(['���ڼ����' num2str((t)*dt) '��'])
    %Ũ����ɢ
    disStep(CsNA,CsEG,dx,dt);
    %�����¼
    if rem(t,Nrec)==0
        recNA(:,:,floor(t/Nrec)+1)=cNA(2:end-1,2:end-1,round(size(cNA,3)/2));
        recEG(:,:,floor(t/Nrec)+1)=cEG(2:end-1,2:end-1,round(size(cEG,3)/2));
        mesh(cEG(2:end-1,2:end-1,round(size(cEG,3)/2)));
        view(2);
        drawnow;
    end
    recEGcenter(t)=cEG(round(size(cEG,1)/2),2,round(size(cEG,3)/2));
    recNAP1(t)=cNA(round(size(cNA,1)/4),2,round(size(cNA,3)/2));
    recNAP2(t)=cNA(round(size(cNA,1)*2/4),round(size(cNA,2)/2-0.5),round(size(cNA,3)/2));
    recNAP3(t)=cNA(round(size(cNA,1)*2/4),2,round(size(cNA,3)/2));
    recNAP4(t)=cNA(round(size(cNA,1)*2/4),round(size(cNA,2)/2-0.5),round(size(cNA,3)/2));
    recNAP5(t)=cNA(round(size(cNA,1)*3/4),2,round(size(cNA,3)/2));
end
yy=-ymax/2:dx:ymax/2;
[X,Y]=meshgrid(x,yy);
X=X';Y=Y';X=X*1000;Y=Y*1000;%���ȵ�λ��Ϊ����
plotNA=zeros(size(X,1),size(X,2),25);
plotEG=zeros(size(X,1),size(X,2),25);
cc=(size(X,2)-1)/2;
plotNA(:,cc+1:end,:)=recNA;
plotEG(:,cc+1:end,:)=recEG;
for j=1:cc
    plotNA(:,j,:)=recNA(:,end+1-j,:);
    plotEG(:,j,:)=recEG(:,end+1-j,:);
end
Nplot=size(recEG,3)-1;
figure;
for ii=1:Nplot
    i=ii;
    subplot(2,Nplot,ii);
    surf(Y,X,plotNA(:,:,i),'edgecolor','none');
    caxis([0,CsNA]);
    view(2);
    xlim([-1 1]);
    ylim([0 55]);
    xlabel([num2str(round((i)*Nrec*dt)) '']);
    colormap('jet');
    if ii==Nplot
        colorbar;
    end
    subplot(2,Nplot,ii+Nplot);
    surf(Y,X,plotEG(:,:,i),'edgecolor','none');
    caxis([0,CsEG]);
    view(2);
    xlim([-1 1]);
    ylim([0 55]);
    xlabel([num2str(round((i)*Nrec*dt)) '']);
    colormap('jet');
    if ii==Nplot
        colorbar;
        
    end
end

figure();
t=1:(t1+t2)/dt;
subplot(1,2,1);
ct=(rem(t,100)==0);
pEG=recEGcenter;
plot(t(ct)*dt,pEG(ct));
xlabel('time / s');
title('EG at Center point');
subplot(1,2,2);
hold on;
pNA=recNAP1;
plot(t(ct)*dt,pNA(ct));
pNA=recNAP2;
plot(t(ct)*dt,pNA(ct));
pNA=recNAP3;
plot(t(ct)*dt,pNA(ct));
pNA=recNAP4;
plot(t(ct)*dt,pNA(ct));
pNA=recNAP5;
plot(t(ct)*dt,pNA(ct));
title('NaCl at five points');
xlabel('time / s');
legend('point 1','point 2','point 3','point 4','point 5');
