load('noisy_tide.mat'); %Loads the time and level data to 't' and 'f'
                        %respectively
%Plotting the noisy data
y1=figure(1);
subplot(2,1,1)
plot(t, f);
rectangle('Position', [t(round(74*length(t)/150)) ...
    f(round(74*length(t)/150))-f(round(2*length(t)/150))/12 ...
    t(round(2*length(t)/150)) f(round(2*length(t)/150))/6]);
xlabel('Time (seconds)', 'FontSize', 14);
ylabel('Sea Level (meters)', 'FontSize', 14);
set(y1, 'Position', [1, 1, 1200, 800]);
title('Plotting of Noisy Data (Full View)', 'FontSize', 20);


subplot(2,1,2);
plot(t(round(74*length(t)/150):round(76*length(t)/150)),...
    f(round(74*length(f)/150):round(76*length(f)/150)));
xlabel('Time (seconds)', 'FontSize', 14);
ylabel('Sea Level (meters)', 'FontSize', 14);
title('Plotting of Noisy Data (Zoomed in to Better Show Noise)',...
    'FontSize', 20);

%Creating variables for the amplitude and the period provided
ampl = 1; % In meters
per = 12*60*60; %Converted from hours to seconds


logVec = logspace(0, 4, 50); %Creates the logarithmically spaced vector 
                             %from 1 to 10^4 with 50 points
                             
analytic = -ampl*2*pi/per*sin(2*pi*t/per); %Creates the analytically solved
                                           % function for the derivative
                                           
errArray = zeros(1, length(logVec));%Preassigns a vector length for holding
                                    %the max error for each step size

hArray = zeros(1, length(logVec));%Preassigns a vector length for holding
                                    %the 'h' value for each step size


% Iterating over each log spaced values of h...
for k = 1:length(logVec)
h = round(logVec(k)); % Rounds to the nearest integer value

maxE = -Inf; %Initializes the max error to a value that will always 
             %be overwritten

    for n = (1+h):h:(t(end)-h) %Iterates at h spaced intervals over data
        %Saves the data for the 1 second step size to display later
        if h == 1
            fPrimeSave(n) = (f(n+h)-f(n-h))/(2*h); 
        end
        %Approximates the derivative using a centered finite difference 
        fPrime = (f(n+h)-f(n-h))/(2*h);
        %Solves for absolute error at each point and saves it if max
        if abs(fPrime-analytic(n)) > maxE
            maxE = abs(fPrime-analytic(n));
        end
    end
    %Saves the max error for each 'h' size iteration in the errArray
    hArray(k) = h;
    errArray(k) = maxE;
end
%Trims the unused time points to properly display the data graphically
tTrim = t(2:end-1);

%Plots the graph of the computed result for h=1s vs the analytical solution
y2 = figure(2);
hold all;
set(y2, 'Position', [1, 1, 1200, 800]);
plot(tTrim, fPrimeSave, t, analytic, 'r', 'LineWidth', 2);
xlabel('Time (seconds)', 'FontSize', 14);
ylabel('Sea Level Velocity (meters/second)', 'FontSize', 14);
legend('Calculated Result', 'Analytical Result');
title('Sea Level Velocity vs Time (Analytical and Calculated Solutions for h=1)', ...
    'FontSize', 20);


%Finds the minimum error value for all 'h' sizes and the corresponding
%index the the 'errArray'
[minErr, minInd] = min(errArray);

%Finds the 'h' size to which the mininum error corresponds
hOpt = logVec(minInd);

%Performs the centered finite difference approximation for this 'h' size
%and then displays the resulting approximation against the analytical
%solution

h = round(hOpt); %Sets h to this optimum h value and rounds to an int
counter = 1; % Counter to properly assign values within the vectors
y3 = figure(3);
subplot(2,1,1);
hold all;
plot(t, analytic, 'or'); %Plots the analytical solution

% Iterating over the data at the optimum 'h' value...
for n = (1+h):h:(t(end)-h)    
    tOpt(counter) = n; %Creates a vector of used time points
    fPrimeOpt(counter) = (f(n+h)-f(n-h))/(2*h);%vector of derivative values
    counter = counter + 1; % Increments the counter
    plot(tOpt, fPrimeOpt,'b','LineWidth', 2); %Plots the approximation
end
%Graph settings
set(y3, 'Position', [1, 1, 1200, 800]);
xlabel('Time (seconds)', 'FontSize', 14);
ylabel('Sea Level Velocity (meters/second)', 'FontSize', 14);
legend('Analytical Result', 'Calculated Result');
title('Sea Level Velocity vs Time (Analytical and Calculated Solutions for h=339s)', ...
    'FontSize', 19);

%Plotting log-log plot of error as a function of h
subplot(2,1,2);
loglog(hArray, errArray);
xlabel('Log h-size (seconds)', 'FontSize', 14);
ylabel('Log Absolute Error (meters/second)', 'FontSize', 14);
title('Log-Log Plot of Absolute Error of Centered Finite Difference Approx. vs h value', ...
    'FontSize', 19);
text(5,10^(-4.8) ,'Roundoff Error Dominates');
text(10^3.2,10^(-4.8) ,'Truncation Error Dominates');

maxM = ampl*(2*pi/per)^3;
thHOpt = (3*eps/maxM)^(1/3);
