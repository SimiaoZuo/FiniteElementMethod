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

f = @(x)(-x.^2/2 + 25/104 * x) .* (x>=0 & x<1/4)...
    + (-x.^2/20 + 5/208 .* x + 27/1040) .* (x>=1/4 & x<=1);

fplot(f, [0 1]);
hold on;
plot(x, y, '--');
legend('exact solution', 'FEM solution');
xlabel('x');
ylabel('y');

box on;
axes('position',[.25 .25 .5 .5]);
index = 0.248<=x & x<=0.252;
fplot(f, [.248 .252]);
hold on;
plot(x(index), y(index), '--');
set(gca, 'YTickLabel', []);

print('-dpdf', 'FEM-4-DD');
print('-depsc', 'FEM-4-DD');

end

