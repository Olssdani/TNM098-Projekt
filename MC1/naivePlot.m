
%Loop trough first day and makes indexes


hourIndex = [];
% J index stands for the day 
for j = size(splitData,1):size(splitData,2)
      firstRun = true;
      previousH = 0;
    for i = splitData(j).("start"):splitData(j).("end")

        date = data(i,1);

        if(firstRun)
             hour = str2double(extractBefore(extractAfter(date.('time'),' '),':'));
             hourIndex(hour+1,1,j) = i;
             previousH = hour;
             firstRun = false;
             continue;
        end

         hour = str2double(extractBefore(extractAfter(date.('time'),' '),':'));

         if(hour ~= previousH)

              hourIndex(hour,2,j) = i-1;
              hourIndex(hour+1,1,j) = i;
              
         end

        previousH = hour;

    end
end
clear previousH
clear hour
clear firstRun 
clear i
clear date

%Hour index is indexed with startindext at (:,1,j) and last index on that
%hour at (:,2,j)

%% Extracting mean

dataArray =table2array(data(:,2:8));
dataArray(isnan(dataArray))=0; %%removes NaN
for j = size(splitData,1):size(splitData,2)-1
    for n = 1:size(hourIndex,1)-1
    
        classicMean(n,j) = mean(dataArray(hourIndex(n,1,j):hourIndex(n,2,j),6))
    end
end

y = [];
for j = size(splitData,1):size(splitData,2)-1
    hold on
    x = [1:1:n];
    y = [ y  classicMean(:,j)];
    
end
%plot(x, y)
   % xlabel('Mean over each hour') ;
    %ylabel('Shake Intensity') ;
    %legend({'y = Day 1','y = Day 2','y = Day 3','y = Day 4','y = Day 5'},'Location','northeast')
figure
bar3(y)
title('Detached Style')