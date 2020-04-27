
% Title:    Data Analysis of Raman Samples
% Author:   A.Marinov
% Date:     10th March 2019
% Version:  A2
% Status:   Redevelopment of Summer Studentship Code

% Function: This is the main function of the code. It executes all the
%           lower level functions. This includes: 1. import of data, 2. 
%           smoothing of data and peak identification (not ideal), 3. 
%           generating the plot function to be used

%                                      filename, file path, peak_threshold, poly order, framlength , mos2 sample, color   , type of line                                    
function [] = RAMAN_Raw_plot(filename, file_path, color_me, mos2_sample)
% Control Panel
%--------------------------------------------------------------------------

% testing
% peak_threshold = 7;
% poly_order = 9;
% fram_length = 31; % must be odd value
% mos2_sample = false;

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 1. Import data - script
full_filename = strcat(file_path,filename);
raman_data = Import_Raman_Data_2(full_filename, mos2_sample);       %imports data from selected file
x = raman_data(:,1);
y = raman_data(:,2);

plot(x,y, 'color', color_me);

end