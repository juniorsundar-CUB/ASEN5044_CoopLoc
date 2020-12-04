function [x, y] = GenerateTruth(x0, u, P0, Q, R, Dt, steps, wrapOn)
opt = odeset('RelTol',1e-6,'AbsTol',1e-6);
useChol = true;
n = size(x0,1);
p = size(R,1);

x = zeros(n,steps+1);
y = zeros(p,steps+1);

% set initial conditions
dx = mvnrnd(zeros(1,n),P0);
x(:,1) = x0 + dx';
x(3,1) = wrapToPi(x(3,1));
x(6,1) = wrapToPi(x(6,1));

for i = 2:steps+1
    
    % generate noisy state
    if useChol==true
        wk = chol(Q)*randn(n,1);
    else
        wk = mvnrnd(zeros(1,n),Q)';
    end
    [~,next_x] = ode45(@NL_DynModel, [0 Dt], x(:,i-1)', opt, u', wk);
    
    if wrapOn == true
    % wrap angle to [-pi pi]
    next_x(3) = wrapToPi(next_x(3));
    next_x(6) = wrapToPi(next_x(6));
    end
    x(:,i) = next_x(end,:)';
end

for i = 1:steps+1   
    % generate noisy measurement
    if useChol==true
        vk = chol(R)*randn(p,1);
    else
        vk = mvnrnd(zeros(1,p),R)';
    end
    y(:,i) = NL_MeasModel(x(:,i), vk);
    
    if wrapOn == true
    % wrap angle to [-pi pi]
    y(1,i) = wrapToPi(y(1,i));
    y(3,i) = wrapToPi(y(3,i));
    end
end

end