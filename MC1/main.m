%Load data
clear all
load data_Sorted.mat
load DayIndex.mat
load TestData.mat
%PrioriyQueue(Info)



testData = randi([0 10],19,6, 40);

for i= 1:40
   PrioriyQueue(testData(:,:,i));
   StackedBarChart(testData(:,:,i));
   pause(2);
end















