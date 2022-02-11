function out = WrtResult(name, comptext, soln, stdx,wrms, nrms, nd,n,...
    periods,breaks,rates,explog,t0)
% Function to write a string containing \n's to output the results

out = sprintf('Detrend of %s %s \n', name, comptext); 
out = [out, sprintf('%s WRMS: %7.2f mm     NRMS:%6.2f     #: %5d of %5d data\n', comptext, wrms, nrms, nd,n)];
out = [out, sprintf('%s T = %10.4f Postion        %10.2f +- %6.2f mm   \n', comptext, t0, soln(1), stdx(1))];
out = [out, sprintf('%s Rate                          %10.2f +- %6.2f mm/yr\n', comptext, soln(2), stdx(2))];
nc = 2;
if  ~isempty(periods)
    for i= 1:length(periods(:,1))
        out = [out, sprintf('%s Period %6.2f Cos             %10.2f +- %6.2f mm   \n', comptext, periods(i),soln(nc+1),stdx(nc+1))];
        out = [out, sprintf('%s Period %6.2f Sin             %10.2f +- %6.2f mm   \n', comptext, periods(i),soln(nc+2),stdx(nc+2))];
        [b,stdb] = coef2amp(soln(nc+1:nc+2),stdx(nc+1:nc+2));
        out = [out, sprintf('%s Period %6.2f amplitude       %10.2f +- %6.2f mm   \n', comptext, periods(i),b(1),stdb(1))];
        out = [out, sprintf('%s Period %6.2f phase           %10.3f +- %6.3f year   \n', comptext, periods(i),b(2),stdb(2))];
        nc = nc + 2;
    end
end
% Now write out breaks
% modified by YUAN 06/10/05
if ~isempty(breaks)
    for i = 1:length(breaks(:,1))
        if breaks(i,3) == 0
            if breaks(i,4) == 1
                out =[out, sprintf('%s Br EQ %10.4f              %10.2f +- %6.2f mm\n', comptext, breaks(i,1),soln(nc+1),stdx(nc+1))] ;
                nc = nc + 1;
            else
                out =[out, sprintf('%s Break %10.4f             %10.2f +- %6.2f mm\n', comptext, breaks(i,1),soln(nc+1),stdx(nc+1))] ;
                nc = nc + 1;
            end
        else
            out =[out, sprintf('%s Break %10.4f          %10.2f mm\n', comptext, breaks(i,1),breaks(i,3))] ;
        end
    end
end
% Now write out changed rates
if ~isempty(rates)
    for i = 1:length(rates(:,1))
        out =[out, sprintf('%s dRate %10.4f              %10.2f +- %6.2f mm/yr\n', comptext,rates(i), soln(nc+1),stdx(nc+1))] ;
        nc = nc +1;
    end
end
% Now write out exponential or logarithmic terms
if ~isempty(explog)
    for i = 1:length(explog(:,1))
            if explog(i,4) == 0
                out =[out, sprintf('%s Expon %10.4f Tau %3.1f    %10.2f +- %6.2f mm\n',comptext,explog(i,1),explog(i,2), soln(nc+1),stdx(nc+1))] ;
            elseif explog(i,4) == 1
                out =[out, sprintf('%s Log   %10.4f Tau %3.1f    %10.2f +- %6.2f mm\n',comptext,explog(i,1),explog(i,2), soln(nc+1),stdx(nc+1))] ;
            else
                fprintf('\nERROR in WrtResult.m: exponnetial or logarithmic is wrong\n\n');
                return
            end
        nc = nc +1;
    end
end
