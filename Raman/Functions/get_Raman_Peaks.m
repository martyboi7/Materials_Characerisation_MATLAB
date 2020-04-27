
% Title:    Data Analysis of Raman Samples
% Author:   A.Marinov
% Date:     10th March 2019
% Version:  A2
% Status:   Redevelopment of Summer Studentship Code

% Purpose:  Smoothens data and finds the peaks for the Raman data

% Note:     Summer code was too messy and not applicable to everything. 
%           Need a general function which can contatenate plots or have 
%           multiple plots at the same time.

function [x, y, smoothY, location, pks_1, test_locs, pks_2, width_1, width_2] = get_Raman_Peaks(Data,threshold, poly_order, framelength)

x = Data(:,1);
y = Data(:,2);

% Smooth out the Data
% NOTE: Location of peaks found is super sensitive to the order of
% polynomialy and framelength used for the noise reduction

% Using a Savitzky-Golay smoothing filter:
% Source:   https://uk.mathworks.com/help/signal/ref/sgolayfilt.html
%           https://uk.mathworks.com/help/curvefit/smoothing-data.html 
smoothY = sgolayfilt(y,poly_order,framelength);

% Find the Raman peaks 
pks_i = findpeaks(smoothY,'Threshold',threshold);

% Finds a threshold which gurantees at least one peak
% [looping,h] = LoopdeLoop(pks_i, y, threshold);
[looping,~] = LoopdeLoop(pks_i, y, threshold);

% Find all the details
[pks_1,locs_1,width_1] = findpeaks(smoothY,'Threshold',looping);
[pks_2,locs_2,width_2] = findpeaks(y,'Threshold',looping);

% Make sure there are some peaks in the sample
location = x(locs_1);
test_locs = x(locs_2);

end

function [ana,t_final] = LoopdeLoop(p,y,t)

    %x is the peaks originally found, y is the smooth
    %data, t is OG threshold
    
    conv = 0.1;
    h = 1;
    
    %check for conditions
    b = length(p);
    
    if(b >= 1)
            
            check = true;
            
        else 
            
            check = false;
            
    end
    
    while(check == false)
        
        b = length(p);
        
        if(b >= 1)
            
            check = true;
            
        else 
            
            check = false;
            
            t = t - t*conv;
        
            p =  findpeaks(y,'Threshold',t);
        
            h = h + 1;
        
        end
        
        
        if(h > 3000)
           
            return
            
        end
    end
    
    t_final = t;
    ana = t;
end
