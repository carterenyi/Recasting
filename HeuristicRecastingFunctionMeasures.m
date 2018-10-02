function [ocSDprop,dcSDprop,sumdurs,sumdurs2,sumonsets,sumonsets2,onsmeas,sumnewdurs]=HeuristicRecastingFunctionMeasures(totalities,divs)
%close all
T = readtable('HeuristicData.csv');
if totalities==0
Told=T;
Tsize=size(T);
for i=Tsize(1):-1:1
   if strcmp(char(table2array(T(i,6))),'T')==1
       T(i,:)=[];
   end
end
end
chapter=table2array(T(:,1))
meters=table2array(T(:,15))
RGsds=table2array(T(:,4))

for i=1:numel(RGsds)
if numel(RGsds{i})==2
    RGSDsmat(i)=nan;
%         if strmatch(RGsds{i},'7b')==1
%             RGSDsmat(i)=4
%         elseif strmatch(RGsds{i},'4#')==1
%             RGSDsmat(i)=7
%         end
else
        RGSDsmat(i)=str2num(RGsds{i});
end
end

RGSDsmat=RGSDsmat';
match=table2array(T(:,9))

comments=table2array(T(:,8))
ucomments=unique(comments);


segonstemp=table2array(T(:,11));
for i=1:numel(RGsds)
    try
        segons(i)=str2double(segonstemp{i});
    catch
        segons(i)=nan;
    end
end
segons=segons';

%% Mean match by Scale Degree

for i=1:7
    inds1{i}=find(RGSDsmat==i);
    matchSDinds{i}=match(inds1{i});
    meanSDs(i,1)=i;
    meanSDs(i,2)=numel(inds1{i});
    meanSDs(i,3)=nanmean(matchSDinds{i});
    sizes(i)=length(inds1{i});
end

%% MAKE CONFUSION MATRIX by SCALE DEGREE For EVERY TYPE OF IMF Position

%HUH?? Can't remember what we were talking about here

%% Mean match by Chapter
chaps=unique(chapter);
for i=numel(chaps):-1:1
    if isnan(chaps(i))==1
        chaps(i)=[];
    end
end
for i=1:numel(chaps)
    inds2{i}=find(chapter==chaps(i))
    meanchaps(i,1)=chaps(i);
    meanchaps(i,2)=numel(inds2{i});
    meanchaps(i,3)=nanmean(match(inds2{i}));
    sizeschaps(i)=length(inds2{i});
end

%% Onset distribution with measure
% Do onsets cluster in the beginning (first quarter), middle 1 (second
% quarter), middle 2 (third quarter), or end (final quarter)?
%repeated pitches are considered a single note (e.g. like a tie)
% refers 12 segmentduration=segdurs and 13 onsetswithinsegment = onsets

%Onsets with respect to metric segment
% segdurs=table2array(T(:,12));
% onsets=table2array(T(:,13));
% for i=1:numel(segdurs)
%     try
%         segdurs2(i)=str2double(segdurs{i});
%     catch
%         segdurs2(i)=nan;
%     end
%     
% end
% segdurs=segdurs2;

%Onsets with respect to measure (instead of metric segment)
onsmeastemp=table2array(T(:,13));
for i=1:numel(onsmeastemp)
    try
        onsmeas{i}=str2double(onsmeastemp{i});
    catch
        onsmeas{i}=nan;
    end
    for j=1:numel(onsmeas{i})
        onsmeas{i}(j)=onsmeas{i}(j)+ segons(i);
    if onsmeas{i}(j) < 0
        onsmeas{i}(j)=onsmeas{i}(j)+meters(i);
    end
    end
end

onsets=table2array(T(:,13));
for i=1:numel(onsets)
temp=strsplit(onsets{i},';')
temp2=[];
for j=1:numel(temp)
        temp2(end+1)=str2double(temp(j));
        % needed because it is with respect to measure (not metric segment)
    if temp2(j) < 0
        temp2(j)=temp2(j)+meters(i);
    end
end
onsets2{i}=[temp2];
end
onsets=onsets2;
%sum all durs
sumonsets=0;
for i=1:numel(onsets)
    for j=1:numel(onsets{i})
        if isnan(onsets{i})==0
        sumonsets=sumonsets+1;
        end
    end
end
onsmeas=onsets;

%reinterpret chromatics
% RGSDsmatnan=RGSDsmat;
% for i=1:numel(RGSDsmat)
%     if RGSDsmatnan(i)==4.4
%         RGSDsmatnan(i)=7;
%     elseif RGSDsmatnan(i)==6.6
%         RGSDsmatnan(i)=4;
%     end
% end
RGSDsmatnan=RGSDsmat;

onsetclusters=zeros(1,divs);
onsetclustersSD=zeros(7,divs);
for i=1:numel(onsmeas)
    for j=1:numel(onsmeas{i})
        ons=onsmeas{i}(j);
        try
            for k=1:divs
            if ons < (k/divs)*meters(i)
                onsetclusters(k)=onsetclusters(k)+1;
                onsetclustersSD(RGSDsmatnan(i),k)=onsetclustersSD(RGSDsmatnan(i),k)+1;
                break
            end
            end
        catch
        end
    end
end

sumonsets2=sum(onsetclusters);
ocSD=onsetclustersSD;

for i=1:7
    ocSDprop(i,:)=ocSD(i,:)/sum(ocSD(i,:));
end

% add proportions
for i=1:divs
    ocSDfreqprop(:,i*2-1)=ocSD(:,i);
    ocSDfreqprop(:,i*2)=ocSDprop(:,i);
end


%Same thing as before with durations
% refers 12 segmentduration=segdurs and 13 onsetswithinsegment = onsets and
% 14 coretone durations

%%go through and slice everything to fit within quarters

durs=table2array(T(:,14));
for i=1:numel(durs)
temp=strsplit(durs{i},';')
temp2=[];
for j=1:numel(temp)
        temp2(end+1)=str2double(temp(j));
end
durs2{i}=[temp2];
end
durs=durs2;
%sum all durs
sumdurs=0;
for i=1:numel(durs)
    for j=1:numel(durs{i})
        if isnan(durs{i})==0
        sumdurs=sumdurs+durs{i}(j);
        end
    end
end
sumdurs=floor(sumdurs);

for i=1:numel(durs)
    thisdurs=durs{i};
    %thisdurs=str2double(thisdurs);

    %no grid for slicing!! really hard
    try
    tempons=nan;
    tempdur=nan;
    for j=1:numel(onsmeas{i}) % check to see if there is tie over barline
            dur=thisdurs(j);
            ons=onsmeas{i}(j);
            while ons+dur > meters(i)
                tempons(end+1)=0;
                tempdur(end+1)=dur+ons-meters(i);
                dur=dur-tempdur(end)
            end
            tempons(end+1)=ons;
            tempdur(end+1)=dur;
    end
    thisdurs=tempdur(2:end);
    onsmeas{i}=tempons(2:end);
    catch
        
    end
   
    qsize=meters(i)/divs; % quadrant size
    qsizes(i)=qsize;
    newons=nan;
    newdur=nan;
    
    try
        for j=1:numel(onsmeas{i})
            dur=thisdurs(j);
            ons=onsmeas{i}(j);
            for k=divs:-1:1
                if ons+dur>qsize*(k-1)
                    if ons<qsize*(k-1)
                        newons(end+1)=qsize*(k-1);
                        newdur(end+1)=ons+dur-(qsize*(k-1));
                        dur=dur-newdur(end);
                    else % if ons>=qsize*(k-1)
                        newons(end+1)=ons;
                        newdur(end+1)=dur;
                        break
                    end
                end   
            end
        end
        newonsets{i}=newons(2:end);
        newdurs{i}=newdur(2:end);
    catch
        newonsets{i}=nan;
        newdurs{i}=nan;
    end
end

sumnewdurs=0;
for i=1:numel(newdurs)
    for j=1:numel(newdurs{i})
        if isnan(newdurs{i})==0
        sumnewdurs=sumnewdurs+newdurs{i}(j);
        end
    end
end
sumnewdurs=floor(sumnewdurs);

durclusters=zeros(1,divs);
durclustersSD=zeros(7,divs);
for i=1:numel(durs)
    for j=1:numel(newonsets{i})
        ons=newonsets{i}(j)
        try
            for k=1:divs
            if ons < (k/divs)*meters(i)
                durclusters(k)=durclusters(k)+newdurs{i}(j);
                durclustersSD(RGSDsmatnan(i),k)=durclustersSD(RGSDsmatnan(i),k)+newdurs{i}(j);
                break
            end
            end
        catch
        end
    end
end
sumdurs2=sum(durclusters);
sumdurs2=floor(sumdurs2);
dcSD=durclustersSD;

for i=1:7
    dcSDprop(i,:)=dcSD(i,:)/sum(dcSD(i,:));
end

% add proportions
for i=1:divs
    dcSDfreqprop(:,i*2-1)=dcSD(:,i);
    dcSDfreqprop(:,i*2)=dcSDprop(:,i);
end

end

