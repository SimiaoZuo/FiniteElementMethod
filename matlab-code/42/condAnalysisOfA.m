function condAnalysisOfA(N)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

xAll = [];
yAll = [];
for j = 100 : 100 : N
    x = [];
    y = [];
    i = 1e0;
    while (i <= 1e5)
        x = [x log10(i)];
        y = [y log10(condFEM(j, i))];
        i = i * 1.2;
    end
    
    xAll = x;
    yAll = [yAll; y];
end

[temp, ~] = size(yAll);
hold on;
box on;
for i = 1 : temp
    plot(xAll, yAll(i, :));
end

xlabel('log(A)');
ylabel('log(condition number)');
legend('h=0.0100', 'h=0.0050', 'h=0.0033', 'h=0.0025', 'h=0.0020', 'Location', 'southeast');

name = 'cond-A-42-NN';
print('-dpdf', name);
print('-depsc', name);

end

