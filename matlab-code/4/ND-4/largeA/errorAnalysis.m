function errorAnalysis(N, A)
% call data & errorFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

y = [];
x = [];
for i = 12 : 4 : N
    uValue = data(i, A);
    errorSum = errorFEM(i, uValue, A);
    
    y = [y log10(errorSum)];
    x = [x log10(1 / i)];
end

plot(x, y);
legend('error', 'Location', 'northwest');
xlabel('log(h)');
ylabel('log(error)');

cd pic;
save(['error-4-large-' num2str(log10(A))], 'x', 'y');
print('-dpdf', ['error-4-large-' num2str(log10(A))]);
cd ..;

end

