% Title:    Data Analysis of Raman Samples
% Author:   A.Marinov
% Date:     16th April 2020
% Version:  A1
% Status:   Redeveloping

% Note:     Making a body of function approach

function Raman_scan_BodyofFunctions(file_spot,raman_settings,normalised,plot_type,figure_settings,my_color)
%--------------------------------------------------------------------------
% Input Hadling
%--------------------------------------------------------------------------
% To be completed!
switch nargin
    case 1
        raman_settings = [0.002,9,31,false,false]; % making an array of all the settings above
        normalised = true;
        plot_type = 2;
        figure_settings = {0,'Raman Plot X', 'northwest', 'Run', 'My Run', [0 3200 0 1]};
        my_color = 'b';
    case 2
        normalised = true;
        plot_type = 2;
        figure_settings = {0,'Raman Plot X', 'northwest', 'Run', 'My Run', [0 3200 0 1]};
        my_color = 'b';
    case 3
        plot_type = 2;
        figure_settings = {0,'Raman Plot X', 'northwest', 'Run', 'My Run', [0 3200 0 1]};
        my_color = 'b';
    case 4
        figure_settings = {0,'Raman Plot X', 'northwest', 'Run', 'My Run', [0 3200 0 1]};
        my_color = 'b';
    case 5
        my_color = 'b';
end

if(nargin < 1)
    return
end
%--------------------------------------------------------------------------
% Data assignment - taking values out of figure_settings
%--------------------------------------------------------------------------
    % Key figure settings
    y_offset = figure_settings{1};
    my_title = figure_settings{2};
    mylegend_location = figure_settings{3};
    auto_numbering_word = figure_settings{4};
    
    % These might not be assigned
    mylegend = figure_settings{5};
    axis_limits = figure_settings{6};
    my_xlines = figure_settings{7};
%--------------------------------------------------------------------------
% Data Plotting
%--------------------------------------------------------------------------
    % i. Color selection
    num_entries = length(file_spot);
    my_color = getmecolor(my_color,num_entries);
    
    Raman_the_figure = figure;
    for j = 1:length(file_spot)
        
        total_offset(j) = y_offset * (j-1); % settign the offset
        RAMAN_Master_get_Raman_Plot_v3_20200213(file_spot(j), normalised, plot_type, my_color(j,:), '-', raman_settings,total_offset(j));

        if(j == length(file_spot))
        hold off
        else
        hold on
        end
    end
    if (~isempty(my_xlines))
    for i=1:length(my_xlines)
    hold on 
    xline(my_xlines(i),'-',num2str(my_xlines(i)));
    end
    end
    
    h = findobj(gca,'Type','line'); % find the plots
    
    %     left right down up
    axis(axis_limits)
    title(my_title,'Interpreter','latex')

    if(length(h) == num_entries)
        if(length(mylegend) < 1)
        legend(print_runs(file_spot,auto_numbering_word),'Location','Northeast','Interpreter','latex');
        else
        legend(mylegend,'Location','Northeast','Interpreter','latex');
        end
    else
        if(length(mylegend) < 1)
        legend(h(num_entries*2:-2:2),print_runs(file_spot,auto_numbering_word),'Location','Northeast','Interpreter','latex');
        else
        legend(h(num_entries*2:-2:2),mylegend,'Location','Northeast','Interpreter','latex');
        end
    end
    % axis([100 600 0 1]);
    legend(mylegend,'Location',mylegend_location,'Interpreter','latex');
    ylabel('Intensity (arb. units)','Interpreter','latex')
    xlabel('Raman Shift ($cm^{-1}$)','Interpreter','latex')
end 

%--------------------------------------------------------------------------
% Functions

% i. Automatic Labelling of legend of miulti-plot
function print_the_legend = print_runs(runs,my_word)

    for k = 2:length(runs)+1
        print_the_legend{k-1} = [my_word,num2str(k-1)];
    end
end

