function [outPut] = string2Time(date)
%Take a string in the format "Day/Month/Year hh/mm" and creates a struct
%with the data seperated
%Extract the day
month = extractBefore(date,'/');
loopSize =size(date{1,1},2);
for i=1:loopSize
    if date{1,1}(1,1) == '/'
        date = replaceBetween(date,1,1,'');
        break;
    end
    date = replaceBetween(date,1,1,'');
end
%Extract month
day = strtok(date,'/');
loopSize =size(date{1,1},2);
for i=1:loopSize
    if date{1,1}(1,1) == '/'
        date = replaceBetween(date,1,1,'');
        break;
    end
    date = replaceBetween(date,1,1,'');
end
%Extract year
year = strtok(date);
loopSize =size(date{1,1},2);
for i=1:loopSize
    if date{1,1}(1,1) == ' '
        date = replaceBetween(date,1,1,'');
        break;
    end
    date = replaceBetween(date,1,1,'');
end

%Hours
hh = strtok(date,':');
loopSize =size(date{1,1},2);
for i=1:loopSize
    if date{1,1}(1,1) == ':'
        date = replaceBetween(date,1,1,'');
        break;
    end
    date = replaceBetween(date,1,1,'');
end
%Minutes
mm = date;

outPut = struct('Day',day,'Month',month,'Year',year,'H',hh, 'M',mm);
end

