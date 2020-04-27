%--------------------------------------------------------------------------
% Title:    Color Palate
% Author:   A.Marinov
% Date:     2nd Feb 2020
% Version:  A1
% Status:   Works

% Note:   
%                               color to check, number of inputs
function my_color = getmecolor(color_input,num_entries)

    if (isempty(color_input))
        % No color was assigned 
        my_color = rand(num_entries,3); %setting the color scheme - can be changed to fixed ones 

    elseif(length(color_input) < num_entries)
        % some colors specified
        for k=1:num_entries
            if (k <= length(color_input))
                my_color(k,:) = color_input(k,:);
            else
            my_color(k,:) = rand(1,3); % assign random colors to the remainder of entries
            end
       end
    else 
        my_color = color_input;
    end