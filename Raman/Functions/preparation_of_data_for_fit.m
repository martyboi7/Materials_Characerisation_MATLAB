
% Data prep needed for Gauss_Auto and plot_Raman scripts

function [gauss_x, gauss_y] = preparation_of_data_for_fit(x,y,location,width)

% Find the start and end of each of the peaks - using the widths imported

    half_width = width / 2;

    gap_end = location - half_width;
    gap_start = location + half_width;

% Find the range of x for which the peak takes place
    
    [~,index_start] = min(abs(x' - gap_start));
    [~,index_end] = min(abs(x' - gap_end));
    
    range_peak_x = x(index_start:index_end);
    range_peak_y = y(index_start:index_end);

% Fit: 'untitled fit 1'.
    [gauss_x, gauss_y] = prepareCurveData(range_peak_x, range_peak_y);

end