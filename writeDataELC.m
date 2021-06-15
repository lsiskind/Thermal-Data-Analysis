function writeDataELC
clear
clc
close all
tic
% -------- read in files from V8 ELC--------
filedir = '/Users/lsiskind/Documents/projects/Thermal Data/v8 ELC/'; % Lena's Mac Setup
filePattern = fullfile('./','v8 ELC','*.xlsx'); %current directory, v8 ELC folder
files = dir(filePattern);

namecell = cell(length(files),1); % store names of excel files
dataStore = cell(1,length(files)); % where we store the text files

updateStr = ''; %For progress update text
for i=1:length(files)
    
filename = files(i);
namecell{i} = filename.name;


% pivot data - change this to iterate through the files later on
data = readtable([filedir namecell{i}],'VariableNamingRule','Preserve');
M = pivotData(data);

Timestamp = M.Times; % double
nodeID = string(M.NodeID); %string
nodeValue = M.NodeValue; % double

% [nodeName, opMin, opMax, nonopMin, nonopMax] = crossref(nodeID); % cell vectors
[name, version, location, attitude, YPR, beta, life, tempExtreme, Case] = getNamesELC(namecell);

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
writetable(T, 'thermalDataELC_ind.txt');

fid = fopen('thermalDataELC_ind.txt');
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

thermalData = [dataStore{1}; dataStore{2}; dataStore{3}; dataStore{4}; dataStore{5}; dataStore{6}; dataStore{7}; 
                dataStore{8}; dataStore{9}; dataStore{10}; dataStore{11}; dataStore{12}; dataStore{13}; dataStore{14};
                dataStore{15}];

% Write to file 
fid = fopen('thermalDataELC.txt','wt') ;
fprintf(fid,'%s\n',thermalData{:});
fclose(fid);

toc

% % REad file1 
% fid = fopen(file1,'rt') ;  
% S1 = textscan(fid,'%s','delimiter','\n') ;
% S1 = S1{1} ;
% fclose(fid) ;
% % Read file2 
% fid = fopen(file2,'rt') ;
% S2 = textscan(fid,'%s','delimiter','\n') ;
% S2 = S2{1} ;
% fclose(fid) ;
% % Append both the files 
% S12 = [S1 ; S2] ;
% 
% fid = fopen('data.txt','wt') ;
% fprintf(fid,'%s\n',S12{:});
% fclose(fid);

%-------------- make txt file using fscanf--------------
% fileID = fopen('thermalData.txt','w');
% 
% % titles
% fprintf(fileID,'%-48s %-2s','Original FileName','V.');
% fprintf(fileID,'%-4s %-4s %-17s %-6s %-6s %-10s','Loc.','Att.','YPR','Beta','Life','TempExtr');
% fprintf(fileID,'%-11s %-11s %-8s %-8s %-11s %-7s %-7s', 'Case','Timestamp','NodeID','NodeName','NodeValue','OpMin','OpMax');
% fprintf(fileID,'%-10s %-10s\n','NonOpMin','NonOpMax');
% 
% % data
% fprintf(fileID,'%-48s %-2s %-4s %-4s %-17s %-6s %-6s %-10s %-11s', fileInfo);
% fprintf(fileID,'%-48s %-2s %-4s %-4s %-17s %-6s %-6s %-10s %-11s %-11f %-8s  %-11f\n', fileInfo,timestamp, nodeID, nodeValue); 

% fill in data
% fprintf(fileID,'%-11f %-9s %-9s %-12f\n',timestamp, nodeID, nodeName, nodeValue);


% fclose(fileID);
