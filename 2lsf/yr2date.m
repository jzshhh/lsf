function bdate = yr2date(year,n)
% yr2date converrt fractional year to [yr month day .. to n]

% Written by YUAN Linguo
% Email:linguo.yuan@polyu.edu.hk
%   $Revision: 1.0 $  $Date: 2006/09/11 $

if n > 6 , n=6; end
yr = fix(year);
fyr = mod(year,1);
if mod(yr,4) == 0 & mod(yr,100) ~= 0 |  mod(yr,400 )== 0
   doy = fyr*366 + 1;
else
   doy = fyr*365 + 1;
end
ser = datenum(yr,1,doy);
bdfull = datevec(ser);
bdate = bdfull(:,1:n)';
