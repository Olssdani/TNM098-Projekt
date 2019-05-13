function [ClusterData] = ClusterByValue(Info)
    % Cluster the data by a certain threshold or a limit
    %Limits for the three different groups
    GroupLimits = [3 6];
    %Level for the emergency 
    EmercencyNr = 8;

    %Wheight measurement road, medical, intensity, water, building, power
    weight = [2/12 4/12 1/12, 2/12 1/12 2/12 ];


    for i=1:size(Info, 1)
        value = sum(Info(i,:).*weight);
        value_max = max(Info(i,:));

        if(value <GroupLimits(1) && value_max < EmercencyNr)
            ClusterData(i,1) = "Non-Emergency";

        elseif(value >GroupLimits(1) && value < GroupLimits(2) && value_max < EmercencyNr)

            ClusterData(i,1) = "Low-Emergency";
        else

            ClusterData(i,1) = "Emergency";
        end
    end
end

