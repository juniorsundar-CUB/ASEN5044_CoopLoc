% Tune EKF
load("cooplocalization_finalproj_KFdata.mat");

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
Dt = 0.1;

n = size(x_nom,1);
P0 = eye(n).*0.0003;

steps = 1000;
seed = 100;
[x, y] = GenerateTruth(x_nom, u_nom, P0, Qtrue, Rtrue, Dt, steps, seed);