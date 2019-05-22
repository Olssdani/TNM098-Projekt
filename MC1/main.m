%Load data
clear all
load data_Sorted.mat
load DayIndex.mat
%load TestData.mat
%load newZoneMean.mat

%% Run data handling
[hourIndex, classicMean,zoneMean, reportAmount,zoneVotes, theBaseline, dataArray] = naivePlot(data, splitData);


%% Show 3d bars over days
bar3(classicMean(:,:,6));



%% Show a 3d box with all values
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
    clear Zone
    clear Days
    clear Hour
    clear x
    clear scalingIntensity
    

%%  Show parallel coord
temporalData = zeros(19,6,24);


for hour= 1:24
    for zone = 1:19
            temporalData(zone,:,hour) = zoneMean{hour,zone,1};
    end
end



for hour= 1:24
    ParallelCord(temporalData(:,:,hour));
    pause(2);
end





%% When did the eartquake appear
 reports = zeros(24,5,1);
for hour = 1:24
    for day =1:5
        for zone = 1:19
            reports(hour, day,1) = reports(hour,day,1) + zoneVotes{hour,day,zone}; 
        end        
    end
end

bar3(reports(:,:,1));




%% Check abnormilities

dag = 4;
zone = 3; 
hh =2;
counter = 1;

for Index= hourIndex(hh,1,dag): hourIndex(10,2,dag)
    if(dataArray(Index,7) == zone)
            tempDay(counter,:) = dataArray(Index,1:6);
            counter = counter+1;
    end
end
tempSum = zeros(11,6);

for i=1:size(tempDay,1)
    
   tempSum(tempDay(i,1)+1,1)= tempSum(tempDay(i,1)+1,1)+1;
   tempSum(tempDay(i,2)+1,2)= tempSum(tempDay(i,2)+1,2)+1;
   tempSum(tempDay(i,3)+1,3)= tempSum(tempDay(i,3)+1,3)+1;
   tempSum(tempDay(i,4)+1,4)= tempSum(tempDay(i,4)+1,4)+1;
   tempSum(tempDay(i,5)+1,5)= tempSum(tempDay(i,5)+1,5)+1;
   tempSum(tempDay(i,6)+1,6)= tempSum(tempDay(i,6)+1,6)+1; 
end
counter =1;
loc = zeros(60,2);
for i =0:10
   for j =1:6
       loc(counter,1) = i;
       loc(counter,2)=j;
       c(counter,1) =tempSum(i+1,j);
       sz(counter,1) = ((c(counter,1)-mod(c(counter,1),200))/200)*50+50;
       counter =counter+1;
       
   end
end


scatter(loc(:,2),loc(:,1),sz,c,'filled');
axis([0 7 -1 11])
ylabel('Damage');
xlabel('Service')
stringtitle = strcat('Number of damage reports during hour: ',int2str(hh), ', day: ', int2str(dag), ', zone:', int2str(zone));
title(stringtitle);

colorbar
clear tempDay;
clear tempSum;