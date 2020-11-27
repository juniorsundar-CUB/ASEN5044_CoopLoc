function [x, y] = GenerateTruth(x0, u, P0, Q, R, Dt, steps, seed)    
rng(seed);
n = size(x0,1);
p = size(R,1);

x = zeros(n,steps);
y = zeros(p,steps);

% set initial conditions
dx = mvnrnd(zeros(1,n),P0);
x(:,1) = x0 + dx';
    
for i = 2:steps
    
    % generate noisy state
    wk = mvnrnd(zeros(1,n),Q);
    [~,next_x] = ode45(@NL_DynModel, [0.0 Dt], x(:,i-1)', [], u', wk');
    %next_x = next_x(end,:)' + wk';
    
    % wrap angle to [-pi pi]
    next_x(3) = wrapToPi(next_x(3));
    next_x(6) = wrapToPi(next_x(6));
    x(:,i) = next_x;
end

for i = 2:steps   
    % generate noisy measurement
    vk = mvnrnd(zeros(1,p),R);
    y(:,i) = NL_MeasModel(x(:,i), vk');
end

end