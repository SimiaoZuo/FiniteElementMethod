function [condNum] = condFEM(num_per_row, A)

interface = 1/4;
num = (num_per_row - 1) * interface + 1; % number of where the interface is
NODES = num_per_row ^ 2;
dis = floor(1/2 * NODES);

coef = zeros(NODES, NODES);
for i = 1 : NODES
    column = mod(i, num_per_row);
    if (column == 0)
        column = num_per_row;
    end
    row = ceil(i / num_per_row);
    
    % the first row
    if (row == 1)
        if (i == 1)
            coef(1, [1 2 1+num_per_row]) = [1 -1/2 -1/2];
            continue;
        end
        
        if (i < num)
            coef(i, [i i-1 i+1 i+num_per_row]) = [2 -1/2 -1/2 -1];
            continue;
        end
        
        if (i == num)
            coef(i, [i i-1 i+1 i+num_per_row]) = [1+A, -1/2, -A/2, -(1+A)/2];
            continue;
        end
        
        if (i < num_per_row)
            coef(i, [i i-1 i+1 i+num_per_row]) = [2 -1/2 -1/2 -1] .* A;
            continue;
        end
        
        if (i == num_per_row)
            coef(i, [i i-1 i+num_per_row]) = [1 -1/2 -1/2] .* A;
            continue;
        end
    end
    
    % the first disturbance row
    if (row == dis)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
        end
        
        if (column < num-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -1, -(1+A)/2, -1, -(1+A)/2];
        end
        
        if (column == num)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [1+3*A, -(1+A)/2, -A, -(1+A)/2, -A];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1] .* A;
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2] .* A;
            continue;
        end
    end
    
    % the second disturbance row
    if (row == dis+1)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
        end
        
        if (column < num-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -1, -(1+A)/2, -(1+A)/2, -1];
        end
        
        if (column == num)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [1+3*A, -(1+A)/2, -A, -A, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1] .* A;
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2] .* A;
            continue;
        end
    end
    
    % the middle rows
    if (row < num_per_row)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -1, -A, -(1+A)/2, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1] .* A;
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2] .* A;
            continue;
        end
    end
    
    % the last row
    if (row == num_per_row)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row]) = [1 -1/2 -1/2];
            continue;
        end
        
        if (column < num)
            coef(i, [i i-1 i+1 i-num_per_row]) = [2 -1/2 -1/2 -1];
            continue;
        end
        
        if (column == num)
            coef(i, [i i-1 i+1 i-num_per_row]) = [1+A, -1/2, -A/2, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row]) = [2 -1/2 -1/2 -1] .* A;
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row]) = [1 -1/2 -1/2] .* A;
            continue;
        end
    end
end

remove = [num+num_per_row];
coef(remove, :) = [];
coef(:, remove) = [];

coef = scaleMatrix(coef);
condNum = cond(coef);

end

