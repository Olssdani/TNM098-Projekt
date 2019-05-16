%Load data
clear all
load data_Sorted.mat
load DayIndex.mat
load TestData.mat
load newZoneMean.mat
%PrioriyQueue(Info)




testData = randi([0 10],19,6, 40);
% 
% for i= 1:40
%    PrioriyQueue(testData(:,:,i));
%    StackedBarChart(testData(:,:,i));
%    pause(2);
% end
% hour zone day cat
% hh, cat, day
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










