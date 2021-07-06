function [nodeName, opMin, opMax, nonOpMin, nonOpMax] = crossref(nodeID)

% cross reference to get node name
filedir2 = '/Users/lsiskind/Documents/projects/Thermal Data/'; % Lena's Mac Setup
compNodes = readcell([filedir2 'v5-1 Node List'],'Range','A1:AN210');

% delete missing rows
[rowscomp,~] = size(compNodes);
i =1;
while i <= rowscomp
    if ismissing(compNodes{i,2}) == 1
        compNodes(i,:) = [];
        [rowscomp, ~] = size(compNodes);
    else
        i = i+1;
        [rowscomp, ~] = size(compNodes);
    end
end

% read in just the node list
nodeList = string(compNodes(2:end,7:end));
[rows_nodeList, ~] = size(nodeList);

% read in all the component names
componentnames = string(compNodes(2:end,2));

% read in operating temperatures
opminvec = compNodes(2:end,3);
opmaxvec = compNodes(2:end,4);
nonopminvec = compNodes(2:end,5);
nonopmaxvec = compNodes(2:end,6);

% output a vector of component names the size of nodeID
[rows, ~] = size(nodeID);
nodeName = strings(rows,1);
opMin = cell(rows,1);
opMax = cell(rows,1);
nonOpMin = cell(rows,1);
nonOpMax = cell(rows,1);

for i = 1:rows_nodeList
    component = componentnames(i);
    nodevec = nodeList(i,1:4); 
    opmin1 = opminvec(i);
    opmax1 = opmaxvec(i);
    nonopmin1 = nonopminvec(i);
    nonopmax1 = nonopmaxvec(i);
    
    % delete empty columns in node vec           
    [rowsnodevec,~] = size(nodevec);
    k =1;
    while k <= rowsnodevec
        if ismissing(nodevec(k)) == 1
            nodevec(k) = [];
            [rowsnodevec, ~] = size(nodevec);
        else
            k = k+1;
            [rowsnodevec, ~] = size(nodevec);
        end
    end
    
    for j = 1:length(nodevec)
        
        node = nodevec(1,j);
        
        if contains(node, '$') == 1
        
            if contains(node, digitsPattern)
                if any(regexp(node,'.\d*$')) == 1 && count(node,'.') == 1
                    node = erase(node, '$');
                    nodeName(nodeID == node & nodeName == "") = component;
                    opMin(nodeID == node) = opmin1;
                    opMax(nodeID == node) = opmax1;
                    nonOpMin(nodeID == node) = nonopmin1;
                    nonOpMax(nodeID == node) = nonopmax1;

                elseif any(regexp(node,'.\d*$')) == 1 && count(node, '.') == 2
                    node = erase(node, '.$');                   
                    lengthnode = strlength(node)+1;              
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmax1;

                elseif any(regexp(node,'.\d*..$')) == 1 && count(node, '.') == 3
                    node = erase(node, '..$');
                    lengthnode = strlength(node)+2;             
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmax1;

                elseif any(regexp(node,'.\d*...$')) == 1 && count(node, '.') == 4
                    node = erase(node, '...$');
                    lengthnode = strlength(node)+3;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmax1;

                elseif any(regexp(node,'.\d*....$')) == 1 && count(node, '.') == 5
                    node = erase(node, '....$');
                    lengthnode = strlength(node)+4;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmax1;
                end
            else
                if count(node,'.') == 1
                    node = erase(node, '.$');
                    lengthnode = strlength(node)+1;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = nonopmax1;
                    
                elseif count(node,'.') == 2
                    node = erase(node, '..$');
                    lengthnode = strlength(node)+2;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = nonopmax1;
                    
                elseif count(node,'.') == 3
                    node = erase(node, '...$');
                    lengthnode = strlength(node)+3;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode)  = nonopmax1;
                    
                elseif count(node,'.') == 4
                    node = erase(node, '....$');
                    lengthnode = strlength(node)+4;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmax1;
                    
                    elseif count(node,'.') == 5
                    node = erase(node, '.....$');
                    lengthnode = strlength(node)+5;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode & nodeName == "") = component;
                    opMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmin1;
                    opMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = opmax1;
                    nonOpMin(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmin1;
                    nonOpMax(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = nonopmax1;
                end
            end
            
        elseif any(regexp(node ,'[0-9]')) % if the string does not contain $, but contains a number
            nodeName(nodeID == node) = component;
            opMin(nodeID == node) = opmin1;
            opMax(nodeID == node) = opmax1;
            nonOpMin(nodeID == node) = nonopmin1;
            nonOpMax(nodeID == node) = nonopmax1;
                                    
        else % if the string is just a name and a '.'
            node = erase(node, '.');
            index = contains(nodeID, node);
            nodeName(index) = component;
            opMin(index) = opmin1;
            opMax(index) = opmax1;
            nonOpMin(index) = nonopmin1;
            nonOpMax(index) = nonopmax1;
        end
     
    end

end