% Tune EKF
load("cooplocalization_finalproj_KFdata.mat");

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
Dt = 0.1;

n = size(x_nom,1);
P0 = eye(n).*1000;

steps = 1000;
seed = 100;
rng(seed);
[x, y] = GenerateTruth(x_nom, u_nom, P0, Qtrue, Rtrue, Dt, steps);
t = (0:(length(x)-1))*Dt;
fig1 = figure(1);
PlotStates(fig1,t,x);

fig2 = figure(2);
PlotMeasurements(fig2,t,x);

[x_est, y_est, P] = EKF(x_nom, P0, u_nom, y, Qtrue, Rtrue, Dt);
fig3 = figure(3);
t = (0:(length(x_estx)-1))*Dt;
PlotStates(fig3,t,x_est);
