% Title:    Selects whether we are dealing with an .xye file
% Author:   A.Marinov
% Date:     8th Jan 2020
% Version:  A1
% Status:   Working

function data_export = xrd_xye_import(filename, startRow)

if nargin < 2
    startRow = 2;
end

% Specifies the format of the data to be imported as all doubles 
formatSpec = '%8f%10f%f%[^\n\r]';

% Gets the data using fopen to read a textfile
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

% Generates a table (because I have no idea how to avoid this step) and
% then makes the table into an array that I can actually use 
dataTable = table(dataArray{1:end-1});
data_export = table2array(dataTable);
end

