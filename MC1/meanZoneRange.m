function [meanMat] = meanZoneRange(dayRange,hourRange,splitData,hourIndex,dataArray)
%day range goes from start(1) to end(2)
%hour range goes from start(1) to end(2)

     zoneBaseline = cell(19,7);
     divisor = cell(19,7);
     zoneBaseline(:,:) = {0};
     divisor(:,:) = {0};
     flagFirst = true;
     
    
    for j = size(splitData,1):size(splitData,2)-1 %looping through the days
        if(dayRange(1) < j)
            continue;
        end
        for n = 1:size(hourIndex,1)-1               %looping trough the hour
             if(hourRange(2) < n && dayRange(2) < j )
                 break;
             end
            
            if(hourRange(1) < n && flagFirst)
                flagFirst = false;
                continue;
            end
            for allHourIndexes = hourIndex(n,1,j):hourIndex(n,2,j) %loop trough all actions in the hour
                for cat = 1:size(dataArray,2)
                    for zone = 1:19
                        if(dataArray(allHourIndexes,7) ~= zone)
                            continue;
                        end
                        divisor{zone,cat} = divisor{zone,cat} +1;
                        zoneBaseline{zone,cat} = zoneBaseline{zone,cat} + dataArray(allHourIndexes,cat);
                        break;
                    end
                 end   
            end
        end
        if(hourRange(2) <= n && dayRange(2) <= j )
                 break;
        end
    end

    Z = cell2mat(zoneBaseline);
    D = cell2mat(divisor);
    meanMat = rdivide(Z,D);

end

