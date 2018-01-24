function [scaled] = scaleMatrix(M)

[num, ~] = size(M);
elements = [];
for i = 1 : num
    elements = [elements, sqrt(1 / M(i, i))];
end

temp = diag(elements);
scaled = temp * M * temp;

end

