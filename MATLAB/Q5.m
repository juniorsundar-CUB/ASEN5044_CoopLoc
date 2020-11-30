% Tune EKF
close all, clear all, clc
load("cooplocalization_finalproj_KFdata.mat");

x0 = [10 0 pi/2 -60 0 -pi/2]';
u0 = [2 -pi/18 12 pi/25]';
Dt = 0.1;
n = size(x0,1);
steps = 1000;
seed = 100;
rng(seed);

Q = diag([.15, .15, 0.1, 0.01, 0.05, 0.1]);
P0 = diag([1 1 0.025 1 1 0.025]);

runs = 100;
EX = zeros(n, steps+1, runs);
p = 5;
EY = zeros(p, steps+1, runs);
PS = zeros(n, n, steps+1, runs);
SS = zeros(p, p, steps+1, runs);
fig1 = figure(1);
fig4 = figure(4);
for run = 1:runs
    % generate truth for run
    [x, y] = GenerateTruth(x0, u0, P0, Qtrue, Rtrue, Dt, steps);
    t = (0:(length(x)-1))*Dt;

    % assume we can get exact measurement noise from
    % specifications of sensors
    R = Rtrue;
    
    % Run filter for all time-steps of run #k
    [x_est, y_est, P, S] = EKF(x0, P0, u0, y, Q, R, Dt);
    
    % Plot error during monte carlo runs
    PlotStates(fig1,t,x - x_est, ['State Errors, Run #',num2str(run)], P);
    PlotMeasurements(fig4,t,y - y_est,['Ground Truth Measurements, Run #',num2str(run)]);
    
    % save run data from NEES/NIS tests
    EX(:, :, run) = x - x_est;
    EY(:, :, run) = y - y_est;
    PS(:, :, :, run) = P;
    SS(:, :, :, run) = S;
end

%% Calculate NEES and NIS statistics 
[NEES_bar, NIS_bar] = CalcStats(EX, EY, PS, SS);

%--------------------------------------------------------------------------
% Plots for (a)
PlotStates(fig1,t,x - x_est, ['State Errors, Run #',num2str(run)], P);
PlotMeasurements(fig4,t,y - y_est,['Ground Truth Measurements, Run #',num2str(run)]);
    
fig1 = figure(2);
PlotStates(fig1,t,x,'Ground Truth States');

fig2 = figure(3);
PlotMeasurements(fig2,t,x,'Ground Truth Measurements');

%--------------------------------------------------------------------------
% Plots for (b)
fig4 = figure(4);
alpha = 0.5;
PlotNees(fig4, NEES_bar, runs, n, alpha);
%--------------------------------------------------------------------------
% Plots for (c)
fig5 = figure(5);
PlotNis(fig5, NIS_bar, runs, p, alpha);
