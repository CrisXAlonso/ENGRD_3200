function [xR1, xR2] = TEAM2PS02Q2(func, xInit)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

relTol = 10^(-6);
actTolNR = Inf;
actTolSec = Inf;
maxIt = 25;

syms x
f = symfun(tan(pi*x)-x-6, x);


if ~exist('func','var') || isempty(func)   
    func = subs(f);
end
if ~exist('xInit','var') || isempty(xInit)
    xInit = [0.54 0.48];
end
funcPrime = diff(func);
funcPrime = subs(funcPrime);


counter = 1;
xR1 = xInit(2);
fprintf('_______________________Newton-Raphson_______________________\n\n');
while (actTolNR>relTol) && (counter <= maxIt)
xPrev = xR1;
xR1 = double(xR1 - func(xR1)/funcPrime(xR1));
actTolNR = abs((xR1-xPrev)/xR1);

fprintf('Iteration:           | %d\nPrevious Estimate:   | %e\n', ...
    counter, xPrev);
fprintf('Current Estimate:    | %e\nApprox. Rel. Error:  | %e\n', xR1, ...
    actTolNR);
fprintf('__________________________________________________________\n\n');

itVecNR(counter) = counter;
errVecNR(counter) = actTolNR;

counter = counter + 1;

end

counter = 1;
xR2 = xInit(2);
xPrev = xInit(1);
fprintf('___________________________Secant___________________________\n\n');
while (actTolSec>relTol) && (counter <= maxIt)
xHolder = xR2;
xR2 = double(xR2 - func(xR2)*(xR2-xPrev)/(func(xR2)-func(xPrev)));
xPrev = xHolder;
actTolSec = abs((xR2-xPrev)/xR2);
fprintf('Iteration:           | %d\nPrevious Estimate:   | %e\n', ...
    counter, xPrev);
fprintf('Current Estimate:    | %e\nApprox. Rel. Error:  | %e\n', xR2, ...
    actTolSec);
fprintf('__________________________________________________________\n\n');

itVecSec(counter) = counter;
errVecSec(counter) = actTolSec;

counter = counter + 1;

end

plot (itVecNR, errVecNR, itVecSec, errVecSec);

