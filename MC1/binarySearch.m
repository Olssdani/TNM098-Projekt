function [indexFound]  = binarySearch(data,startPos, endPos, searchCriteria)
%A binary search where it search between startPos and endPos in the data
%until a index where i-1: <=searchCriteria, i: ==searchCriteria and i+1:
%>searchCriteria
Start = startPos;
End = endPos;
%Check if there only is one instance left 
searchDate =string2Time(data{End,1});
if(searchCriteria.Day ==searchDate.Day)
    indexFound = End;
    return;
end

index = Start +floor((End -Start)/2);

while true
    searchDate = string2Time(data{index,1});
    if(searchCriteria.Day <searchDate.Day)
        
        
    else if(searchCriteria.Day >searchDate.Day)
            
            
    else
            
            
            
    end
end

end

