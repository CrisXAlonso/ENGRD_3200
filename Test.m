h = 2*10^(-6); %h value in double precision
x0 = pi/4; %x0 value in double precision
trueVal = cos(x0); %true derivative in double precision
fPrime = (sin(x0+h)-sin(x0))/h; %Derivative approx. in double precision
eVal = abs(trueVal-fPrime)/trueVal; %Relative error in double precision

hSin = 2*10^(-6); %h value in double precision
x0Sin = pi/4; %x0 value in double precision
hSin = single(hSin); %h value in single precision
x0Sin = single(x0Sin); %x0 value in single precision
trueValSin = cos(x0); %true derivative in double precision
trueValSin = single(trueValSin); %true derivative in single precision
fPrimeSin = (sin(x0+h)-sin(x0))/h; %Derivative approx. in double precision
fPrimeSin = single(fPrimeSin); %Derivative approx. in single precision
eValSin = abs(trueVal-fPrime)/trueVal; %Relative error in double precision
eValSin = single(eValSin); %Relative error in single precision