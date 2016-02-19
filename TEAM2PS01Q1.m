

h=2;
x=0;
x0 = pi/4;
eRel = 10^(-6);
eVal = Inf;
trueVal = cos(x0);

while eVal > eRel
    h = h/10;
    fPrime = (sin(x0+h)-sin(x0))/h;
    eVal = abs(trueVal-fPrime)/trueVal;
    
end