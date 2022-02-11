function [b,stdb] = coef2amp(a,stda)
% transform the trigonometric function

b(1) = sqrt(a(1)*a(1) + a(2)*a(2));
b(2) = atan(a(1)/a(2));
stdb(1) = (a(1)*a(1)*stda(1)*stda(1)+ a(2)*a(2)*stda(2)*stda(2))/((b(1)*b(1)));
stdb(2) = (a(2)*a(2)*stda(1)*stda(1)+ a(1)*a(1)*stda(2)*stda(2))/(b(1).^4);
stdb = sqrt(stdb);
b(2) = b(2)/(2*pi);
stdb(2) = stdb(2)/(2*pi);

