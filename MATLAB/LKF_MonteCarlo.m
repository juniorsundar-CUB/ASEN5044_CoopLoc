function [x_truth,y_truth,x_est,y_est,dx,P,S,e_x,e_y] = LKF_MonteCarlo(Q,R,steps)
load("cooplocalization_finalproj_KFdata.mat");

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
x_pert = [0 1 0 0 0 0.1]';
Dt = 0.1;

n = size(x_nom,1);
P_init = diag([1 1 0.025 1 1 0.025]);

t = 0:Dt:steps*Dt;
Rtrue(2,2)=1;Rtrue(4,4)=1;Rtrue(5,5)=1;
% Generate truth model outputs for nominal trajectories
[x_truth, y_truth] = GenerateTruth(x_nom, u_nom, P_init, Qtrue, Rtrue, Dt, steps, true);

% Generate nominal trajectories
[~,x_NL] = ode45(@(t,x) NL_DynModel(t,x,u_nom,zeros(6,1)),t,x_nom);
x_NL = x_NL';
y_NL = zeros(5,length(t));
for i=1:length(t)
    y_NL(:,i) = NL_MeasModel(x_NL(:,i),zeros(5,1));
end

% Generate DT matrices along nominal trajectory
x_nominal = x_NL;
y_nominal = y_NL;

x_nominal = WrapX(x_NL);
y_nominal = WrapY(y_NL);

Fk = zeros(6,6,length(t));
Hk = zeros(5,6,length(t));
Ok = zeros(6,6,length(t));

for i=1:length(t)
    [A_t, B_t, C_t] = Linearize(x_nominal(:,i),u_nom);
    [Fk(:,:,i), ~ , Hk(:,:,i)] = Discretize(A_t,B_t,C_t, Dt);
    Ok(:,:,i) = eye(6);
end

% Run LKF on Data
dx_init = x_truth(:,1)-x_nominal(:,1);
P_init = eye(6);

[x_est,y_est,dx,P,S,e_x,e_y] = LKF(dx_init,P_init,x_nominal,y_nominal,x_truth,y_truth,Fk,Hk,Ok,Q,R, true);
end