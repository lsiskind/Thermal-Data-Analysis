function [M] = pivotData(data)

[~, columns] = size(data);
M = stack(data,2:columns,'NewDataVariableName','NodeValue','IndexVariableName','NodeID');

end