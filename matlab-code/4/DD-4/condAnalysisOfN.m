function condAnalysisOfN(N)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

x = [];
y = [];
for i = 12 : 4 : N
    x = [x log10(1/i)];
    y = [y log10(condFEM(i, 10))];
end

save('cond-N-4-DD', 'x', 'y');

plot(x,y);
legend('condition number');
xlabel('log(h)');
ylabel('log(condition number)');
print('-dpdf', 'cond-N-4-DD');
print('-depsc', 'cond-N-4-DD');

end

