function [uValue] = data(N)

interface = 1 / 4;
A = 10;

NODES = N + 1;
h = 1 / N;
num = N * interface + 1;

coef = zeros(NODES, NODES);
value = zeros(NODES, 1);
for i = 1 : NODES
    if (i == 1)
        coef(1, [1 2]) = [1/h, -1/h];
        value(i) = h/2;
        continue;
    end
    
    if (i < num)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h];
        value(i) = h;
        continue;
    end
    
    if (i == num)
        coef(i, [i-1 i i+1]) = [-1/h, (1+A)/h, -A/h];
        value(i) = h;
        continue;
    end
    
    if (i < NODES)
        coef(i, [i-1 i i+1]) = [-1/h, 2/h, -1/h] .* A;
        value(i) = h;
        continue;
    end
    
    if (i == NODES)
        coef(i, [i-1 i]) = [-1/h, 1/h] .* A;
        value(i) = h/2;
        continue;
    end
end

coef([1, end], :) = [];
coef(:, [1, end]) = [];
value([1, end], :) = [];

uValue = coef \ value;
uValue = [0; uValue; 0];

end

