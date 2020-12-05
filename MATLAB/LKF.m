function [x_est,y_est,dx,P,S,e_x,e_y] = LKF(dx_init,P_init,x_nom,y_nom,x,y,Fk,Hk,Ok,Q,R)

n = size(Fk(:,:,1),2);          % No. of States
p = size(Hk(:,:,1),1);          % No. of Measurements
steps = length(x_nom(1,:))-1;   % No. of k steps
dx = zeros(n,steps+1);
P = zeros(n,n,steps+1);
S = zeros(p,p,steps+1);
K = zeros(n,p,steps+1);

dx(:,1) = dx_init;              % initial dx
dy = y-y_nom;                   % ground truth dx

P(:,:,1) = P_init;              % inital P
I = eye(n);

y_est = zeros(5,steps+1);
y_est(:,1) = y_nom(:,1) + Hk(:,:,1)*(dx(:,1));

e_y = zeros(p,steps+1);
e_y(:,1) =  y(:,1) - y_est(:,1);% error in measurement estimates

S(:,:,1) = Hk(:,:,1)*P(:,:,1)*Hk(:,:,1)' + R;
K(:,:,1) = P(:,:,1)*Hk(:,:,1)'*inv(S(:,:,1));

for i=1:steps
    % Prediction Step
    dx(:,i+1) = Fk(:,:,i)*dx(:,i);
    P(:,:,i+1) = Fk(:,:,i)*P(:,:,i)*Fk(:,:,i)' + Ok(:,:,i)*Q*Ok(:,:,i)';
    % Correction Step
    S(:,:,i+1) = Hk(:,:,i+1)*P(:,:,i+1)*Hk(:,:,i+1)' + R;
    K(:,:,i+1) = P(:,:,i+1)*Hk(:,:,i+1)'*inv(S(:,:,i+1));
    y_est(:,i+1) = y_nom(:,i) + Hk(:,:,i+1)*(dx(:,i+1));
    
    e_y(:,i+1) = y(:,i+1) - y_est(:,i+1);
    
    dx(:,i+1) = dx(:,i+1) + K(:,:,i+1)*(dy(:,i+1) - Hk(:,:,i+1)*dx(:,i+1));
    P(:,:,i+1) = (I - K(:,:,i+1)*Hk(:,:,i+1))*P(:,:,i+1);
end

x_est = x_nom + dx;
e_x = x - x_est;
end