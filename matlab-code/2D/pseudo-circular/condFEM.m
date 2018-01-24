function [condNum] = condFEM(num_per_row, A)

interface1 = 1/4;
interface2 = 3/4;
num1 = (num_per_row - 1) * interface1 + 1;
num2 = (num_per_row - 1) * interface2 + 1;
dis = floor(1/2 * num_per_row);
NODES = num_per_row ^ 2;

coef = zeros(NODES, NODES);
for i = 1 : NODES
    column = mod(i, num_per_row);
    if (column == 0)
        column = num_per_row;
    end
    row = ceil(i / num_per_row);
    
    % the first row
    if (row == 1)
        if (column == 1)
            coef(i, [i i+1 i+num_per_row]) = [1 -1/2 -1/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i+num_per_row]) = [2 -1/2 -1/2 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i+num_per_row]) = [1 -1/2 -1/2];
            continue;
        end
    end
    
    % rows below interface1
    if (row < num1)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % row at interface1
    if (row == num1)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -1, -(1+A)/2, -1, -(1+A)/2];
            continue;
        end
        
        if (column < num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -(1+A)/2, -(1+A)/2, -1, -A];
            continue;
        end
        
        if (column == num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -(1+A)/2, -1, -1, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % the first disturbance row
    if (row == dis)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num1-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num1-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -1, -(1+A)/2, -1, -(1+A)/2];
            continue;
        end
        
        if (column == num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [1+3*A, -(1+A)/2, -A, -(1+A)/2, -A];
            continue;
        end
        
        if (column < num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1] .* A;
            continue;
        end
        
        if (column == num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -A, -1, -(1+A)/2, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % the second disturbance row
    if (row == dis+1)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num1-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num1-1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -1, -(1+A)/2, -(1+A)/2, -1];
            continue;
        end
        
        if (column == num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [1+3*A, -(1+A)/2, -A, -A, -(1+A)/2];
            continue;
        end
        
        if (column < num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1] .* A;
            continue;
        end
        
        if (column == num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -A, -1, -(1+A)/2, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % rows between interface1 and interface2
    if (row < num2)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -1, -A, -(1+A)/2, -(1+A)/2];
            continue;
        end
        
        if (column < num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1] .* A;
            continue;
        end
        
        if (column == num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -A, -1, -(1+A)/2, -(1+A)/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % row at interface2
    if (row == num2)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num1)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -1, -(1+A)/2, -(1+A)/2, -1];
            continue;
        end
        
        if (column < num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [2+2*A, -(1+A)/2, -(1+A)/2, -A, -1];
            continue;
        end
        
        if (column == num2)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [3+A, -(1+A)/2, -1, -(1+A)/2, -1];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % rows above interface2
    if (row < num_per_row)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row i+num_per_row]) = [4 -1 -1 -1 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row i+num_per_row]) = [2 -1 -1/2 -1/2];
            continue;
        end
    end
    
    % th last row
    if (row == num_per_row)
        if (column == 1)
            coef(i, [i i+1 i-num_per_row]) = [1 -1/2 -1/2];
            continue;
        end
        
        if (column < num_per_row)
            coef(i, [i i-1 i+1 i-num_per_row]) = [2 -1/2 -1/2 -1];
            continue;
        end
        
        if (column == num_per_row)
            coef(i, [i i-1 i-num_per_row]) = [1 -1/2 -1/2];
            continue;
        end
    end
end

remove = [num_per_row*num1+num1];
% remove = [NODES];
coef(remove, :) = [];
coef(:, remove) = [];

coef = scaleMatrix(coef);
condNum = cond(coef);

end

