function [x, y] = GenerateTruth(x0, u, P0, Q, R, Dt, steps)

n = size(x0,1);
p = size(R,1);

x = zeros(n,steps+1);
y = zeros(p,steps+1);

% set initial conditions
dx = mvnrnd(zeros(1,n),P0);
x(:,1) = x0 + dx';

for i = 2:steps+1
    
    % generate noisy state
    wk = chol(Q)*randn(n,1);
%     wk = mvnrnd(zeros(1,n),Q);
    [~,next_x] = ode45(@NL_DynModel, 0.0:Dt:2*Dt, x(:,i-1)', [], u', wk);
    %next_x = next_x(end,:)' + wk';
    
    % wrap angle to [-pi pi]
    next_x(3) = wrapToPi(next_x(3));
    next_x(6) = wrapToPi(next_x(6));
    x(:,i) = next_x(2,:)';
end

for i = 2:steps+1   
    % generate noisy measurement
    vk = chol(R)*randn(p,1);
%     vk = mvnrnd(zeros(1,p),R);
    y(:,i) = NL_MeasModel(x(:,i), vk);
end

end