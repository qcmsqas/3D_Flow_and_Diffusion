function calPM()
    global P uzInIs uzOutIs pm uzOutC;
    [nx,ny,nz]=size(P);
    nxy=nx*ny;
    PP=zeros(size(P));
    PP(:,:,end)=uzInIs(:,2:end)+uzOutIs(:,2:end)+uzOutC(:,2:end);
    xpm=zeros(size(PP(:),1));
    
    for i=1:nx
        for j=1:ny
            for k=1:nz
                ip=1;iq=1;jp=1;jq=1;kp=1;kq=1;
                if i==1
                    iq=-1;
                end
                if i==nx
                    ip=-1;
                end
                if j==1
                    jq=-1;
                end
                if j==ny
                    jp=-1;
                end
                if k==1
                    kq=-1;
                end
                if k==nz
                    if PP(i,j,k)==0
                        kp=-1;
                    elseif PP(i,j,k)==2
                        xpm(i+(j-1)*nx+(k-1)*nxy,i+(j-1)*nx+(k-1)*nxy)=1;
                        continue;
                    else
                        kp=0;
                    end
                end
                ii=i-1;
                jj=j-1;
                kk=k-1;
                h=ii+jj*nx+kk*nxy+1;
                xpm(h,(ii+ip)+jj*nx+kk*nxy+1)=xpm(h,(ii+ip)+jj*nx+kk*nxy+1)+1;
                xpm(h,(ii-iq)+jj*nx+kk*nxy+1)=xpm(h,(ii-iq)+jj*nx+kk*nxy+1)+1;
                xpm(h,ii+(jj+jp)*nx+kk*nxy+1)=xpm(h,ii+(jj+jp)*nx+kk*nxy+1)+1;
                xpm(h,ii+(jj-jq)*nx+kk*nxy+1)=xpm(h,ii+(jj-jq)*nx+kk*nxy+1)+1;
                xpm(h,ii+jj*nx+(kk+kp)*nxy+1)=xpm(h,ii+jj*nx+(kk+kp)*nxy+1)+1;
                xpm(h,ii+jj*nx+(kk-kq)*nxy+1)=xpm(h,ii+jj*nx+(kk-kq)*nxy+1)+1;
                xpm(h,ii+jj*nx+kk*nxy+1)=xpm(h,ii+jj*nx+kk*nxy+1)-6;
                
            end
        end
    end
    pm=xpm^(-1);
    
end