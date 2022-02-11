clear;clc;
% Get the list of files
udir = './pbo';
form = '*.pos';
% Get the list of station names
files = GetFiles(udir,form); 
[n,p] = size(files);
sites = files(:,p-7:p-4);
periods=[1;0.5];% period term
ebars=0; %Integer.  If 0, no errorbars on plot.  If 1, plot 1-sigma errorbars.  If 2, plot 2-sigma errorbars
outlier=4; %the outlier remove criteria
for i=1:n
    [breaks,rates,explog] = ReadBreaks(files(i,:));
    plot_pbo_ts(files(i,:),fullfile(udir,sites(i,:)),periods,breaks,rates,explog,ebars,outlier);
end



