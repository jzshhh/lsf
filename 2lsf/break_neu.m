clc;clear;
fid=fopen('steps.txt');
steps = textscan(fid,'%s %s %f %*s %*s %*s %*s');
fclose(fid);

% Get the list of files
udir = './pbo';
form = '*.pos';
% Get the list of station names
files = GetFiles(udir,form);
[n,p] = size(files);
sites = files(:,p-7:p-4);
for i=1:size(files)
    data=load(files(i,:));
    times=[];
    n=0;
    for j=1:size(steps{1})
        time= str2num(datestr(datevec(char(steps{2}(j)),'yymmmdd'),'yyyymmdd'));
        if strcmpi(sites(i,:),char(steps{1}(j,:)))&&(time>data(1,1))&&(time<data(end,1))
            n=n+1;
            times(n,1)=time;
            times(n,2)=steps{3}(j);
        end
    end
    
    if ~exist([files(i,:) '_break.neu'],'file')
        fid=fopen([files(i,:) '_break.neu'],'w');
        if ~isempty(times)
            [ok1,ok2] =unique(times(:,1));
            times=sortrows(times(ok2,:),1);
            for j=1:size(times)
                if times(j,2)==1
                    years=date2yr(datevec(num2str(times(j,1)),'yyyymmdd'));
                    fprintf(fid,'%16.11f  9999.99999999999  0  0\n',years);
                else
                    years=date2yr(datevec(num2str(times(j,1)),'yyyymmdd'));
                    fprintf(fid,'%16.11f  9999.99999999999  0  1\n',years);
                    if times(j,1)==20100227
                        fprintf(fid,'2010.15616438356  30                2  1\n');
                    end
                    if times(j,1)==20150916
                        fprintf(fid,'2015.70684931507  30                2  1\n');
                    end
                end
            end
        end
        fclose(fid);
    end
end

