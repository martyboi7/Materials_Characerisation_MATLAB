
% Plot of the results, post smoothing and peaks

function figure_raman = plot_Raman(x,y,smoothY,location,pks_1,width,top)

% Trigger the Gauss to create plot functions 

for i = 1:length(location)
    
    [xData, yData] = preparation_of_data_for_fit(x,smoothY,location(i),width(i));
    eval(['a' num2str(i) '= Gauss_Auto(x, smoothY, location(i), width(i));']);
    
    x_data{i} = xData(:,1);
    y_data{i} = yData(:,1);   
    clear xData yData;
end  

    clear i;
    
% Find the height above point to use for the peaks
henry = max(pks_1);
height_plot = henry * 0.03;

% Find the axis limts 
left_1 = min(x);
right_1 = max(x);
top_1 = henry + 0.4 * henry;
bot_1 = 0;

limit_axis = [left_1, right_1, bot_1, top_1];
clear left_1 right_1 top_1 bot_1

% Use peak location to decide legend location
bobby = legend_location(x, location, pks_1);

% Plot Figure
figure_raman = figure('Name','Magical Plot 1')
% plot(x,y)
% hold on
plot(x,smoothY)
hold on
plot(location,pks_1,'*','color','green')
hold on
get_Peak_Location_String(pks_1, location, height_plot)

if(plot_gauss == true)
hold on
for j = 1:length(location)
    plot(eval(['a' num2str(j)]))
end
hold off
else
    hold off
end

xlabel('Raman Shift (cm^-^1)')
ylabel('Intensity (arb. units)')
title(top)
legend('Original Data', 'Polynomial Fit', 'Peaks', 'Gaussians','Location', bobby)
axis(limit_axis)
grid on


end

function get_Peak_Location_String(peaks_raman_data, peaks_location_x, height)

str_entry = num2str(peaks_location_x);

for i=1:length(peaks_raman_data)
    
    %need to find when the . is
    [a(i) b(i)] = strread(str_entry(i,:), '%s %s', 'delimiter','.');
    text(peaks_location_x(i),peaks_raman_data(i) + height,a(i),'HorizontalAlignment','left');

end

end

function find_me = legend_location(x,loc,peaks)

    [~,i_1] = max(peaks);   %finds the tallest peak
    
    abby = loc(i_1);        %location of max peak
    
    start = min(x);
    ending = max(x);
    
    a_1 = ending - abby;
    a_2 = abby - start;
    
    if(a_1 > a_2)
        
        find_me = 'northeast';
        
    else
        
        find_me = 'northwest';
        
    end

end