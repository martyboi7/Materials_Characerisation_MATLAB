
% Title:    Data Analysis of Raman Samples
% Author:   A.Marinov
% Date:     12th Dec 2019
% Version:  A2
% Status:   Redevelopment of Summer Studentship Code

% Function: This is the main function of the code. It executes all the
%           lower level functions. This includes: 1. import of data, 2. 
%           smoothing of data and peak identification (not ideal), 3. 
%           generating the plot function to be used

%           Another note to self. The max of each plot is not 1, because we
%           are seeing the smoothened data. Which resilts in a decrease of
%           the peak intensity as it get rounded off a little. 

%                                      filename, peak_threshold, poly order, framlength , mos2 sample, color   , type of line, whether to normalise or not?                                    
function plotty_raman = RAMAN_Master_get_Raman_Plot_v2_20200213(full_filename, normalisation, color_me, dash, peak_settings)
% Control Panel
%--------------------------------------------------------------------------
switch nargin
    case 1 
        normalisation = true;
        color_me = 'g';
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;

    case 2
        color_me = 'g';
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        
    case 3 
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        
    case 4
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        
    case 5
        
        peak_threshold = peak_settings(1);
        poly_order = peak_settings(2);
        fram_length = peak_settings(3); % must be odd value
        mos2_sample = peak_settings(4);
        print_peaks = peak_settings(5);      
end

%--------------------------------------------------------------------------
%--------------------------------------------------------------------------
% 1. Import data - script
raman_data = Import_Raman_Data_2(full_filename, mos2_sample);       %imports data from selected file
clear filename;

% Normalising the data inputted 
if (normalisation == true)
    raw_max = max(raman_data(:,2));
    raman_data(:,2) = raman_data(:,2) / raw_max;
end

% 2. Find the peaks within the data and smoothen data - script
[raw_shift, raw_accounts, smooth_account, peak_locations, raman_peaks, test_loc, test_peak, peaks_width] = get_Raman_Peaks(raman_data, peak_threshold, poly_order, fram_length);
clear raman_data;                               %finds the locations of the peaks and smoothens the data


% 3. Generate plot
plotty_raman = plot(raw_shift, smooth_account, dash, 'color', color_me);
if(print_peaks == true)
    hold on
    plot(peak_locations,raman_peaks,'*','color','green')
    hold on
    get_Peak_Location_String(raman_peaks, peak_locations, 0.03*max(raman_peaks))
end

end


% Other functions

function get_Peak_Location_String(peaks_raman_data, peaks_location_x, height)

str_entry = num2str(peaks_location_x);

for i=1:length(peaks_raman_data)
    
    %need to find when the . is
    [a(i) b(i)] = strread(str_entry(i,:), '%s %s', 'delimiter','.');
    text(peaks_location_x(i),peaks_raman_data(i) + height,a(i),'HorizontalAlignment','left');

end

end