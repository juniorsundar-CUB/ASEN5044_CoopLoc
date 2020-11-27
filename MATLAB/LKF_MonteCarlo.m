function [x_est,dx,P,S,e_x,e_y] = LKF_MonteCarlo(Q,R)
load("cooplocalization_finalproj_KFdata.mat");

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
x_pert = [0 1 0 0 0 0.1]';
Dt = 0.1;

n = size(x_nom,1);
P0 = eye(n).*0;

steps = 1000;
t = 0:Dt:steps*Dt;

% Generate truth model outputs for nominal trajectories
[x_truth, y_truth] = GenerateTruth(x_nom, u_nom, P0, Qtrue, Rtrue, Dt, steps);

% Generate nominal trajectories
[~,x_NL] = ode45(@(t,x) NL_DynModel(t,x,u_nom,zeros(6,1)),t,x_nom);
x_NL = x_NL';
y_NL = zeros(5,length(t));
for i=1:length(t)
    y_NL(:,i) = NL_MeasModel(x_NL(:,i),zeros(5,1));
end

% Generate DT matrices along nominal trajectory
x_nominal = [x_NL(1,:); x_NL(2,:);
             wrapToPi(x_NL(3,:)); x_NL(4,:);
             x_NL(5,:); wrapToPi(x_NL(6,:))];
y_nominal = y_NL;

Fk = zeros(6,6,length(t));
Hk = zeros(5,6,length(t));
Ok = zeros(6,6,length(t));

for i=1:length(t)
    [A_t, B_t, C_t] = Linearize(x_nominal(:,i),u_nom);
    [Fk(:,:,i), ~ , Hk(:,:,i)] = Discretize(A_t,B_t,C_t, Dt);
    Ok(:,:,i) = eye(6);
end

% Run LKF on Data
dx_init = x_pert;
P_init = 999*eye(6);

[x_est,dx,P,S,e_x,e_y] = LKF(dx_init,P_init,x_NL,y_NL,x_truth,y_truth,Fk,Hk,Ok,Q,R);
end

