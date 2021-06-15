% compile all the text files into one gigantic text file
clear
clc
close all
tic

% write the text files
writeDataELC;
writeDataSF;
writeDataTrans;

% REad file1 
fid = fopen('thermalDataELC.txt','rt') ;  
S1 = textscan(fid,'%s','delimiter','\n') ;
S1 = S1{1} ;
fclose(fid) ;
% Read file2 
fid = fopen('thermalDataSF.txt','rt') ;
S2 = textscan(fid,'%s','delimiter','\n') ;
S2 = S2{1} ;
fclose(fid) ;
% Read file2 
fid = fopen('thermalDataTrans.txt','rt') ;
S3 = textscan(fid,'%s','delimiter','\n') ;
S3 = S3{1} ;
fclose(fid) ;

% Append both the files 
alldata = [S1 ; S2 ; S3] ;
fid = fopen('thermalDataALL.txt','wt') ;
fprintf(fid,'Original FileName, Version, Location, Attitude, YPR, Beta, Life, Temperature Extreme, Case, Timestamp, NodeID, NodeValue\n');
fprintf(fid,'%s\n',alldata{:});
fclose(fid);

toc