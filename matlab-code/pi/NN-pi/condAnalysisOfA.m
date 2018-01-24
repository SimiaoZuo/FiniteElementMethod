function condAnalysisOfA(N)
% call condFEM

clf('reset');
set(0, 'defaulttextinterpreter', 'latex');

bound = floor(N / pi) + 1;

remove = [floor(1/4*N) floor(3/4*N)];
% remove = [bound bound+1];

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

save('cond-A-pi-NN-away', 'xAll', 'yAll');
% save('cond-A-pi-NN-near', 'xAll', 'yAll');

[temp, ~] = size(yAll);
hold on;
box on;
for i = 1 : temp
    plot(xAll, yAll(i, :));
end

xlabel('log(A)');
ylabel('log(condition number)');

legend(['x=' num2str(floor(3/4*N)/N)], ['x=' num2str(floor(1/4*N)/N)], 'Location', 'best');
% legend(['x=' num2str((bound-1)/N)], ['x=' num2str(bound/N)], 'Location', 'best');

print('-dpdf', 'cond-A-pi-NN-away');
print('-depsc', 'cond-A-pi-NN-away');

% print('-dpdf', 'cond-A-pi-NN-near');
% print('-depsc', 'cond-A-pi-NN-near');

end

