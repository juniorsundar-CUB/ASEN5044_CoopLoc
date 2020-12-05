function [Fk, Hk, Ok] = GenerateLKFMats(u0, x_nom, steps, p, Dt)

Fk = zeros(size(x_nom, 1), size(x_nom, 1), steps);
Hk = zeros(p, size(x_nom, 1), steps);
Ok = zeros(size(x_nom, 1), size(x_nom, 1), steps);

for i=1:steps
    [A_t, B_t, C_t] = Linearize(x_nom(:,i), u0);
    [Fk(:,:,i), ~ , Hk(:,:,i)] = Discretize(A_t,B_t,C_t, Dt);
    Ok(:,:,i) = eye(size(x_nom, 1));
end

end

