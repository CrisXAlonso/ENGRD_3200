function [xR1, xR2] = TEAM2PS02Q2(func, xInit)
%This function performs both a Newton-Raphson and a Secant Method root
%finding technique on the provided sym function func. xInit is a vector that
%contains the x0 and x1 root guesses [x0, x1]. For the Newton Raphson method, x1 is
%used and for the secant method both guesses are used. xR1 is the result
%from the Newton Raphson method and xR2 is that from the secant method

relTol = 10^(-15); %Sets the relative tolerance limit to the specified value
actTolNR = Inf; %Sets initial NR relative tolerance to be overwritten
actTolSec = Inf; %Sets initial Sec relative tolerance to be overwritten
maxIt = 25; %Sets the max number of iterations to be allowed. 

%Creates a symbolic function of the function provided in order to later
%take the derivative
syms x
f = symfun(tan(pi*x)-x-6, x);

%Sets default values for input variables
if ~exist('func','var') || isempty(func)   
    func = subs(f);
end
if ~exist('xInit','var') || isempty(xInit)
    xInit = [0.54 0.48];
end
%Creates the differentiated function of the input function
funcPrime = diff(func);
funcPrime = subs(funcPrime);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Newton-Raphson %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter = 1; %Initiates iteration counter
xR1 = xInit(2); %Sets intiial guess to the one provided
fprintf('_______________________Newton-Raphson_______________________\n\n');
%Iterates while the tolerance limit or iteration limit are not met
while (actTolNR>relTol) && (counter <= maxIt)
xPrev = xR1; %Saves the previous root guess
xR1 = double(xR1 - func(xR1)/funcPrime(xR1)); %Calculates new root guess
actTolNR = abs((xR1-xPrev)/xR1); %Calculates approximate relative tolerance

%Prints out the required information:
fprintf('Iteration:           | %d\nPrevious Estimate:   | %e\n', ...
    counter, xPrev);
fprintf('Current Estimate:    | %e\nPer. Approx. Rel. Error:  | %e\n', xR1, ...
    actTolNR*100);
fprintf('__________________________________________________________\n\n');

itVecNR(counter) = counter; %Saves the iteration in a vector
errVecNR(counter) = actTolNR*100; %Saves the correspoding relative error

counter = counter + 1; %Increments the counter

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Secant %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counter = 1; %Initiates an iteration counter
xR2 = xInit(2); %Sets the initial value of root guess
xPrev = xInit(1); %Sets the previous value of root guess
fprintf('___________________________Secant___________________________\n\n');
%Iterates while the tolerance limit or iteration limit are not met
while (actTolSec>relTol) && (counter <= maxIt)
xHolder = xR2; %Holder for old root guess
%Calculates new root guess
xR2 = double(xR2 - func(xR2)*(xR2-xPrev)/(func(xR2)-func(xPrev))); 
xPrev = xHolder; %Sets old root guess as previous root guess
actTolSec = abs((xR2-xPrev)/xR2); %Approximates new relative error

%Prints out required information:
fprintf('Iteration:           | %d\nPrevious Estimate:   | %e\n', ...
    counter, xPrev);
fprintf('Current Estimate:    | %e\nPer. Approx. Rel. Error:  | %e\n', xR2, ...
    actTolSec*100);
fprintf('__________________________________________________________\n\n');

itVecSec(counter) = counter; %Stores iterations in vector
errVecSec(counter) = actTolSec*100; %Stores relative error in vector

counter = counter + 1; %Increments counter

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp(xR1)
disp(xR2)
%Plots the error for each method versus the iterations
plot (itVecNR, errVecNR, itVecSec, errVecSec);
xlabel('Iteration', 'Fontsize', 14);
ylabel('Percent Relative Error', 'Fontsize', 14);
title('Percent Relative Error vs Iteration for each Method', 'Fontsize', 20);
legend('Newton-Raphson', 'Secant');

