% Title:    Data Analysis of Raman Samples
% Author:   A.Marinov
% Date:     16th April 2020
% Version:  A1
% Status:   Working

% Note:     JUST make sure the file path and names are correct. Standard
%           filter settigns applies to any MoS2 sample I use. 
%           Can process file type (.csv or .txt)

% Sample:   XX?

% Modes of operation: plot_type is the key
% 1. - plots raw data - multiple plots
% 2. - plots smooth data - multiple plots
% 3. - plot raw data with gaussian fits under peaks - DOES NOT WORK
% 4. - plot smooth data with gaussian fits under peaks - DOES NOT WORK

    close all
    clear all
    addpath ..\Functions

%--------------------------------------------------------------------------
% Control Panel 
%--------------------------------------------------------------------------
% File paths
file_spot = []; % full file path of individial scans with file type included
% e.g file_spot = ["C:\Users\...\Raman Data\run1.txt"
%                  "C:\Users\...\Raman Data\run2.txt"];

num_entries = length(file_spot); %the number of files loaded 
%--------------------------------------------------------------------------            
% Control Panel - KEY Settings
%--------------------------------------------------------------------------
my_plot_selection = []; %only this selection is ploted - denotes the index of entry in file_spot

normalised = true; % whether nor not to scale the intensity with respect to the max value in the dataset
plot_type = 2; % decide what type of plot to view (see above under Sample for full description)
y_offset = 1; % stacked plot - works for value 1. May encounter issues with other offset because of the axis_limits
print_peaks = false;    % if to put text on the graph
my_xlines = []; % vertical lines to be printed
axis_limits = [0    600  0    y_offset * num_entries]; % axis limits

% Coloring 
my_color = [1.0, 0.0, 0.0;  %red
            1.0, 0.5, 0.1;  %orange
            0.0, 0.0, 1.0;  %blue
            0.5, 0.5, 0.1;  %lighter green
            0.1, 0.5, 0.1   %dark green
            ];
%--------------------------------------------------------------------------
% Graph Controls
%--------------------------------------------------------------------------
% Plot settings
    my_title = 'Title'; %title of plot
    mylegend = {}; %entry of legend {'Entry 1', 'Entry 2'}
    mylegend_location = 'Eastoutside'; %legend location
    auto_numbering_word = 'Run '; %if no legend entried provided in mylegend, autolabelling based on this word

    figure_settings = {y_offset,my_title,mylegend_location,auto_numbering_word,mylegend,axis_limits,my_xlines}; % do not touch
%--------------------------------------------------------------------------
% Peak Analysis Settings
%--------------------------------------------------------------------------
% Filter Settings and Data cut
    peak_threshold = 0.002;    % threshold between adjacent peaks to identify peaks - 0.002 originally
    poly_order_1 = 9;       % order of Savitzky-Golay smoothing filter
    fram_length = 31;       % must be odd value
    mos2_sample = false;    % if true will cut data at 600 cm^-1
    
    raman_settings = [peak_threshold, poly_order_1,fram_length,mos2_sample,print_peaks]; % making an array of all the settings above
%--------------------------------------------------------------------------
% Call the Function
%--------------------------------------------------------------------------
file_spot_selection = file_spot(my_plot_selection); % selects the indexes to plot

if(isempty(file_spot_selection))
    Raman_scan_BodyofFunctions(file_spot,raman_settings,normalised,plot_type,figure_settings,my_color);
else
    axis_limits(4) = y_offset * length(my_plot_selection);
    figure_settings = {y_offset,my_title,mylegend_location,auto_numbering_word,mylegend,axis_limits,my_xlines};
    Raman_scan_BodyofFunctions(file_spot_selection,raman_settings,normalised,plot_type,figure_settings,my_color);
end
