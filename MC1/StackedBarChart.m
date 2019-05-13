function StackedBarChart(Info)
    %Create a stacked bar chart
    load colors.mat
%     for i= 1:25
%         x(1,i) =Info(i).Road;
%         x(2,i) =Info(i).Medical;
%         x(3,i) =Info(i).Intensity;
%         x(4,i) =Info(i).Water;
%         x(5,i) =Info(i).Building;
%         x(6,i) =Info(i).Power;
%     end
    Info = Info';
    b = barh(Info,'stacked','FaceColor','flat');

    for k = 1:size(Info,2)
        b(k).CData = colors(k,:);
    end

    l = cell(1,19);
    for i = 1:19
        l{i}=num2str(i);    
    end
    legend(b,l);

    yticklabels({'Road','Medical','Intensity','Water', 'Building', 'Power'})
    xlabel('Total Magnitud');
    ylabel('Reported Facility');
end

