% Find the smallest positive real number used by MATLAB

min = 4;          %Variable used to hold the current minimum postive real
minHold = 2;      %Variable used to hold the variable that is to be tested

%While we can still differentiate the number as other than zero....
while (minHold ~= 0)    
   min = minHold;           % Set the current min to the new min and
   minHold = minHold / 2;   % proceed to test the next possible smallest
    
end

fprintf('The smallest positive real number used by MATLAB is %s\n', min);