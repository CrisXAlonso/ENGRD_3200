function [res] = lnXTaylor(termNum, c, x)

relErr = Inf;
while relErr > 0.1
    res = 0;
    for n = 1:termNum-1 
         res = res + ((-1)^(n+1)*(x-c)^n)/n;
    end

    relErr = abs(res-log(x))/log(x)*100;

    termNum = termNum + 1;
   
end
disp(termNum-1);
end

