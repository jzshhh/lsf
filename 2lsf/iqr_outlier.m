function ok = iqr_outlier(Data,res,nrms,outliercut)
% OUTLIER_REMOVE Exclude outliers based on robust statistics
% 	OUTLIER_REMOVE (X) returns all the elements in X that
%	have robust z-scores <= zmax (typically 3.0)
ok = find (abs(res./(Data(:,3)*nrms)) < outliercut);

