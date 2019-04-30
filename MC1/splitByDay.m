function [outPut] = splitByDay(data)
%Split the data in to section by day

%Binary split
%Get day of first instance 
startDay = string2Time(data{1,1});
startIndex = 1;

endIndex = binarySearch(data, startIndex, size(data,1), startDay);


%date = string2Time(data{1,1});  



end

