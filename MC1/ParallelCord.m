function ParallelCord(Info)
    
    labels = {'Road','Medical','Intensity','Water', 'Building', 'Power'};
    
%     for i= 1:25
%         x(1,i) =Info(i).Road;
%         x(2,i) =Info(i).Medical;
%         x(3,i) =Info(i).Intensity;
%         x(4,i) =Info(i).Water;
%         x(5,i) =Info(i).Building;
%         x(6,i) =Info(i).Power;
%     end
%     x = x';

    groups = ClusterByValue(Info);
    parallelcoords(Info,'Group', groups,'Labels',labels);
    
    
end

