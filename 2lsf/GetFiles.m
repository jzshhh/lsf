function files = GetFiles(udir,form)
% files = GetFiles(udir): Gets the list of files from the directory udir
%    Generate the list of files that are needed.

if ~isempty(udir) 
    % form = strcat(udir,form);
    form = fullfile(udir,form);
end
% OK, See which files we have as form_files
d = dir(form);
% Get the names of all files in the directory
dname = {d.name};
% Get the list of file full names
files = []; % sites = [];
for i = 1:length(dname)
    tname = cell2struct(dname(i),'name');
    % sites = [sites;tname.name(4:7)];
    % tname.name = strcat(udir,tname.name);
    tname.name = fullfile(udir,tname.name);
    files = [files;tname.name];
end
