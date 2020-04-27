% Title:    Function - Body of Functions. Data Analysis of XRD from .xye and .csv files
% Author:   A.Marinov
% Date:     19th April 2020
% Version:  A1
% Status:   Working 

% Note:     

%--------------------------------------------------------------------------
function [data_xrd,XRD_figure] = get_meXRDplot(file_spot,my_color,my_xlines,figure_settings)
%--------------------------------------------------------------------------
% Input Handling
%--------------------------------------------------------------------------

% to be filled out!


%--------------------------------------------------------------------------
% Assignment
%--------------------------------------------------------------------------
% Processing
normalised = figure_settings{1};
y_offset = figure_settings{2};

% Graph
my_title = figure_settings{3};
mylegend = figure_settings{4};
mylegend_location = figure_settings{5};

%--------------------------------------------------------------------------
% Getting the data
%--------------------------------------------------------------------------
% Gets the data from the .xye file and saves: theta, counts and error in
% one cell array for later use 

num_entries = length(file_spot); % the number of data sets used in the analysis

for i=1:num_entries
    
data_xrd{i} = xrd_import(file_spot(i));
    
end

%--------------------------------------------------------------------------
%  Color Selection
%--------------------------------------------------------------------------

if (isempty(my_color))
    % No color was assigned 
    my_color = rand(length(file_spot),3); %setting the color scheme - can be changed to fixed ones 

elseif(length(my_color) < num_entries)
    % some colors specified
    for k=length(my_color)+1:num_entries
        my_color(k,:) = rand(1,3); % assign random colors to the remainder of entries
    end
end

%--------------------------------------------------------------------------
% Plotting Figure
%--------------------------------------------------------------------------
XRD_figure = figure;
for j = 1:length(file_spot)
    
    % The data for the whole run
    data_sample = data_xrd{1,j};
    
    % Data broken down
    data_theta = data_sample(:,1);
    data_counts = data_sample(:,2);
%     data_error = data_sample(:,3);
    
    data_counts_max = max(data_counts);
    
    if(normalised==true)
        
        data_counts = data_counts/data_counts_max;
        
    end
    
    plot(data_theta, data_counts + y_offset * (j - 1), 'color', my_color(j,:))
    clear data_sample data_theta data_counts data_counts_max data_error 
    
    if(j == length(file_spot))
    hold off
    else
    hold on
    end
end
    % vertical Lines for peaks 
    if (~isempty(my_xlines))
    for i=1:length(my_xlines)
    hold on 
    xline(my_xlines(i),'-',num2str(my_xlines(i)));
    end
    end

xlabel('2$\theta$ ($\deg$)','Interpreter','latex')
ylabel('arb. intensity','Interpreter','latex')
title(my_title, 'Interpreter','latex')
grid on

if(length(mylegend) < 1)
[~, hobj, ~, ~] = legend(print_runs(file_spot), 'Interpreter','latex', 'Location', mylegend_location);
else
[~, hobj, ~, ~] = legend(mylegend, 'Interpreter','latex', 'Location', mylegend_location);
end

% Makes the lines in legend thicker
legend_line_width = findobj(hobj,'type','line');
set(legend_line_width,'LineWidth',3);

end %function

%--------------------------------------------------------------------------
% Functions
%--------------------------------------------------------------------------

% i. Automatic Labelling of legend of multi-plot
function print_the_legend = print_runs(runs)

    for k = 1:length(runs)
        print_the_legend{k} = ['Run ',num2str(k)];
    end
end