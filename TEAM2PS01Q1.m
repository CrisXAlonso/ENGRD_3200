

h=2; %Sets h equal to 10 times the starting value because it will be 
     %divided at the start of the while loop 
x0 = pi/4; %Sets the point at which the derivative is to be computed.
eRel = 10^(-6); %Sets the threshold relative error
eVal = Inf; %Sets the initial value of the relative error to infinity so 
            %as to guarantee the executing of the while loop
trueVal = cos(x0); %Calculates the actual value of the derivative at x0

%Keeps iterating until the relative threshold is surpassed
while eVal > eRel
    h = h/10; %Divides the h value by 10
    fPrime = (sin(x0+h)-sin(x0))/h; %Approximates the derivative
    eVal = abs(trueVal-fPrime)/trueVal; %Finds new relative error
end
s1 = 'The largest h value possible to drop the relative error below';
s2 = ' the given threshold is: %s\n';
s3 = strcat(s1, s2);
fprintf(s3, h);