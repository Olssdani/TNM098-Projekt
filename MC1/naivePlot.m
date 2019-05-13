%This plot displays a mean per hour per area of all the different categorys.
%Loop trough first day and makes indexes
%

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
%classicMean variable is taking a mean of every hour over every category
%during all the days.

dataArray =table2array(data(:,2:8));
dataArray(isnan(dataArray))=0; %%removes NaN

for cat = 1:size(dataArray,2) %looping all categories
    for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        for n = 1:size(hourIndex,1)-1               %looping trough the hour

            classicMean(n,j,cat) = mean(dataArray(hourIndex(n,1,j):hourIndex(n,2,j),cat));

        end
    end
end

   
%%% plotting the data %%%
% figure
 bar3(classicMean(:,:,3))

%title('Detached Style')% xlabel('Mean over each hour') ;
%ylabel('Shake Intensity') ;
%legend({'y = Day 1','y = Day 2','y = Day 3','y = Day 4','y = Day 5'},'Location','northeast')


%% mean per District
%Zone mean  stores the mean per hour per district and category.
%hour/zone/day/cat
zoneMean = cell(24,19,6,7);
%cat/

for cat = 1:size(dataArray,2) %looping all categories
    for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        for n = 1:size(hourIndex,1)-1               %looping trough the hour
            counter = 0;
            localSum = 0;
           for allHourIndexes = hourIndex(n,1,j):hourIndex(n,2,j)
                for zone = 1:19
                    if(dataArray(allHourIndexes,7) ~= zone)
                        continue;
                    end
                    counter= counter +1;
                    localSum = localSum + dataArray(allHourIndexes,cat);
                    break;
                end
                
           end
           localMean = localSum/counter;
           zoneMean(n,zone,j,cat) =  {localMean};
        end
       
    end
    
end
clear counter;
clear localSum;
clear j;
clear localMean;
clear zone;

%% Creates a compilation of how many reports are flowing in each hour
reportAmount = [];
for cat = 1:size(dataArray,2) %looping all categories
    for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        for n = 1:size(hourIndex,1)-1               %looping trough the hour
               localCounter = 0;
            for allHourIndexes = hourIndex(n,1,j):hourIndex(n,2,j) %loop trough all actions in the hour
             
                if (dataArray(allHourIndexes,cat))
                    
                    localCounter = localCounter +1;
                    
                end
                
            end
            reportAmount(n,j,cat) =  localCounter;
           
       
        end
    end
end

 bar3(reportAmount(:,:,6))
    