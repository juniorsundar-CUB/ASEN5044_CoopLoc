function [x_DTL, dx_DTL, y_DTL, dy_DTL, F, H, O] = DT_L_Model(t,Dt,x_NL,y_NL,x_pert,u_nom)
%DT_L_Model
%   input: t - time; Dt - time increment; x_NL - nominal state trajectory;
%          y_NL - nominal sensor readings; x_pert - initial state
%          perturbation; u_nom = nominal control input;
%   output: x_DTL = discrete time state; dx_DTL = discrete time state 
%           perturbation; y_DTL = discrete time sensor; dy_DTL = discrete
%           time sensor perturbation; F - F_k; H - H_k; O = O_k
%   Function for linear DT model

% u = [v_g, phi_g, v_a, w_a]';
% x = [xi_g eta_g theta_g xi_a eta_a theta_a]';
% ~w = [w_x,g w_y,g w_w,g w_x,a w_y,a w_w,a]';

x_nominal = [x_NL(1,:); x_NL(2,:);
             wrapToPi(x_NL(3,:)); x_NL(4,:);
             x_NL(5,:); wrapToPi(x_NL(6,:))];
y_nominal = y_NL;

F = zeros(6,6,length(t));
H = zeros(5,6,length(t));
O = zeros(6,6,length(t));

% Evaluate F and H matrices with predef nominal state trajectories
for i=1:length(t)
    [A_t, ~, C_t] = Linearize(x_nominal(:,i),u_nom);
    F(:,:,i) = eye(6) + A_t*Dt;
    H(:,:,i) = C_t;
    O(:,:,i) = Dt*eye(6,6);
end

dx_DTL = zeros(6,length(t));
dy_DTL = zeros(5,length(t));
x_DTL = zeros(6,length(t));
y_DTL = zeros(5,length(t));
dx_DTL(:,1) = x_pert;
dy_DTL(:,1) = H(:,:,1)*x_pert;
x_DTL(:,1) = x_nominal(:,1)+dx_DTL(:,1);
y_DTL(:,1) = y_nominal(:,1)+dy_DTL(:,1);

for i=2:length(t)
    dx_DTL(:,i) = F(:,:,i)*dx_DTL(:,i-1);
    dy_DTL(:,i) = H(:,:,i)*dx_DTL(:,i);
    x_DTL(:,i) = x_nominal(:,i)+dx_DTL(:,i);
    y_DTL(:,i) = y_nominal(:,i)+dy_DTL(:,i);
end
end