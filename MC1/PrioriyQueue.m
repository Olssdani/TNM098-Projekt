function [outPutQueue, outPutValues] = PrioriyQueue(Info)
    %This function takes the information about each neighbourhood and weight
    %them to output a priority list of each neighbour to be used for the
    %emergency services.

    weight = [2/12 4/12 1/12, 2/12 1/12 2/12 ];
    
    outPutValues = sum((Info.*weight),2);
    outPutQueue = cell(size(Info,1),2);
    for i = 1:size(Info,1)
        outPutQueue(i,1) = {num2str(i)};
        outPutQueue(i,2) = {outPutValues(i,1)};      
    end
    outPutQueue = sort(outPutQueue, 1);

end

