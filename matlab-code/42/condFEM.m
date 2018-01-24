function [condNum] = condFEM(N, A)
% call scaleMatrix

interface1 = 1 / 4;
interface2 = 3 / 4;

NODES = N + 1;
h = 1 / N;
num1 = N * interface1 + 1;
num2 = N * interface2 + 1;

coef = zeros(NODES, NODES);
value = zeros(NODES, 1);
for i = 1 : NODES
    if (i == 1)
        coef(1, [1 2]) = [1/h, -1/h];
        value(i) = h/2;
        continue;
    end
    
    if (i < num1)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h];
        value(i) = h;
        continue;
    end
    
    if (i == num1)
        coef(i, [i-1 i i+1]) = [-1/h, (1+A)/h, -A/h];
        value(i) = h;
        continue;
    end
    
    if (i < num2)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h] .* A;
        value(i) = h;
        continue;
    end
    
    if (i == num2)
        coef(i, [i-1 i i+1]) = [-A/h, (1+A)/h, -1/h];
        value(i) = h;
        continue;
    end
    
    if (i < NODES)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h];
        value(i) = h;
        continue;
    end
    
    if (i == NODES)
        coef(i, [i-1 i]) = [-1/h, 1/h] .* A;
        value(i) = h/2;
        continue;
    end
end

remove = [1 num1 NODES];

coef(remove, :) = [];
coef(:, remove) = [];
coef = scaleMatrix(coef);
condNum = cond(coef);

end

