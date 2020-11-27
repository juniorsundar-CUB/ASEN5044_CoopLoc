% Tune LKF
clc
clear
load("cooplocalization_finalproj_KFdata.mat");

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
Dt = 0.1;

n = size(x_nom,1);
P0 = eye(n).*0;

steps = 1000;
t = 0:Dt:steps*Dt;
seed = 100;
rng(seed);
Qtrue = zeros(size(Qtrue));
Rtrue = zeros(size(Rtrue));
[x, y] = GenerateTruth(x_nom, u_nom, P0, Qtrue, Rtrue, Dt, steps);