itNum = 100;
nVec = [10 50 100 500 1000];

time_GE = zeros(1, length(nVec));
time_BF = zeros(1, length(nVec));
time_LU = zeros(1, length(nVec));
tocMatGE = zeros(itNum, length(nVec));
tocMatBF = zeros(itNum, length(nVec));
tocMatLU = zeros(itNum, length(nVec));
std_GE = zeros(1, length(nVec));
std_BF = zeros(1, length(nVec));

for i = 1:length(nVec)
    n = nVec(i);
    for j = 1:itNum;
        b = rand(n,1);
        A = rand(n,n);
        tic;
        x = A\b;
        tocMatGE(j, i) = toc;
    end 
    time_GE(i) = mean(tocMatGE(:, i));
    std_GE(i) = std(tocMatGE(:, i));
end

for i = 1:length(nVec)
    n = nVec(i);
    for j = 1:itNum;
        b = rand(n,1);
        A = rand(n,n);
        tic;
        [L,U,P] = lu(A);
        tocMatLU(j,i) = toc;
        tic;
        x = U \ ( L \ ( P * b ) );
        tocMatBF(j, i) = toc;
    end 
    time_BF(i) = mean(tocMatBF(:, i));
    std_BF(i) = std(tocMatBF(:, i));
    time_LU(i) = mean(tocMatLU(:, i));
end

ratioVec = (time_GE./time_BF);

hold on;
figure(1);
plot(nVec, time_GE, nVec, time_BF);
title('Time to Solve NxN System Gaussian Vs. LU', 'Fontsize', 16);
xlabel('N value', 'Fontsize', 14);
ylabel('Time (s)', 'Fontsize', 14);
legend('Gaussian Elimination', 'LU Factorization', 'Location', 'northwest');

figure(2);
plot(nVec, std_GE, nVec, std_BF);
title('Std Dev of Time to Solve NxN System Gaussian Vs. LU', 'Fontsize', 14);
xlabel('N value', 'Fontsize', 14);
ylabel('Standard Dev. (s)', 'Fontsize', 14);
legend('Gaussian Elimination', 'LU Factorization', 'Location', 'northwest');

figure(3);
plot(nVec, ratioVec);
title('Ratio of Time to Solve NxN System Gaussian / LU', 'Fontsize', 14);
xlabel('N value', 'Fontsize', 14);
ylabel('Ratio', 'Fontsize', 14);

figure(4);
plot(nVec, time_BF, nVec, time_LU);
title('Time LU Factorize vs Time to Perform BF', 'Fontsize', 14);
xlabel('N value', 'Fontsize', 14);
ylabel('Time (s)', 'Fontsize', 14);
legend('BF Substitution', 'LU Factorization', 'Location', 'northwest');

figure(5);
plot(nVec, time_LU./time_BF);
title('Ratio of Time of LU Factorization Vs BF Substitution', 'Fontsize', 14);
xlabel('N value', 'Fontsize', 14);
ylabel('Ratio', 'Fontsize', 14);