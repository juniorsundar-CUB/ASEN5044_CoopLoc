function [x_est, y_est, P] = EKF(x0, P0, u, y, Q, R, Dt)
odeset('RelTol',1e-6,'AbsTol',1e-6);
n = size(x0, 1);
p = size(R, 1);
steps = size(y,2);

x_est = zeros(n, steps);
y_est = zeros(p, steps);
P = zeros(n, n, steps);

% start with initial estimate of total state
% and covariance
x_p = x0;
P_p = P0;

for i=1:steps
    %----------------------------------------------------------
    % Prediction Step
    % use full NL equations to estimate state at next time step
    % using state at previous time step; since Wk is AWGN,
    % its expected value is zero, set input to zero
    wk = zeros(1,n);
    [~, x_m] = ode45(@NL_DynModel, [0.0 Dt], x_p', [], u', wk);
    x_m = x_m(end,:)';
    
    % to calculate covariance, linearize "online"
    % about current state estimate
    [A_t,B_t,C_t] = Linearize(x_m, u);
    [F, ~, H] = Discretize(A_t, B_t ,C_t, Dt);
    P_m = F*P_p*F' + Q;

    x_m(3) = wrapToPi(x_m(3));
    x_m(6) = wrapToPi(x_m(6));
    
    % uese estimated state from NL ODEs; since Wk is AWGN,
    % its expected value is zero, set to zero
    vk = zeros(p,1);
    y_est(:,i) = NL_MeasModel(x_m, vk);
    
    % calculate innovation vector
    e_y = y(:,i) - y_est(:,i);

    %----------------------------------------------------------
    % Correction Step
    % calculate gain using linearized measurement
    % matrix H and covariance from Prediction Step
    S = H*P_m*H' + R;
    K = P_m*H'/S;

    % calculate posterior state estimate and covariance
    x_p = x_m + K*e_y;
    P_p = (eye(n) - K*H)*P_m;

    x_p(3) = wrapToPi(x_p(3));
    x_p(6) = wrapToPi(x_p(6));
    
    % for each time-step, save estimate and covariance
    x_est(:,i) = x_p;
    P(:,:,i) = P_p;
end

end

