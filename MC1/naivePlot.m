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
             HOUR = str2double(extractBefore(extractAfter(date.('time'),' '),':'));
             hourIndex(HOUR+1,1,j) = i;
             previousH = HOUR;
             firstRun = false;
             continue;
        end

         HOUR = str2double(extractBefore(extractAfter(date.('time'),' '),':'));

         if(HOUR ~= previousH)

              hourIndex(HOUR,2,j) = i-1;
              hourIndex(HOUR+1,1,j) = i;
              
         end

        previousH = HOUR;

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
        for n = 1:size(hourIndex,1)              %looping trough the hour

            classicMean(n,j,cat) = mean(dataArray(hourIndex(n,1,j):hourIndex(n,2,j),cat));

        end
    end
end

   
%%% plotting the data %%%
% figure
 bar3(classicMean(:,:,6))

%title('Detached Style')% xlabel('Mean over each hour') ;
%ylabel('Shake Intensity') ;
%legend({'y = Day 1','y = Day 2','y = Day 3','y = Day 4','y = Day 5'},'Location','northeast')


%% mean per District
%Zone mean  stores the mean per hour per district and category.
%hour/zone/day/cat
zoneMean = cell(24,19,6);
%cat/


%Loop over all days
for day =1:size(splitData,2)
    %Get the start and end index for that day
    start_ = splitData(1,day).start;
    end_ =splitData(1,day).end;
    
    spatialCat = zeros(24,6,19);
    counterLocation = zeros(19,24);
    %Which hour are we on
    hh_counter = 1;
    %Loop from start to end for a day
    for index =start_:end_      
        %If the index is the same as the end of that hourIndex, increment the counter  
        if( index == hourIndex(hh_counter,2,day))
            %increase values and counter
            spatialCat(hh_counter,:,dataArray(index,7)) = spatialCat(hh_counter,:,dataArray(index,7))+dataArray(index,1:6);
            counterLocation(dataArray(index,7),hh_counter)=counterLocation(dataArray(index,7),hh_counter) + 1;
            
            hh_counter = hh_counter +1;
        else
            %Add the numbers for each catogory to the data and increase the
            %counter for that location
            spatialCat(hh_counter,:,dataArray(index,7)) =spatialCat(hh_counter,:,dataArray(index,7)) + dataArray(index,1:6);
            counterLocation(dataArray(index,7),hh_counter)=counterLocation(dataArray(index,7),hh_counter) + 1;        
        end
    end
    
    %Divid by counter and add to the data, must loop because counter could
    %be 0
    for hh = 1:24
       for cc =1:19 
           if(counterLocation(cc,hh) ~=0)
               zoneMean{hh, cc,day} = spatialCat(hh,:,cc)./counterLocation(cc,hh);
           else
               zoneMean{hh, cc,day} = [0 0 0 0 0 0];
           end
       end
    end 
end



%% Creates a compilation of how many reports are flowing in each hour
% hour/days/category
reportAmount = [];
for cat = 1:size(dataArray,2) %looping all categories
    for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        for n = 1:size(hourIndex,1)               %looping trough the hour
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

 %bar3(reportAmount(:,:,6))
 
 %% Amount of reports from each 
 %%zoneVotes consists of number of votes accumulated from one zone during
 %%each hour.
 %hour/day/zone
 zoneVotes = cell(24,5,19);
 zoneVotes(:,:,:) = {0};

    for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        for n = 1:size(hourIndex,1)-1               %looping trough the hour
            for allHourIndexes = hourIndex(n,1,j):hourIndex(n,2,j) %loop trough all actions in the hour
             
                for zone = 1:19
                    if(dataArray(allHourIndexes,7) ~= zone)
                        continue;
                    end
                    zoneVotes{n,j,zone} = zoneVotes{n,j,zone} +1;
                    break;
                end
                
            end

        end
    end
clear n;
clear j;
clear zone;

counter = 1;
   for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        for n = 1:size(hourIndex,1)               %looping trough the hour
                
                for zone = 1:19
                    
                    DAY(counter) = j;
                    HOUR(counter) = n;
                    ZONE(counter) = zone;
                    C(counter) = zoneVotes{n,j,zone};
                counter = counter +1;
                end  
        end
   end
   
  cMap = parula(256);
  dataMax = max(C);
  dataMin = 0;
  centerPoint = 1;
  scalingIntensity = 5;
  
  x = 1:length(cMap); 
  x = x - (centerPoint-dataMin)*length(x)/(dataMax-dataMin);
  x = scalingIntensity * x/max(abs(x));
  
  x = sign(x).* exp(abs(x));
  x = x - min(x); x = x*511/max(x)+1; 
  newMap = interp1(x, cMap, 1:512);
  
   
figure
scatter3(DAY,ZONE,HOUR,300,C,'filled')
colorbar('Location', 'EastOutside', 'YTickLabel',...
    {'0','.5k', '~1k', '~1.5k ','~2k', '~2.5k', ...
     '~3k', '~3.5k', '4490 votes'})
 
title('Amount of reports')
xlabel('Days')
ylabel('Zone')
zlabel('Hour')
colormap(newMap);

%% COLORMAP



  load cape;
  figure; imagesc(X);
  figure; imagesc(X);  colormap(newMap);
    