function [x_est,y_est,dx,P,S,e_x,e_y] = LKF(dx_init,P_init,x_nom,y_nom,x,y,Fk,Hk,Ok,Q,R)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
n = size(Fk(:,:,1),2);
p = size(Hk(:,:,1),1);
steps = length(x_nom(1,:))-1;
dx = zeros(n,steps+1);
P = zeros(n,n,steps+1);
S = zeros(p,p,steps+1);
K = zeros(n,p,steps+1);
dx(:,1) = dx_init;
dy = y-y_nom;
P(:,:,1) = P_init;
I = eye(n);
e_y = zeros(p,steps+1);
e_y(:,1) =  y(:,1) - Hk(:,:,1)*(x_nom(:,1) + dx(:,1));

x_nom(3,:) = wrapToPi(x_nom(3,:));
x_nom(6,:) = wrapToPi(x_nom(6,:));
y_nom(1,:) = wrapToPi(y_nom(1,:));
y_nom(3,:) = wrapToPi(y_nom(3,:));
y(1,:) = wrapToPi(y(1,:));
y(3,:) = wrapToPi(y(3,:));
x(3,:) = wrapToPi(x(3,:));
x(6,:) = wrapToPi(x(6,:));

S(:,:,1) = Hk(:,:,1)*P(:,:,1)*Hk(:,:,1)' + R;
K(:,:,1) = P(:,:,1)*Hk(:,:,1)'*inv(S(:,:,1));

for i=1:steps
    % Prediction Step
    dx(:,i+1) = Fk(:,:,i)*dx(:,i);
    P(:,:,i+1) = Fk(:,:,i)*P(:,:,i)*Fk(:,:,i)' + Ok(:,:,i)*Q*Ok(:,:,i)';
    dx(3,i+1) = wrapToPi(dx(3,i+1));
    dx(6,i+1) = wrapToPi(dx(6,i+1));
    % Correction Step
    S(:,:,i+1) = Hk(:,:,i+1)*P(:,:,i+1)*Hk(:,:,i+1)' + R;
    K(:,:,i+1) = P(:,:,i+1)*Hk(:,:,i+1)'*inv(S(:,:,i+1));
    e_y(:,i+1) = y(:,i+1) - Hk(:,:,i+1)*(x_nom(:,i+1) + dx(:,i+1));
    dx(:,i+1) = dx(:,i+1) + K(:,:,i+1)*(dy(:,i+1) - Hk(:,:,i+1)*dx(:,i+1));
    P(:,:,i+1) = (I - K(:,:,i+1)*Hk(:,:,i+1))*P(:,:,i+1);
end
y_est = zeros(5,steps+1);

for i = 1:steps+1
    y_est = Hk(:,:,i)*(x_nom(:,i) + dx(:,i));
end

y_est(1,:) = wrapToPi(y_est(1,:));
y_est(3,:) = wrapToPi(y_est(3,:));

x_est = x_nom + dx;
x_est(3,:) = wrapToPi(x_est(3,:));
x_est(6,:) = wrapToPi(x_est(6,:));

e_x = x - x_est;

end

