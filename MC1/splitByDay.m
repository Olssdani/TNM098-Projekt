function [outPut] = splitByDay(data)
%Get the start and end index for each day in the data. Return a struct with
%the information 
%Day - Which day
%start - Which index the day start on
%end - Which index the day ends at

%Get the first instance
startDay = string2Time(data{1,1});
startIndex = 1;
counter =1;
for i = 2:size(data,1)
    currentDay = string2Time(data{i,1});
    if(currentDay.Day>startDay.Day)      
        outPut(counter) = struct('Day',startDay.Day,'start',startIndex,'end',i-1);
        counter =counter+1;
        startIndex = i;
        startDay = string2Time(data{i,1});       
    end    
end
%Set last day with different index on the end
 outPut(counter) =  struct('Day',startDay.Day,'start',startIndex,'end',i);
end

