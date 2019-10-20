function plotarrow(h1,h2,x,y,u,v,scale)

alpha = 0.33; % Size of arrow head relative to the length of the vector
beta = 0.33;  % Width of the base of the arrow head relative to the length

u = u*scale;
v = v*scale;
uu = [x;x+u;NaN];
vv = [y;y+v;NaN];
% h1 = plot(uu(:),vv(:),'Color',color,'EraseMode','none');

addpoints(h1, double(uu(:)),double(vv(:)));
hu = [x+u-alpha*(u+beta*(v+eps));x+u; ...
    x+u-alpha*(u-beta*(v+eps));NaN];
hv = [y+v-alpha*(v-beta*(u+eps));y+v; ...
    y+v-alpha*(v+beta*(u+eps));NaN];
addpoints(h2, double(hu(:)),double(hv(:)));
drawnow
% h2 = plot(hu(:),hv(:),'Color',color,'EraseMode','none');
% drawnow