function condAnalysisOfA(num_per_row)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');
hold on;
box on;

for j = 13 : 4 : num_per_row
    y = [];
    x = [];
    i = 1e0;
    while (i <= 1e5)
        x = [x log10(i)];
        y = [y log10(condFEM(j, i))];
        i = i * 1.2;
    end
    
    plot(x, y);
end

legend('h=0.0833', 'h=0.0625', 'h=0.0500', 'h=0.0417', 'h=0.0357', 'Location', 'southeast');
xlabel('log(A)');
ylabel('log(condition number)');

name = 'cond-A-2D-circular-interface';
print('-dpdf', name);
print('-depsc', name);

end

