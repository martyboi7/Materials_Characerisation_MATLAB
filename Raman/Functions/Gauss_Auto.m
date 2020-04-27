function [fitresult, gauss_x, gauss_y] = Gauss_Auto(x, y, location, width)

%  Data for 'untitled fit 1' fit:
%      X Input : Raw X shift
%      Y Output: Smooth Y
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.

% Set up fittype and options.

ft = fittype( 'gauss1' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [-Inf -Inf 0];
opts.StartPoint = [9801.76153867116 449.988 105.752984252603];

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

% % Fit model to data.
fitresult = fit(gauss_x, gauss_y, ft, opts);

end



