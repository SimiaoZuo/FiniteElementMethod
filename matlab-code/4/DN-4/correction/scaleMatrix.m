function [scaled, temp] = scaleMatrix(M)

[num, ~] = size(M);
elements = [];
for i = 1 : num
    elements = [elements, 1/sqrt(M(i, i))];
end

temp = diag(elements);
scaled = temp * M * temp;

end

