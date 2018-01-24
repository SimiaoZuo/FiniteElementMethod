function errorAnalysis(N)
% call data & errorFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

y = [];
x = [];
for i = 12 : 4 : N
    uValue = data(i);
    errorSum = errorFEM(i, uValue);
    
    y = [y log10(errorSum)];
    x = [x log10(1 / i)];
end

save('error-4-DN', 'x', 'y');

plot(x, y);
legend('error', 'Location', 'northwest');
xlabel('log(h)');
ylabel('log(error)');
print('-dpdf', 'error-4-DN');
print('-depsc', 'error-4-DN');

end

