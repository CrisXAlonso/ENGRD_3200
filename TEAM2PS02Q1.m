function [xMid] = TEAM2PS02Q1(func, brackVec)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


relTol = 10^(-5);
actTol = Inf;
xMid = -Inf;

function fx = tanFunc1(x)
   fx = tan(pi*x)-x-6;
end

if ~exist('func','var') || isempty(func)   
    func = @tanFunc1;
end
if ~exist('brackVec','var') || isempty(brackVec)
    brackVec = [0.4 0.48];
end


xL = brackVec(1);
xR = brackVec(2);
counter = 1;

while actTol > relTol
    xPrev = xMid;
    xMid = (xR-xL)/2 + xL;
    fxL = func(xL);
    fxMid = func(xMid);
    fxR = func(xR);
    actTol = abs((xMid - xPrev)/xMid);
    
    
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
    
    
    
    fprintf('Iteration         |  %d\nxL point|         |  %e\n',...
        counter, xL);
    fprintf('xU point|         |  %e\nxR point|         |  %e\n',...
        xR, xMid);
    fprintf('Approx. Rel. Err. |  %e\nf(xR)             |  %e\n',...
        actTol, fxR);
    fprintf('__________________________________________________________\n\n');
    
    if (fxL*fxMid) < 0
        hold on;
        plot([xL, xL], [yLim(1), yLim(2)], '--k');
        plot([xMid, xMid], [yLim(1), yLim(2)], '--k');
        xR = xMid;
        pause(1);
    else
        hold on;
        plot([xR, xR], [yLim(1), yLim(2)], '--k');
        plot([xMid, xMid], [yLim(1), yLim(2)], '--k');
        xL = xMid;
        pause(1);
    end
    
    
    counter = counter + 1;
end




end

