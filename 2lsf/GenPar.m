function p = GenPar(t,t0, np, periods,breaks,rates,explog)
% p = GenPar(data(i,1),t0, np, preiods,breaks,rates,explog)
%     Generates one row of partials

% Written by YUAN Linguo
% Email:linguo.yuan@polyu.edu.hk
%   $Revision: 2.0 $  $Date: 2006/09/04 $

% Start counting parameters
p = zeros(1,np);
p(1) = 1; p(2) = t-t0;
nc = 2 ;    % Offset and Rate
        
% Period term
if ~isempty(periods) 
    for i= 1:length(periods(:,1))
        p(nc+1) = cos(2*pi*rem(t,1)/periods(i,1));
        p(nc+2) = sin(2*pi*rem(t,1)/periods(i,1));
        nc = nc + 2 ;
    end
end

% Now add up breaks
if ~isempty(breaks) % modified by YUAN Linguo 06/09/05,10/05
    for i = 1:length(breaks(:,1))
        if t > breaks(i,1) && t < breaks(i,2)
            p(nc+1) = 1;
        end
        nc = nc + 1;
    end
end

% Now add up changed rates
if ~isempty(rates)
    for i = 1:length(rates(:,1))
        if t > rates(i,1)
            p(nc+1) = t -rates(i,1);
        end
        nc = nc +1;
    end
end

% Now add up exponential or logarithmic terms
if ~isempty(explog)
    for i = 1:length(explog(:,1))
        if t > explog(:,1)
            if explog(i,4) == 0
                p(nc+1) =1-exp(-(t-explog(i,1))/abs(explog(i,2)/365.25));
            elseif explog(i,4) == 1
                p(nc+1) = log(1+(t-explog(i,1))/abs(explog(i,2)/365.25));
            else
                fprintf(stderr,'\nERROR in GetPar: exponnetial or logarithmic is wrong\n\n');
                return
            end
        end
        nc = nc +1;
    end
end
