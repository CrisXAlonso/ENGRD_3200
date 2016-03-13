function [xMid] = TEAM2PS02Q1(func, brackVec)
%This method implements a bisection root-finding method on a function
%provided
%The provided function is func and the bracketing root guesses are provided
%in brackVec as a vector

relTol = 10^(-5); %Sets the relative tolerance limit to the specified value
actTol = Inf; %Initial approximated relative tolerance value to be overwritten
xMid = -Inf; %Initial midpoint value to be overwritten

%Creates the default function to be analyzed as provided in the problem
function fx = tanFunc1(x)
   fx = tan(pi*x)-x-6;
end
%Assigns default values of no others are provided
if ~exist('func','var') || isempty(func)   
    func = @tanFunc1;
end
if ~exist('brackVec','var') || isempty(brackVec)
    brackVec = [0.4 0.48];
end

%Below the function is first plotted to analyze whether the provided
%bracket is a good choice

xL = brackVec(1); %Sets the left endpoint as provided by the user
xR = brackVec(2); %Sets the right endpoint as provided by the user
t = linspace(xL,xR,1000); %Creates points to plot the function over
plot(t, func(t)); %Plots the provided function
xLim = xlim;
line([xLim(1), xLim(2)], [0 0], 'Color', 'k'); %Plots the y = 0 line
pause;

%Once the user is satisfied with the choice, the bisection method
%commences:

counter = 1; %Sets an iteration counter to 1
while actTol > relTol %Iterates while the threshold error is not met
    xPrev = xMid; %Stores the previous root guess
    xMid = (xR-xL)/2 + xL; %Calculated the new midpoint root guess
    fxL = func(xL); %Calculates the function value at left endpoint
    fxMid = func(xMid); %Calculates the function value at midpoint
    fxR = func(xMid); %Calculates the function value at right endpoint
    actTol = abs((xMid - xPrev)/xMid); %Calculates approx. relative tolerance
    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Below is the code written to animate the bisection method:%
    hold off;
    
    t = linspace(xL,xR,1000);
    plot(t, func(t));
    xlim([xL-0.03*(xR-xL), xR+0.03*(xR-xL)]);
    hold on;
    plot(xL, 0, '*r');
    plot(xR, 0, '*g');
    
    
    xLim = xlim;
    yLim = ylim;
    line([xLim(1), xLim(2)], [0 0], 'Color', 'k');
    hold on;
    pause(1);
    plot(xMid, 0, '*');
    str1 = 'xR=';
    str2 = num2str(xMid);
    str3 = ' Err.=';
    str4 = num2str(actTol);
    str5 = strcat(str1, str2, str3, str4);
    text(xMid,yLim(1)*0.3,str5);
    pause(1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
            %Prints out the requires information per iteration:
    
    fprintf('Iteration         |  %d\nxL point|         |  %e\n',...
        counter, xL);
    fprintf('xU point|         |  %e\nxR point|         |  %e\n',...
        xR, xMid);
    fprintf('Approx. Rel. Err. |  %e\nf(xR)             |  %e\n',...
        actTol, fxR);
    fprintf('__________________________________________________________\n\n');
    
    %Setup for the next iteration:
    if (fxL*fxMid) < 0 %If the left and midpoint enclose a root...
        
        hold on;
        plot([xL, xL], [yLim(1), yLim(2)], '--k'); %Animation stuff
        plot([xMid, xMid], [yLim(1), yLim(2)], '--k');%Animation stuff
        
        xR = xMid; %then the midpoint becomes the new right endpoint
        pause(1);
    else %otherwise, the right and midpoint enclose a root, so...
        
        hold on;
        plot([xR, xR], [yLim(1), yLim(2)], '--k');%Animation stuff
        plot([xMid, xMid], [yLim(1), yLim(2)], '--k');%Animation stuff
        
        xL = xMid; %the midpoint becomes the new left endpoint
        pause(1);
    end

    counter = counter + 1; %Increments the counter
end

end

