clear
close all
%Heuristic Recasting Script
totalities=1
divs=4

[ocSDprop,dcSDprop,sumdurs,sumdurs2,sumonsets,sumonsets2,onsets,durclusters,sumnewdurs]=HeuristicRecastingFunctionMetSegs(totalities,divs)

figure()
bar(ocSDprop*100)
title('Core Tone Onset Distribution within Metric Segments by Scale Degree')
xlabel('Scale Degree')
ylabel('Percent')
legend('Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4')
saveas(gcf,'GR_ACE_Fig01.png')

[ocSDpropb,dcSDpropb,sumdursb,sumdurs2b,sumonsetsb,sumonsets2b,onsmeasb,sumnewdursb]=HeuristicRecastingFunctionMeasures(totalities,divs)

figure()
bar(ocSDpropb*100)
title('Core Tone Onset Distribution within Measures by Scale Degree')
xlabel('Scale Degree')
ylabel('Percent')
legend('Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4')
saveas(gcf,'GR_ACE_Fig02.png')

[ocSDpropc,dcSDpropc,sumdursc,sumdurs2c,sumonsetsc,sumonsets2c,onsmeasc,sumnewdursc]=HeuristicRecastingFunctionBeats(totalities,divs)

figure()
bar(ocSDpropc*100)
title('Core Tone Onset Distribution within Beats by Scale Degree')
xlabel('Scale Degree')
ylabel('Percent')
legend('Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4')
saveas(gcf,'GR_ACE_Fig03.png')


for i=1:7
    ratioa(i)=ocSDprop(i,4)/ocSDprop(i,1)
    ratiob(i)=ocSDpropb(i,4)/ocSDpropb(i,1)
    ratioc(i)=ocSDpropc(i,4)/ocSDpropc(i,1)
end
    
figure()
bar(ratioa)
title('Onset Distribution Ratio within Metric Segments by Scale Degree')
xlabel('Scale Degree')
ylabel('Ratio of Quadrant 4 to Quadrant 1')
%legend('Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4')
saveas(gcf,'GR_ACE_Fig04.png')

figure()
bar(ratiob)
title('Onset Distribution Ratio within Measures by Scale Degree')
xlabel('Scale Degree')
ylabel('Ratio of Quadrant 4 to Quadrant 1')
%legend('Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4')
saveas(gcf,'GR_ACE_Fig05.png')

figure()
bar(ratioc)
title('Onset Distribution Ratio within Beats by Scale Degree')
xlabel('Scale Degree')
ylabel('Ratio of Quadrant 4 to Quadrant 1')
%legend('Quadrant 1','Quadrant 2','Quadrant 3','Quadrant 4')
saveas(gcf,'GR_ACE_Fig06.png')
