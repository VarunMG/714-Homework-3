N = 128;
x = cos(pi*(0:N)/N);
y=x';
dt = 6/N^2;
[xx,yy] = meshgrid(x,y);
plotgap = round((1/3)/dt);
dt = (1/3)/plotgap;
f = @(x) exp(-100*x.^2);
vel = @(x,y) f(x).*f(y);
%vv = sin(pi*x).*sin(pi*y);
vv = zeros(N+1,N+1);
v0 = vel(xx,yy);
vvold = vv;

u = zeros(N+1,N+1,2);
u(:,:,1) = vv;

%first step
vvnew = vvold + dt*v0 + 0.5*dt^2*spectral_lap(vvold,N,x,y) +(1/6)*dt^3*spectral_lap(v0,N,x,y);

u(:,:,2) = vvnew;

vv = vvnew;

[ay,ax] = meshgrid([0.56,0.06],[0.1,0.55]); clf
for n=2:3*plotgap
    t = n*dt;
    if rem(n+.5,plotgap)<1
        i = n/plotgap +1;
        subplot('position',[ax(i) ay(i) .36 .36]);
        [xxx,yyy] = meshgrid(-1:1/16:1,-1:1/16:1);
        vvv = interp2(xx,yy,vv,xxx,yyy,'cubic');
        mesh(xxx,yyy,vvv), axis([-1 1 -1 1 -0.15 1])
        colormap([0 0 0]), title(['t = ' num2str(t)]), drawnow
    end
    lap = spectral_lap(vv,N,x,y);
    bilap = spectral_lap(lap,N,x,y);
    vvnew = 2*vv - vvold + dt^2*lap + (1/12)*dt^4*bilap;
    vvold = vv; vv = vvnew;
    u = cat(3,u,vvnew);
end
[~,~,tIters] = size(u);


    