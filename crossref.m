function [nodeName, opMin, opMax, nonopMin, nonopMax] = crossref(nodeID)

% cross reference to get node name
filedir2 = '/Users/lsiskind/Documents/projects/Thermal Data/'; % Lena's Mac Setup
compNodes = readcell([filedir2 'EMIT Component Nodes'],'Range','A1:AN210');

nodeList = string(compNodes(2:end,7:end));
[rows_nodeList, ~] = size(nodeList);
componentnames = string(compNodes(2:end,2));

[rows, ~] = size(nodeID);

nodeName = strings(rows,1);
opMin = cell(rows,1);
opMax = cell(rows,1);
nonopMin = cell(rows,1);
nonopMax = cell(rows,1);

updateStr = ''; %For progress update text
for i = 1:rows_nodeList
    component = componentnames(i);
    nodevec = nodeList(i,:);
    for j = 1:length(nodevec)
        node = nodevec(j);
        node = erase(node,'$');
        index = contains(nodeID,node);
        if isempty(index)~=1
            nodeName(index) = component;
            opMin(index) = compNodes(i,3);
            opMax(index) = compNodes(i,4);
            nonopMin(index) = compNodes(i,5);
            nonopMax(index) = compNodes(i,6);
        end
    end
     percentDone = 100*i/rows_nodeList;
    msg = sprintf('Percent Completion: %0.1f',percentDone);
    fprintf([updateStr msg])
    updateStr = repmat(sprintf('\b'),1,length(msg)); %Deletes previous msg so that only current msg is visible
        
end



end