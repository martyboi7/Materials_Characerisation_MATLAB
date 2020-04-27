
% Title:    Data Analysis of XRD from .xye and .csv files. 
% Author:   A.Marinov
% Date:     19th April 2020
% Version:  A1
% Status:   Working 

% Note:     

% Sample:   XX?

close all
clear all

addpath ..\Functions

%--------------------------------------------------------------------------
% DATA to be Analysed
%--------------------------------------------------------------------------
% File paths
file_spot = [];
% e.g file_spot = ["C:\Users\...\XRD Data\run1.csv"
%                  "C:\Users\...\XRD Data\run2.csv"];
%--------------------------------------------------------------------------
% Control Panel 
%--------------------------------------------------------------------------
% i. Plot settings
my_title = 'XRD of Samples'; % title for plot
mylegend = {}; %legend entries
mylegend_location = 'EastOutside'; %legend location
%            r    g    b
my_color = [0.0, 0.0, 0.0;  %black 
            0.0, 1.0, 0.0;  %green 
            0.0, 0.0, 1.0;  %blue
            1.0, 0.0, 0.0;  %red 
            1.0, 0.2, 0.8;  %pink
            0.0, 0.75, 1.0; %light blue
            0.5, 0.2, 0.7;  %purple
            ];
        % change colors according to preference. If color empty, automatic
        % random allocation. 
            
% ii. Normalisation and Offset (stacked)
normalised = true; % normalise data with largest data point in data set
y_offset = 1; % offset for plots - one works best. Different value may be problematic with axis_limits
plot_selection = []; % selects which indeces in file_spot to plot

% iii. Vertical Lines (xlines)
my_xlines = [14.5]; % plots vertical lines with text

%--------------------------------------------------------------------------
% Call to the Functions
%--------------------------------------------------------------------------

if(isempty(plot_selection))
    % Assignment 
    figure_settings = {normalised,y_offset,my_title,mylegend,mylegend_location};
    [data_xrd,my_figure] = get_meXRDplot(file_spot,my_color,my_xlines,figure_settings);
elseif(isempty(mylegend))
    % Assignment 
    figure_settings = {normalised,y_offset,my_title,mylegend,mylegend_location};
    [data_xrd,my_figure] = get_meXRDplot(file_spot(plot_selection),my_color(plot_selection,:),my_xlines,figure_settings);
else
    % Assignment 
    figure_settings = {normalised,y_offset,my_title,mylegend((plot_selection)),mylegend_location};
    [data_xrd,my_figure] = get_meXRDplot(file_spot(plot_selection),my_color(plot_selection,:),my_xlines,figure_settings);
end