function condAnalysisOfA(N)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

xAll = [];
yAll = [];
for j = 100 : 100 : N
    y = [];
    x = [];
    i = 1e0;
    while (i <= 1e5)
        x = [x log10(i)];
        y = [y log10(condFEM(j, i))];
        i = i * 1.2;
    end
    
    xAll = x;
    yAll = [yAll; y];
end

save('cond-A-pi-ND', 'xAll', 'yAll');

[temp, ~] = size(yAll);
hold on;
box on;
for i = 1 : temp
    plot(xAll, yAll(i, :));
end

legend('h=0.0100', 'h=0.0050', 'h=0.0033', 'h=0.0025', 'h=0.0020');
xlabel('log(A)');
ylabel('log(condition number)');
print('-dpdf', 'cond-A-pi-ND');
print('-depsc', 'cond-A-pi-ND');

end

