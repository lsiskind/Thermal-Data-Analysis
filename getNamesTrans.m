function [name, version, location, attitude, YPR, beta, life, tempExtreme, Case] = getNamesTrans(namecell)

% create name vectors the same length as M

name = namecell{1}; %again can iterate this later on
version = 'v8';
location = 'Transfer';
attitude = name(9:11);
findY = strfind(name, 'Y');
findP = strfind(name, 'P');
Y = extractBetween(name, findY+1, '_');
P = extractBetween(name, findP+1,'_');
R = extractBetween(name, findP+6, '_');
YPR = char(strcat(Y,{','},P,{','},R));
findB = strfind(name,'B');
beta = char(extractBetween(name,findB+1,'_'));
life = 'N/A';

if contains(name,'HOT')==1
    tempExtreme = 'Hot';
else
    tempExtreme = 'Cold';
end
Case = char(extractBetween(name, findB+4, 'xlsx'));


end