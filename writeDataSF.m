function writeDataSF

clear
clc
close all

% -------- read in files from V8 Solo Flight--------
filedir = '/Users/lsiskind/Documents/projects/Thermal Data/v8 Solo Flight/'; % Lena's Mac Setup
filePattern = fullfile('./','v8 Solo Flight','*.xlsx'); %current directory, v8 ELC folder
files = dir(filePattern);

namecell = cell(length(files),1);
dataStore = cell(1,length(files)); % where we store the text files

updateStr = ''; %For progress update text
for i=1:length(files)
    
    filename = files(i);
    namecell{i} = filename.name;


    % pivot data - change this to iterate through the files later on
    data = readtable([filedir namecell{i}],'VariableNamingRule','Preserve');
    M = pivotData(data);

    Timestamp = M.Times; % double,units of hours
    nodeID = string(M.NodeID); %string
    nodeValue = M.NodeValue; % double
    
    % convert time units
    Timestamp = Timestamp.*60.*60; % seconds
    
    [nodeName] = crossref(nodeID);

    % shorten all vectors to only the first four nodes of each component
    isempty = "";
    index = find(nodeName == isempty);
    nodeName(index) = [];
    Timestamp(index) = [];
    nodeID(index) = [];
    nodeValue(index) = [];

    % shorten to just four nodes per component
    uniquecomps = unique(nodeName, 'stable');

    for j = 1:length(uniquecomps)

        nodeNames0 = nodeName(Timestamp == Timestamp(1));
        wherecomps = nodeNames0 == uniquecomps(j);

        if sum(wherecomps) > 4
            allnodes = nodeID(wherecomps);
            extranodes = allnodes(5:end);                
            where2delete = ismember(nodeID, extranodes);
            deleteIndices = find(where2delete);              
            nodeName(deleteIndices) = [];
            Timestamp(deleteIndices) = [];
            nodeID(deleteIndices) = [];
            nodeValue(deleteIndices) = [];
        end    
    end

    % [nodeName, opMin, opMax, nonopMin, nonopMax] = crossref(nodeID); % cell vectors
    [name, version, location, attitude, YPR, beta, life, tempExtreme, Case] = getNamesSF(namecell(i));

    [rows, ~] = size(nodeName);
    fileInfo = strings(rows,9);
    fileInfo(:,1) = name;
    fileInfo(:,2) = version;
    fileInfo(:,3) = location;
    fileInfo(:,4) = attitude;
    fileInfo(:,5) = YPR;
    fileInfo(:,6) = beta;
    fileInfo(:,7) = life;
    fileInfo(:,8) = tempExtreme;
    fileInfo(:,9) = Case;

    %------- place into text file ----------------
    Name = fileInfo(:,1);
    Version = fileInfo(:,2);
    Location = fileInfo(:,3);
    Attitude = fileInfo(:,4);
    YPR = fileInfo(:,5);
    Beta = fileInfo(:,6);
    Life = fileInfo(:,7);
    Temperature_Extreme = fileInfo(:,8);
    Case = fileInfo(:,9);

    T = table(Name, Version, Location, Attitude, YPR, Beta, Life, Temperature_Extreme, Case, Timestamp, nodeID, nodeName, nodeValue);
    writetable(T, 'thermalDataSF_ind.txt');

    fid = fopen('thermalDataSF_ind.txt');
    S1 = textscan(fid,'%s','delimiter','\n');
    S1 = S1{1};
    S1(1) = []; % remove headers
    dataStore{i} = S1; 
    fclose(fid);

    percentDone = 100*i/(length(files));
    msg = sprintf('Percent Completion: %0.1f\n',percentDone);
    fprintf([updateStr msg])
    updateStr = repmat(sprintf('\b'),1,length(msg)); %Deletes previous msg so that only current msg is visible
end

thermalData = [dataStore{1}; dataStore{2}];

% Write to file 
fid = fopen('thermalDataSF.txt','wt') ;
fprintf(fid,'%s\n',thermalData{:});
fclose(fid);



