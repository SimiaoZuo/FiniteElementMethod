function plotFEM(N)
% call data

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

h = 1 / N;
NODES = 1 + N;

uValue = data(N);
x=[];
y=[];
for i = 1 : NODES
    x = [x, (i - 1) * h];
    y = [y, uValue(i)];
end

f = @(x)(-x.^2/2 + (9+pi^2)/(20*pi^2)) .* (x>=0 & x<1/pi)...
    + (-x.^2/20 + 1/20) .* (x>=1/pi & x<=1);

fplot(f, [0 1]);
hold on;
plot(x, y, '--');
legend('exact solution', 'FEM solution');
xlabel('x');
ylabel('y');

axes('position',[.25 .25 .5 .5]);
index = 0.316<=x & x<=0.32;
fplot(f, [0.316 0.32]);
hold on;
plot(x(index), y(index), '--');
set(gca, 'YTickLabel', []);

print('-dpdf', 'FEM-pi-ND');
print('-depsc', 'FEM-pi-ND');

end

