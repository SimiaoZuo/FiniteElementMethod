function condAnalysisOfN(N)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

x = [];
y = [];
for i = 10 : N
    x = [x log10(1/i)];
    y = [y log10(condFEM(i, 10))];
end

save('cond-N-pi-ND', 'x', 'y');

plot(x,y);
legend('condition number');
xlabel('log(h)');
ylabel('log(condition number)');
print('-dpdf', 'cond-N-pi-ND');
print('-depsc', 'cond-N-pi-ND');

end

