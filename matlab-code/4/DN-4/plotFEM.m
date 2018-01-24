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

f = @(x)(-x.^2/2 + x) .* (x>=0 & x<1/4)...
    + (-x.^2/20 + x/10 + 63/320) .* (x>=1/4 & x<=1);

hold on;
fplot(f, [0 1]);
plot(x, y, '--');
legend('exact solution', 'FEM solution', 'Location', 'southeast');
xlabel('x');
ylabel('y');

box on;
axes('position',[.25 .25 .5 .5]);
index = 0.248<=x & x<=0.252;
fplot(f, [.248 .252]);
hold on;
plot(x(index), y(index), '--');
set(gca, 'YTickLabel', []);

print('-dpdf', 'FEM-4-DN');
print('-depsc', 'FEM-4-DN');

end

