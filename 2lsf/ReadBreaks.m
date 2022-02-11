function [ breaks,rates,explog ] = ReadBreaks(inp_pos )
% readbreaks format: date date type
%
breaks = [];rates=[];explog=[];
inp_pos_brk = strcat(inp_pos,'_break.neu');
if ( exist(inp_pos_brk,'file') == 2 )
    fid = fopen(inp_pos_brk,'rt');
    breaksall = fscanf(fid, '%f %f %f %f');
    fclose(fid);
    breaksall = reshape(breaksall,4,[])';
    breaks=breaksall(breaksall(:,3)==0,:);
    rates=breaksall(breaksall(:,3)==1,:);
    explog=breaksall(breaksall(:,3)==2,:);    
else
    disp('unknown break type!')
    return
end
end






