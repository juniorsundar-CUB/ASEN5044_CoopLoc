function [x, y] = GenerateTruth(x0, u, P0, Q, R, Dt, steps)
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
    [~,next_x] = ode45(@NL_DynModel, 0.0:Dt:2*Dt, x(:,i-1)', [], u', wk);
    
    % wrap angle to [-pi pi]
    next_x(3) = wrapToPi(next_x(3));
    next_x(6) = wrapToPi(next_x(6));
    x(:,i) = next_x(2,:)';
end

for i = 2:steps+1   
    % generate noisy measurement
    if useChol==true
        vk = chol(R)*randn(p,1);
    else
        vk = mvnrnd(zeros(1,p),R)';
    end
    y(:,i) = NL_MeasModel(x(:,i), vk);
end

end