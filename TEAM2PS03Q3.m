function [] = TEAM2PS03Q3()


function x = Tridiag(e,f,g,r)
% Tridiag: Tridiagonal equation solver banded system
% x = Tridiag(e,f,g,r): Tridiagonal system solver.
% input:
% e = subdiagonal vector
% f = diagonal vector
% g = superdiagonal vector
% r = right hand side vector
% output:
% x = solution vector
n=length(f);
% forward elimination
for k = 2:n
    factor = e(k)/f(k-1);
    f(k) = f(k) - factor*g(k-1);
    r(k) = r(k) - factor*r(k-1);
end
% back substitution
x(n) = r(n)/f(n);
for k = n-1:-1:1
    x(k) = (r(k)-g(k)*x(k+1))/f(k);
end
end


nVec = [5 10 20 40 80 200 500 1000 2000];
errNorm = zeros(1,length(nVec));

for i = 1:length(nVec)
    nVal = nVec(i);
    h = 1/nVal;
    diagVec = zeros(1, nVal-1);
    diagVec2 = zeros(1, nVal-2);
    bVec = zeros(nVal-1, 1);
    xExact = zeros(nVal-1, 1);
    
    
    for j = 1:nVal-1
        diagVec(j) = 2;
    end
    for j = 1:nVal-2
        diagVec2(j) = -1;
    end
    for j = 1:nVal-1
        bVec(j,1) = h^2*sin(pi*h*j);
        xExact(j,1) = sin(pi*h*j)/pi^2;
    end
    A = diag(diagVec) + diag(diagVec2, 1) + diag(diagVec2, -1);
    
    [L,U,P] = lu(A);
    xSol = U \ ( L \ ( P * bVec ) );
    errVec = abs(xExact - xSol);
    errNorm(i) = max(errVec);
    
    
    
end

figure(1);
loglog(nVec, errNorm);
title('Log-Log Plot of Error Norm for Each N Value', 'FontSize', 16);
xlabel('N Value', 'FontSize', 14);
ylabel('Error Norm', 'FontSize', 14);


nVal = 100;

h = 1/nVal;
diagVec = zeros(1, nVal-1);
diagVec2 = zeros(1, nVal-2);
bVec = zeros(nVal-1, 1);
iVec = zeros(1, nVal-1);
xExact = zeros(nVal-1, 1);
A = zeros(nVal-1, nVal-1);
    
for j = 1:nVal-1
    diagVec(j) = 2;
end
for j = 1:nVal-2
    diagVec2(j) = -1;
end
for j = 1:nVal-1
    bVec(j,1) = h^2*sin(pi*h*j);
    xExact(j,1) = sin(pi*h*j)/pi^2;
    iVec(j) = j;
end
A = diag(diagVec) + diag(diagVec2, 1) + diag(diagVec2, -1);
iVec = iVec.';

[L,U,P] = lu(A);
xSol = U \ ( L \ ( P * bVec ) );
errVec = abs(xExact - xSol);
    
    
    

xTriD = Tridiag([0 diagVec2], diagVec, [diagVec2 0], bVec);
xTriD = xTriD.';
errVecSave = errVec;
errVec2 = abs(xTriD - xExact);
fprintf('The max error in the Thomas Algorith is %e\n', max(errVec2));
figure(2);
plot(iVec, xTriD);
title('Solution for Heat Rod Equation using Tridiagonal Solver', 'Fontsize', 16);
xlabel('i Value','Fontsize',14);
ylabel('x Value','Fontsize',14);


figure(3);
plot(iVec, errVecSave, iVec, errVec2, 'o');
title('Difference in Error Norms for LU vs Tridiagonal', 'Fontsize', 16);
xlabel('i Value','Fontsize',14);
ylabel('Absolute True Error','Fontsize',14);
legend('LU Factorization','Tridiagonal');


time_LU = zeros(1, 100);
time_Thom = zeros(1, 100);
diagVec = zeros(1, nVal-1);
diagVec2 = zeros(1, nVal-2);
bVec = zeros(nVal-1, 1);

for j = 1:nVal-1
    diagVec(j) = 2;
end
for j = 1:nVal-2
    diagVec2(j) = -1;
end
for j = 1:nVal-1
    bVec(j,1) = h^2*sin(pi*h*j);
end
A = diag(diagVec) + diag(diagVec2, 1) + diag(diagVec2, -1);


for i = 1:100
    tic;
    [L,U,P] = lu(A);
    xSol = U \ ( L \ ( P * bVec ) );
    time_LU(i) = toc;
    tic;
    xTriD = Tridiag([0 diagVec2], diagVec, [diagVec2 0], bVec);
    time_Thom(i) = toc;
end

avgLU = mean(time_LU);
avgThom = mean(time_Thom);

fprintf('The average wallclock time for LU is %e\n', avgLU);
fprintf('The average wallclock time for Thomas is %e\n', avgThom);

end