function [errorSum] = errorFEM(N, uValue, A)

h = 1 / N;
interface = 1 / 4;
errorSum = 0;
for i = 1 : N
    xi = (i - 1) * h;
    xii = i * h;
    ui = uValue(i);
    uii = uValue(i+1);
    
    if (xi < interface && abs(xi - interface) > 1e-12)
        if (xii >= interface) % over the interface, two seperate parts
            g = @(x)(x + (uii-ui)/h - 1).^2;
            errorSum = errorSum + integral(g, xi, interface);
            
            g = @(x)(x/A + (uii-ui)/h - 1/A).^2;
            errorSum = errorSum + A * integral(g, interface, xii);
        else % less than interface
            g = @(x)(x + (uii-ui)/h - 1).^2;
            errorSum = errorSum + integral(g, xi, xii);
        end
    else % greater than the interface
        g = @(x)(x/A + (uii-ui)/h - 1/A).^2;
        errorSum = errorSum + A * integral(g, xi, xii);
    end
end

errorSum = sqrt(errorSum);

end

