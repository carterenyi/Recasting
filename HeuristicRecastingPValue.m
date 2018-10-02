clear
totalities=1
divs=4
[ocSDprop,dcSDprop,sumdursb,sumdurs2b,sumonsetsb,sumonsets2b,onsmeas,sumnewdursb]=HeuristicRecastingFunctionMeasures(totalities,divs)


x = ocSDprop(:,1);
y=x(4);
x(4)=[];
mu = mean(x);
sigma = std(x);
pmeas = normcdf(y,mu,sigma)

[ocSDpropb,dcSDprop,sumdurs,sumdurs2,sumonsets,sumonsets2,onsets,durclusters,sumnewdurs]=HeuristicRecastingFunctionMetSegs(totalities,divs)

x = ocSDpropb(:,1);
yb=x(4);
x(4)=[];
mub = mean(x);
sigmab = std(x);
pmetsegs = normcdf(yb,mub,sigmab)


[ocSDpropc,dcSDpropc,sumdursb,sumdurs2b,sumonsetsb,sumonsets2b,onsmeas,sumnewdursb]=HeuristicRecastingFunctionBeats(totalities,divs)

x = ocSDpropc(:,1);
yc=x(4);
x(4)=[];
muc = mean(x);
sigmac = std(x);
pbeats = normcdf(yc,muc,sigmac)