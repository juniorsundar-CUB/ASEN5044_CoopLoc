function [x_est, y_est, P] = EKF(x0, P0, u, y, Q, R, Dt)

n = size(x0, 1);
p = size(R, 1);
steps = size(y,1);

x_est = zeros(n, steps);
y_est = zeros(p, steps);
P = zeros(n, n, steps);

x_p = x0;
P_p = P0;

for i=1:steps
    
    % Prediction Step
    wk = zeros(1,n);
    [~, x_m] = ode45(@NL_DynModel, [0.0 Dt], x_p', [], u', wk);  
    x_m(:,end) = 
    [A_t,B_t,C_t] = Linearize(x_m, u);
    [F, ~, H] = Discretize(A_t,B_t,C_t, Dt);
    
    P_m = F*P_p*F' + Q;

    x_m(3) = wrapToPi(x_m(3));
    x_m(6) = wrapToPi(x_m(6));
    vk = zeros(1,p);
    y_est(:,:,i) = NL_MeasModel(x_m, vk);
    e_y = y(:,:,i) - y_est(:,:,i);

    % Correction Step
    S = H*P_m*H' + R;
    K = P_m*H'/S;

    x_p = x_m + K*e_y;
    P_p = (eye(p) - K*H)*P_m;

    x_p(3) = wrapToPi(x_p(3));
    x_p(6) = wrapToPi(x_p(6));
    x_est(:,i) = x_p;
    P(:,:,i) = P_p;
end

end

