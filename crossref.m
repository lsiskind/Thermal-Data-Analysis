function [nodeName] = crossref(nodeID)

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

% output a vector of component names the size of nodeID
[rows, ~] = size(nodeID);
nodeName = strings(rows,1);

for i = 1:rows_nodeList
    component = componentnames(i);
    nodevec = nodeList(i,:); 
    
    % only care about first four nodes, the rest leave empty
    if length(nodevec)>4
        nodevec = nodevec(1:4);
    end
    
    for j = 1:length(nodevec)
        
        node = nodevec(1,j);

        if contains(node, '$') == 1
        
            if contains(node, digitsPattern)
                if any(regexp(node,'.\d*$')) == 1 && count(node,'.') == 1
                    node = erase(node, '$');
                    nodeName(nodeID == node) = component;

                elseif any(regexp(node,'.\d*$')) == 1 && count(node, '.') == 2
                    node = erase(node, '.$');                   
                    lengthnode = strlength(node)+1;              
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;

                elseif any(regexp(node,'.\d*..$')) == 1 && count(node, '.') == 3
                    node = erase(node, '..$');
                    lengthnode = strlength(node)+2;             
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;

                elseif any(regexp(node,'.\d*...$')) == 1 && count(node, '.') == 4
                    node = erase(node, '...$');
                    lengthnode = strlength(node)+3;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;

                elseif any(regexp(node,'.\d*....$')) == 1 && count(node, '.') == 5
                    node = erase(node, '....$');
                    lengthnode = strlength(node)+4;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;              
                end
            else
                if count(node,'.') == 1
                    node = erase(node, '.$');
                    lengthnode = strlength(node)+1;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;
                elseif count(node,'.') == 2
                    node = erase(node, '..$');
                    lengthnode = strlength(node)+2;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;
                elseif count(node,'.') == 3
                    node = erase(node, '...$');
                    lengthnode = strlength(node)+3;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;
                elseif count(node,'.') == 4
                    node = erase(node, '....$');
                    lengthnode = strlength(node)+4;
                    nodeName(contains(nodeID, node) & strlength(nodeID) <= lengthnode) = component;
                end
            end
            
        elseif any(regexp(node ,'[0-9]')) % if the string does not contain $, but contains a number
            nodeName(nodeID == node) = component;
                                    
        else % if the string is just a name and a '.'
            node = erase(node, '.');
            index = contains(nodeID, node);
            nodeName(index) = component;
        end
     
    end



end