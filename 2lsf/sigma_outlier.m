function ok = sigma_outlier(data, zmax)
% SIGMA_REMOVE Exclude outliers based on sigam

[rows,cols] = size(data);
if cols ==3
    ok = find (abs(data(:,3) < zmax ));
end
