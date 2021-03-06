function [out] = compare(baseLine,current, zoneVotes, days, hours )
    %Takes the basevalues for all zone and compares them to the current
    %values that is analyzed
    load cityWeight.mat
    load prioWeight.mat
    
    %Difference between the baseLine and the current
    diff = current-baseLine;
    
    %Set all negativ values to zero
    diff(diff<0)=0;
    magnitude = sum(cityWheight.*priorityWheight,2);
    %Sum all catogories for each zone without the zone number
    list = sum(diff(:,1:6),2).*magnitude;
    
    for i= 1:19
       list(i,2) =i; 
    end
    counter = 1;
    for d =days(1,1):days(1,2)
        %Set end of day depending on the dayrange
        if(d == days(1,2))
           hh_end = hours(1,2);
        else
           hh_end = 24;
        end
        %Set the start hour depending on if it is the start day
        if(d == days(1,1))
           hh_start = hours(1,1);
        else
           hh_start = 0;
        end
        for h = hh_start:hh_end
            for z = 1:19
                reports(counter,z) = zoneVotes{h,d,z};
                
            end
            counter = counter+1;
        end        
    end
    %reports = sum(reports);
    
    tot_report = sum(reports);
    reports = sqrt(reports./tot_report);
     
    list(:,1) = list(:,1).*reports';
    out = sortrows(list,'descend');
        
    
    
end


