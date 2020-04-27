% Title:    Data Analysis of Raman Samples
% Author:   A.Marinov
% Date:     16th April 2020
% Version:  A2
% Status:   Redevelopment of Summer Studentship Code

% Function: This is the main function of the code. It executes all the
%           lower level functions. This includes: 1. import of data, 2. 
%           smoothing of data and peak identification (not ideal), 3. 
%           generating the plot function to be used

%           Another note to self. The max of each plot is not 1, because we
%           are seeing the smoothened data. Which resilts in a decrease of
%           the peak intensity as it get rounded off a little. 

%                                      
function plotty_raman = RAMAN_Master_get_Raman_Plot_v3_20200213(full_filename, normalisation, plot_type, color_me, dash, peak_settings,y_offset)
% Control Panel
%--------------------------------------------------------------------------
switch nargin
    case 1 
        plot_type = 1;
        normalisation = true;
        color_me = 'g';
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        y_offset = 0;
        
    case 2
        plot_type = 1;
        color_me = 'g';
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        y_offset = 0;
        
    case 3 
        color_me = 'g';
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        y_offset = 0;
        
    case 4
        dash = '-';
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        y_offset = 0;
        
    case 5
        
        peak_threshold = 7;
        poly_order = 9;
        fram_length = 31; % must be odd value
        mos2_sample = false;
        print_peaks = false;
        y_offset = 0;
        
    case {6,7}
        
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
[raw_shift, raw_accounts, smooth_account, peak_locations, raman_peaks, test_loc, test_peak, peaks_width, test_width] = get_Raman_Peaks(raman_data, peak_threshold, poly_order, fram_length);
clear raman_data;                               %finds the locations of the peaks and smoothens the data

% finding only the peaks and location that surpass a certain criteria
if (normalisation == true)
   
    % finds only peaks that beat the threshold in intensity of 0.4 on the normalised
    % plot
    index_high_peaks = find(raman_peaks > 0.4);
    index_high_peaks_raw = find(test_peak > 0.4);
    
    % smooth
    raman_peaks = raman_peaks(index_high_peaks);
    peak_locations = peak_locations(index_high_peaks);
    peaks_width = peaks_width(index_high_peaks);
    
    % raw
    test_peak = test_peak(index_high_peaks_raw);
    test_loc = test_loc(index_high_peaks_raw);
    test_width = test_width(index_high_peaks_raw);

end



% NOTE: The test notation is actually the peaks and locations and width for
% the raw data


% 3. Generate plot
if(plot_type == 3 && isempty(peak_locations))
    disp('No Peaks have been detected - change thresholds or there may be no peaks. Displaying raw data in plot.')
    plot_type = 1;
end    

switch plot_type
    case 1 % plots just the raw data 
        plotty_raman = plot(raw_shift, raw_accounts + y_offset, dash, 'color', color_me);
        if(print_peaks == true && isempty(peak_locations) == 0)
            hold on
            plot(test_loc,test_peak + y_offset,'*','color','green')
            hold on
            get_Peak_Location_String(test_peak + y_offset, test_loc, 0.03*max(test_peak))
        end
    case 2 % plots just the smooth line 
        plotty_raman = plot(raw_shift, smooth_account + y_offset, dash, 'color', color_me);
        if(print_peaks == true && isempty(peak_locations) == 0)
            hold on
            plot(peak_locations,raman_peaks + y_offset,'*','color','green')
            hold on
            get_Peak_Location_String(raman_peaks + y_offset, peak_locations, 0.03*max(raman_peaks))
        end
    case 3 % only for a single plot on a figure. Plots gaussians under the peaks detected
        plotty_raman = plot(raw_shift, raw_accounts + y_offset, dash, 'color', color_me);
        if(print_peaks == true && isempty(peak_locations) == 0)
            hold on
            plot(test_loc,test_peak + y_offset,'*','color','green')
            hold on
            get_Peak_Location_String(test_peak + y_offset, test_loc, 0.03*max(test_peak))
        end
        
        for i = 1:length(test_loc)
        [a,~,~] = Gauss_Auto(raw_shift,raw_accounts,test_loc(i), test_width(i));
        hold on 
        plot(a)
        end
        
    case 4 % only for a single plot on a figure. Plots gaussians under the peaks detected
        plotty_raman = plot(raw_shift, smooth_account + y_offset, dash, 'color', color_me);
        if(print_peaks == true && isempty(peak_locations) == 0)
            hold on
            plot(peak_locations,raman_peaks + y_offset,'*','color','green')
            hold on
            get_Peak_Location_String(raman_peaks + y_offset, peak_locations, 0.03*max(raman_peaks))
        end
        
        for i = 1:length(test_loc)
        [a,~,~] = Gauss_Auto(raw_shift,smooth_account,peak_locations(i), peaks_width(i));
        hold on 
        plot(a)
        end
        
        
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