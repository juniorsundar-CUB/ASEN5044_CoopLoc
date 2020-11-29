% Tune EKF
load("cooplocalization_finalproj_KFdata.mat");

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
Dt = 0.1;
n = size(x_nom,1);
steps = 1000;
seed = 100;
rng(seed);

Q = diag([0.0001, 0.001, 0.0001, 0.001, 0.001, 0.0001]);
P0 = diag([0.001 0.001 0.001 0.001 0.001 0.001]);

[x, y] = GenerateTruth(x_nom, u_nom, P0, Qtrue, Rtrue, Dt, steps);
t = (0:(length(x)-1))*Dt;
fig1 = figure(1);
PlotStates(fig1,t,x);

% fig2 = figure(2);
% PlotMeasurements(fig2,t,x);

% assume we can get exact measurement noise from
% specifications of sensors
R = Rtrue;
[x_est, y_est, P] = EKF(x_nom, P0, u_nom, y, Q, R, Dt);
fig3 = figure(3);
t = (0:(size(x_est,2)-1))*Dt;
PlotStates(fig3,t,x_est);
