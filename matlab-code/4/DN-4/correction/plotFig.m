function plotFig(N, A)

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

x = [];
y = [];
for N = 12 : 4 : N
    h = 1 / N;
    delta = energy(N, A);
    
    x = [x log10(h)];
    y = [y log10(abs(delta))];
end

plot(x,y);
legend('energy difference', 'Location', 'northwest');
xlabel('log(h)');
ylabel('log(energy difference)');

save(['energy-' num2str(log10(A))], 'x', 'y');
print('-dpdf', ['energy-' num2str(log10(A))]);
    
end

