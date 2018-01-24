function condAnalysisOfA(N)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

bound = N / 4 + 1;
remove = [bound N/10 9*N/10];

xAll = [];
yAll = [];
for j = remove
    x = [];
    y = [];
    i = 1e0;
    while (i <= 1e5)
        x = [x log10(i)];
        y = [y log10(condFEM(N, i, j))];
        i = i * 1.2;
    end
    
    xAll = x;
    yAll = [yAll; y];
end

save('cond-A-4-NN', 'xAll', 'yAll');

[temp, ~] = size(yAll);
hold on;
box on;
for i = 1 : temp
    plot(xAll, yAll(i, :));
end

xlabel('log(A)');
ylabel('log(condition number)');

legend('x=0.25', 'x=0.1', 'x=0.9', 'Location', 'best');

print('-dpdf', 'cond-A-4-NN');
print('-depsc', 'cond-A-4-NN');

end

