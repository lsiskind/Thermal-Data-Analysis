function [name, version, location, attitude, YPR, beta, life, tempExtreme, Case] = getNamesSF(namecell)

% create name vectors the same length as M

name = namecell{1}; %again can iterate this later on
version = 'v5-1';
location = 'Solo Flight';
attitude = 'N/A';
YPR = 'N/A';
beta = 'N/A';
life = 'N/A';
if contains(name,'HOT')==1
    tempExtreme = 'Hot';
else
    tempExtreme = 'Cold';
end
Case = erase(name,'xlsx');


end