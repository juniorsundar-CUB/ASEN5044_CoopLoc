% Question 5 - Tune EKF
close all, clearvars, clc
load("cooplocalization_finalproj_KFdata.mat");

x0 = [10 0 pi/2 -60 0 -pi/2]';
u0 = [2 -pi/18 12 pi/25]';
Dt = 0.1;
n = size(x0,1);
steps = 1000;
seed = 100;
rng(seed);

Q = [	.000001     0           1e-6	0       0       0;
        0           .000001     1e-6	0       0       0;
        1e-6        1e-6        .001	0       0       0;
        0           0           0     	.00075  0       1e-6;
        0           0           0     	0       .00075  1e-6;
        0           0           0     	1e-6	1e-6	.008]./18;
    
P0 = diag([(1/2)^2 (1/2)^2 (0.25/2)^2 (2.5/2)^2 (2.5/2)^2 (0.25/2)^2]);

runs = 100;
EX = zeros(n, steps+1, runs);
p = 5;
EY = zeros(p, steps+1, runs);
PS = zeros(n, n, steps+1, runs);
SS = zeros(p, p, steps+1, runs);
fig1 = figure;
enablePlotDuring = false;
for run = 1:runs
    disp(['run #', num2str(run)]);
    
    % generate truth for run
    [x, y] = GenerateTruth(x0, u0, P0, Qtrue, Rtrue, Dt, steps, true);
    t = (0:(length(x)-1))*Dt;

    % assume we can get exact measurement noise from
    % specifications of sensors
    R = Rtrue;
    
    % Run filter for all time-steps of run #k
    [x_est, y_est, P, S] = EKF(x0, P0, u0, y, Q, R, Dt);
    
    % wrap angle diff too!!
    ex = WrapX(x - x_est);
    ey = WrapY(y - y_est);
    
    % Plot error during monte carlo runs
    if enablePlotDuring == true
        PlotStates(fig1,t,ex, ['State Errors, Run ',num2str(run)], P);
    end
    
    % save run data from NEES/NIS tests
    EX(:, :, run) = ex;
    EY(:, :, run) = ey;
    PS(:, :, :, run) = P;
    SS(:, :, :, run) = S;
end

%% Calculate NEES and NIS statistics 
[NEES_bar, NIS_bar] = CalcStats(EX, EY, PS, SS);

%--------------------------------------------------------------------------
% Plots for (a)
PlotStates(fig1,t,ex, ['State Errors, Run ',num2str(run)], P);

fig2 = figure;
fig3 = figure;
fig4 = figure;
PlotMeasurements(fig2,t,y,'Ground Truth Measurements');
PlotStates(fig3,t,x,'Ground Truth States');
PlotMeasurements(fig4,t,ey,['Ground Truth Measurement Errors, Run ',num2str(run)]);

%--------------------------------------------------------------------------
% Plots for (b)
fig5 = figure;
alpha = 0.01;
PlotNees(fig5, NEES_bar, runs, n, alpha);
%--------------------------------------------------------------------------
% Plots for (c)
fig6 = figure;
alpha = 0.01;
PlotNis(fig6, NIS_bar, runs, p, alpha);
