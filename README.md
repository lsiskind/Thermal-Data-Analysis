# Thermal-Data-Analysis
| Title | Function |
| ------------- | ------------- |
| writeDataELC | Reads in the name and contents of the v8 ELC files. Calls getNamesELC to parce out the filename. Places parced out filename and stacked contents into a text file. Combines the text files of all excel files in the v8 ELC folder. Can be called on its own or within compileAll.m  |
| writeDataSf | Same as writeDataELC by with the Solo Flight files. |
| writeDataTrans | Same as writeDataELC but with the v8 Transfer files. |
| getNamesELC | Parces out the filename for the v8 ELC files. Returns the original filename, version, location, attitude, YPR, beta, life, temperature extreme, and case |
| getNamesSF | same as getNamesELC but for SF |
| getNamesTrans | same as getNamesELC but for transfer |
| crossref | cross references the node ID from the previous files with those listed in Emit Component Nodes.xlsx. Maps the node ID with the general node name |
| pivotData | takes in a data table with the node ID, timestamp, and node value and returns stacked data |
| compileAll | compiles all text files returned by writeData functions |
