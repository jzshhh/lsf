function np = NumPar(periods,breaks,rates,explog)
%NumPar Function to get number of paramaters.

% Written by YUAN Linguo
% Email:linguo.yuan@polyu.edu.hk
%   $Revision: 2.0 $  $Date: 2006/09/05 $

% Start counting parameters
np = 2 ;    % Offset and Rate
if ~isempty(periods)
    np = np + 2*length(periods(:,1)); % Period term
end

% Now add up breaks
if ~isempty(breaks) % modified by YUAN Linguo 06/09/05,10/05
    ok = find ((breaks(:,3) == 0 ));
    aprbk = breaks(ok,:);
    np = np + length(aprbk(:,1));
end

% add up changed rates
if ~isempty(rates)
    np = np + length(rates(:,1));
end

% add up expotential or Logarithmic terms
if ~isempty(explog)
    np = np + length(explog(:,1));
end
