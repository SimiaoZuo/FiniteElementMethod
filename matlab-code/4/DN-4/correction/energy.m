function [delta] = energy(N, A)

interface = 1 / 4;

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

% constrain by D-N boundary
coef(1, :) = [];
coef(:, 1) = [];
value(1, :) = [];

% correction
Aori = coef;

coef(end, :) = [];
coef(:, end) = [];
value(end, :) = [];
x = coef \ value;
x = [0; x; 0];

c = zeros(N-1, 1);
c(end) = -Aori(N-1, N);
[Astar, D] = scaleMatrix(coef);
zz = Astar \ (D*c);
z = D * zz;
z = [0; z; 1];

% compute energy B(z,z) B(x,x) B(x,z)
num = N * interface;
Bxx = 0;
Bzz = 0;
Bxz = 0;
for i = 1 : num
    Bxx = Bxx + (x(i+1)-x(i))^2/h;
    Bzz = Bzz + (z(i+1)-z(i))^2/h;
    Bxz = Bxz + (x(i+1)-x(i)) * (z(i+1)-z(i))/h;
end
for i = num+1 : N
    Bxx = Bxx + A * (x(i+1)-x(i))^2/h;
    Bzz = Bzz + A * (z(i+1)-z(i))^2/h;
    Bxz = Bxz + A * (x(i+1)-x(i)) * (z(i+1)-z(i))/h;
end

% calculate B(u,u)
g = @(x)(-x+1).^2;
left = integral(g, 0, interface);
g = @(x)(-x/A+1/A).^2;
right = integral(g, interface, 1);
Buu = left + A * right;

g = @(x)-x.^2/2 + x;
left = integral(g, 0, interface);
g = @(x)-x.^2/(2*A) + x/A + 7*(A-1)/(32*A);
right = integral(g, interface, 1);
Buu = Buu - 2 * (left+right);

% correction term fx and fz
fz = 0;
fx = 0;
for i = 1 : N
    fz = fz + h * (z(i+1)+z(i))/2;
    fx = fx + h * (x(i+1)+x(i))/2;
end

% u = k * z + x
k = (-Bxz + fz) / Bzz;

% compute energy B(uh,uh)
Buhuh = Bxx + 2*Bxz*k + (k^2)*Bzz - 2*fx - 2*k*fz;

delta = Buu - Buhuh;

end

