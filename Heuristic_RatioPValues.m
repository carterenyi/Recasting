% run HeuristicRecastingScriptFinal first
x=ratioa;
ya=x(4);
x(4)=[];
mua = mean(x);
sigma = std(x);
pmetsegs = normcdf(ya,mua,sigma)

x=ratiob;
yb=x(4);
x(4)=[];
mub = mean(x);
sigma = std(x);
pmeas = normcdf(yb,mub,sigma)

x=ratioc;
yc=x(4);
x(4)=[];
muc = mean(x);
sigma = std(x);
pbeats = normcdf(yc,muc,sigma)