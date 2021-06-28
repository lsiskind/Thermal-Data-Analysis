function [name, version, location, attitude, YPR, beta, life, tempExtreme, Case] = getNamesELC(namecell)

% create name vectors the same length as M

name = namecell{1}; %again can iterate this later on
version = 'v5-1';
location = 'ELC';
attitude = name(1:3);
YPR1 = extractBetween(name,6,'_');
findP = strfind(name,'P');
YPR2 = extractBetween(name,findP(1)+1,'_');
findR = strfind(name,'R');
YPR3 = extractBetween(name,findR(1)+1,'_');
YPR = char(strcat(YPR1,{','},YPR2,{','},YPR3));
findB = strfind(name,'B');
beta = string(extractBetween(name,findB(1)+1,'_'));
life = string(extractBetween(name,findB(1)+5,'_'));
temp = name(strfind(name,life)+4);
if temp == 'H'
    tempExtreme = 'Hot';
    findHot = strfind(name,'Hot');
    Case = string(extractBetween(name,findHot+3,'.xlsx'));
else
    tempExtreme = 'Cold';
    findCold = strfind(name,'Cold');
    Case = string(extractBetween(name,findCold+4,'.xlsx'));
end



end
