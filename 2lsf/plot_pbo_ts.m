function plot_pbo_ts(inp_pos,out_ps,periods,breaks,rates,explog,ebars,outlier)

sta_name=lower(inp_pos(1,7:10));

data = load(inp_pos);
time =data(:,1);
year=date2yr(datevec(num2str(time),'yyyymmdd'));
dataU = [year,data(:,4),data(:,7)];

% Look for outliers, deltaN < 20 mm, deltaE < 20mm, deltaU < 40mm
ok = sigma_outlier(dataU, 40);
dataU = dataU(ok,:);time=time(ok,:);

ntal=load(['ntal/' sta_name '.ntal']);
ntol=load(['ntol/' sta_name '.ntol']);
% temp=load(['temp/' sta_name '.temp']);
gia=load(['gia/' sta_name '.gia']);
[~,ok1,ok2]=intersect(ntal(:,1),time);

dataU(ok2,2) = dataU(ok2,2)-ntal(ok1,4)-ntol(ok1,4)-gia(ok1,2);
dataU = dataU(ok2,:);time=time(ok2,:);

% least square calculation, (iteration needed for editing the outlier data)
iter = 1; cnt = 0;
while iter == 1
    cnt = cnt + 1 ; % iteration number
    [Ux,Ustdx,Ures,Unrms,Uwrms,UA,Ut] = LeastSquare(dataU,periods,breaks,rates,explog,[],[]);
    ok = iqr_outlier(dataU,Ures,Unrms,outlier);
    dataU = dataU(ok,:);time=time(ok,:);
    
    % if iteration exceed 30, stop
    if (length(ok) == length(Ures))
        iter = 0; 
    end
    if ( cnt > 30 ), iter = 0; end
end

% Write out the solution 
fid = fopen(strcat(out_ps,'_report.txt'), 'w');
out = WrtResult(out_ps,'Up',Ux,Ustdx,Uwrms,Unrms,length(dataU(:,1)),length(year),periods,breaks,rates,explog,Ut);
fprintf(fid, '%s \n', out);
fclose(fid);
 
figure(1)
% Generate the model and model error bars
Umod = UA(:,3:6)*Ux(3:6);
m = mean(Umod);
Umod = Umod - m;
Udata=Umod+Ures;
ok3=find(abs(Udata)<80);
dataU = dataU(ok3,:);time=time(ok3,:); Udata =Udata(ok3,:);Umod=Umod(ok3,:);
plot(dataU(:,1),Udata,'bo','MarkerFaceColor','b','MarkerSize',2.0);
errorbar(dataU(:,1),Udata,ebars*dataU(:,3),'o','MarkerFaceColor','b','MarkerSize',2.0,'Color',[0.8 0.8 0.8]);
hold on;
plot(dataU(:,1),Umod,'Color','r','LineWidth',2);
ylabel 'Up (mm)';
xlabel 'year';
title(sta_name);
set(gcf,'Position',[200 200 800 200]);
set(gca,'YLim',[-40 40]);

export_fig(['neu/' sta_name '.pdf']);
delete(figure(1));

fid=fopen(['neu/' sta_name '.up'],'wt');
fprintf(fid,'%8d %10.6f %10.6f\n',[time Udata./1000 dataU(:,3)./1000]');
fclose(fid);