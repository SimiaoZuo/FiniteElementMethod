function [condNum] = condFEM(N, A)
% call scaleMatrix

interface = 1 / pi;

NODES = N + 1;
h = 1 / N;
num = ceil(N * interface);

xi = (num-1) * h;
xii = num * h;
temp = (interface-xi + A*(xii-interface)) / (h^2);

coef = zeros(NODES, NODES);
for i = 1 : NODES
    if (i == 1)
        coef(1, [1 2]) = [1/h, -1/h];
        continue;
    end
    
    if (i < num)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h];
        continue;
    end
    
    if (i == num)
        coef(i, [i-1 i i+1]) = [-1/h, 1/h+temp, -temp];
        continue;
    end
    
    if (i == num+1)
        coef(i, [i-1 i i+1]) = [-temp, temp+A/h, -A/h];
        continue;
    end
    
    if (i < NODES)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h] .* A;
        continue;
    end
    
    if (i == NODES)
        coef(i, [i-1 i]) = [-1/h, 1/h] .* A;
        continue;
    end
end

coef([1, end], :) = [];
coef(:, [1, end]) = [];
coef = scaleMatrix(coef);

condNum = cond(coef);

end

