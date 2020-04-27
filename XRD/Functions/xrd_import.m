% Title:    Selects whether we are dealing with an .xye file or a .csv file
% Author:   A.Marinov
% Date:     8th Jan 2020
% Version:  A1
% Status:   Working

function data_output = xrd_import(filename, startRow)
    
% Convert the string to a char
    filepath = convertStringsToChars(filename);

% Establish which function to use 
    data_type = filepath(end-2:end);
        
% Choose function

if(data_type == 'csv' | data_type == 'CSV')
    
    if nargin < 2
        startRow = [28, Inf];
    end
    data_output = xrd_csv_import(filename, startRow);
    
elseif(data_type == 'xye' | data_type == 'XYE')
    
    if nargin < 2
        startRow = 2;
    end
    data_output = xrd_xye_import(filename, startRow);
    
else 
    
    disp('Error: Data file not recognised')
    data_output = Nan;
    return
    
end 
    
end 