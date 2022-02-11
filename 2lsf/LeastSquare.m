function [soln,stdx,res,nrms,wrms,a,t0] = LeastSquare(data,periods,breaks,...
    rates,explog,t0,AprV)
%LeastSquare Least Squares Trend Estimation
%   Computes least squares estimates of trend model defined by datum bias,
%   common slope, and periodic components,offsets at specified times, and
%   exponential or logarithmic decay and slope change after offset.

%             Form the partial derivatives for the estimation
%             Dimension first (for speed).  Parameters are:
%             1    -- Offset at MeanT
%             2    -- Linear rate (m/yr)
%             3-4  -- Maybe annual;
%             5-6  -- Maybe semiannual;
%             3-np -- Values of the offsets at the break times and
%             exponentials

% Get parameter number indicator (value used to select parameters)
np = NumPar(periods,breaks,rates,explog);

% Do the Least squares solution.
% (iteration needed for editing the outlier data)
% iter = 1; cnt = 0;
% while iter == 1
%     cnt = cnt + 1 ; % iteration number
%
if isempty(t0)
    t0 = mean(data(:,1));
end

% Form the partial derivatives for the estimation
a = zeros(length(data(:,1)),np);
for i = 1:length(data(:,1))
    p = GenPar(data(i,1),t0, np, periods,breaks,rates,explog);
    a(i,:) = p;
end

%             add weight to a
clear atw w
sumw = 0;
w = 1./data(:,3).^2;
for i = 1:np
    atw(:,i) = a(:,i).*w;
end
atw = atw';
sumw = sum(w);

%             Do the Least squares solution.  From pre-fit
%             Normal equations and solve.  Compute statistics
%             from the residuals to the fit.
neq = atw*a ;
%             In case we have breaks that can not be determined
%             add a small apriori sigma to the diagonal for the
%             for the break estimates
for i = 3:np
    if neq(i,i) ~= 0
        neq(i,i) = neq(i,i)*(1+1.d-6);
    else
        neq(i,i) = 1;
    end
end
if isempty(AprV)    
    AprV = 0 ;
end
bvec = atw*(data(:,2)-AprV*(data(:,1)-t0));

soln = inv(neq)*bvec ; soln(2) = soln(2)+AprV;

% First compute the actual residual to get chi**2 and then the
% residual for plotting
res = (data(:,2) - (a*soln));
%             Compute RMS scatter of residuals
numdata = length(res);
chisqr = (res'.^2*w);
if numdata > np
    nrms = sqrt(chisqr/(numdata-np));
    wrms = sqrt((numdata/(numdata-np))*chisqr/sumw);
else
    nrms = 1;
    wrms = sqrt(1/sumw);
end
cov = inv(neq)*nrms^2 ;
stdx=sqrt(diag(cov));


