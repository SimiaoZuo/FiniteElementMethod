tic
A = 1e1;
while (A <= 1e12)
    errorAnalysis(1000, A);
    A = A * 10;
end
toc