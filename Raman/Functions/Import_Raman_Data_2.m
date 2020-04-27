% Import data from the Raman text file 
% By A.Marinov 12/07/2018

% filename - the path and name (all together including type of file) of the
% data set to import. 
% mos - conditional. if false will import data as it is. If true will cut
% at a raman shift of 600 cause MoS2 peaks are below this value. 

function getData = Import_Raman_Data_2(filename,mos2_sample);

char_filename = convertStringsToChars(filename);
long = length(char_filename);
extension = long - 2;
type_of_file = char_filename(extension:long);

if(type_of_file == 'csv')
    
    delimiter = ',';
    
elseif(type_of_file == 'txt')
    
    delimiter = '\t';
    
else
    
    disp('Error - type of file to import not recognised! Check Import_Raman_Data.m')
    return
end

% Format for each line of text:
%   column1: double (%f)
%	column2: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%[^\n\r]';

% Open the text file.
fileID = fopen(char_filename,'r');

% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string',  'ReturnOnError', false);

% Close the text file.
fclose(fileID);

% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

% Create output variable
spot_x = table(dataArray{1:end-1}, 'VariableNames', {'X','Y'});

% Trim data from any negative values
% Return Array of values to user
getData_1 = trim_zero(spot_x);

if (mos2_sample == true)
    getData = eliminate_big_values(getData_1);
else
    getData = getData_1;
end

% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;

end


function marty = trim_zero(a)

%make table into array
T_1 = table2array(a);

%find index of positive elements (includes 0)
B = find(T_1(:,2) >= 0);

%form new array without the negatives
first_marty = T_1(B,1);
second_marty = T_1(B,2);

%check if in correct order
if(first_marty(2) > first_marty(1))
    
    [x,y] = flip_it(first_marty, second_marty);
   
else
    x = first_marty;
    y = second_marty;
end

marty = [x,y];


end

function [alfred, bruce] = flip_it(x,y)

% Order of data - needs to be decreasing

    u = wrev(x);
    z = wrev(y);
    
    alfred = u;
    bruce = z;
    
    clear u z x y

end

function jaime = eliminate_big_values(x);

    [~,u] = min(abs(x(:,1)-600));
    jaime = x(u:end,:);
end