%%%主程序
%方便起见所有单位均采用国际单位制
global DsNA DsEG;
ro=1000;
xmin=0;xmax=0.055;
ymin=0;ymax=0.002;
zmin=0;zmax=0.001;
dx=0.00025;
dt=0.2;
t1=240;
t2=720;
mEG=1.48e-3;
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
Nrec=20;
mmEG=mEG/ro;
mmNA=mNA/ro;
%设定mesh
global x y z P ux uy uz cNA cEG uzOutIs uzInIs uzIn uzOut;
global vx vy vz;
setMesh(xmin,ymin,zmin,xmax,ymax,zmax,dx);
calInOut(speed,r1,x1,r2,x2,dx);
setInit(CsNA0);
recNA=zeros(size(x,2),size(y,2),1+floor((t1+t2)/dt/Nrec));
recEG=zeros(size(x,2),size(y,2),1+floor((t1+t2)/dt/Nrec));
%预算求解P用到的矩阵
calPM();
for t=1:(t1/dt)
    %保存记录
    if rem(t-1,Nrec)==0
        recNA(:,:,floor(t/Nrec)+1)=cNA(2:end-1,2:end-1,round(size(cNA,3)/2));
        recEG(:,:,floor(t/Nrec)+1)=cEG(2:end-1,2:end-1,round(size(cEG,3)/2));
    end
%    disp(t*dt);
    if t*dt==1
        break;
    end
    %先做流动，三步法
    %第一步，惯性移动
    flowStep1(ro,mmEG,mmNA,CsEG,dt,dx);
    disp(['v' num2str(max(abs(vx(:))))])
    if sum(isnan(ux(:)))>0
        disp('1')
        break;
    end
    %第二步，求解压强
    flowStep2(dt,dx);
    disp(max(abs(P(:))))
    
    if sum(isnan(ux(:)))>0
        disp('2')
        break;
    end
    %第三步，压强推动
    flowStep3(dt,dx);
    
    disp(max(abs(ux(:))))
    if sum(isnan(ux(:)))>0
        disp('3')
        break;
    end
    %再做浓度扩散
    disStep(CsNA,0,dt,dx);
end
