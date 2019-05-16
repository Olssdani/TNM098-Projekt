function ParallelCord(Info)
    
    labels = {'Road','Medical','Intensity','Water', 'Building', 'Power'};


    groups = ClusterByValue(Info);
    parallelcoords(Info,'Group', groups,'Labels',labels,'LineWidth',2);
    
    
end

