function year = date2yr(date)
% yr2date converrt [yr month day .. to n] to fractional year

% Written by YUAN Linguo
% Email:linguo.yuan@polyu.edu.hk
%   $Revision: 1.0 $  $Date: 2007/02/13 $

for i=1:size(date,1)
    ser = datenum(date(i,:));
    serbeg = datenum(date(i,1),1,1);
    % See if year and therefore how many days in year
    if mod(date(i,1),4) == 0 && mod(date(i,1),100) ~= 0 ||  mod(date(i,1),400 )== 0
        loy = 366;
    else
        loy = 365;
    end
    year(i,1) = date(i,1)+(ser-serbeg)./loy;
end

