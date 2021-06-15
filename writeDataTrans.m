function writeDataTrans

clear
clc
close all

% -------- read in files from V8 Solo Flight--------
filedir = '/Users/lsiskind/Documents/projects/Thermal Data/v8 Transfer/'; % Lena's Mac Setup
filePattern = fullfile('./','v8 Transfer','*.xlsx'); %current directory, v8 ELC folder
files = dir(filePattern);

namecell = cell(length(files),1);
dataStore = cell(1,length(files)); % where we store the text files

updateStr = ''; %For progress update text
for i=1:length(files)
    
    tic
    
    filename = files(i);
    namecell{i} = filename.name;


    % pivot data - change this to iterate through the files later on
    data = readtable([filedir namecell{1}],'VariableNamingRule','Preserve');
    M = pivotData(data);

    Timestamp = M.Times; % double
    nodeID = string(M.NodeID); %string
    nodeValue = M.NodeValue; % double

    % [nodeName, opMin, opMax, nonopMin, nonopMax] = crossref(nodeID); % cell vectors
    [name, version, location, attitude, YPR, beta, life, tempExtreme, Case] = getNamesTrans(namecell);

    [rows, ~] = size(M);
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

    T = table(Name, Version, Location, Attitude, YPR, Beta, Life, Temperature_Extreme, Case, Timestamp, nodeID, nodeValue);
    writetable(T, 'thermalDataTrans_ind.txt');

    fid = fopen('thermalDataTrans_ind.txt');
    S1 = textscan(fid,'%s','delimiter','\n');
    S1 = S1{1};
    S1(1) = []; % remove headers
    dataStore{i} = S1; 
    fclose(fid);

    percentDone = 100*i/(length(files));
    msg = sprintf('Percent Completion: %0.1f\n',percentDone);
    fprintf([updateStr msg])
    updateStr = repmat(sprintf('\b'),1,length(msg)); %Deletes previous msg so that only current msg is visible
    toc
end

thermalData = [dataStore{1}; dataStore{2}; dataStore{3}; dataStore{4}; dataStore{5};
                dataStore{6}; dataStore{7}; dataStore{8}];

% Write to file 
fid = fopen('thermalDataTrans.txt','wt') ;
fprintf(fid,'%s\n',thermalData{:});
fclose(fid);