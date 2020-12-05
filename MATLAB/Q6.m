% Question 6 - Compare Filter Performance
close all, clearvars, clc
load("cooplocalization_finalproj_KFdata.mat");

x0 = [10 0 pi/2 -60 0 -pi/2]';
u0 = [2 -pi/18 12 pi/25]';
Dt = 0.1;
n = size(x0,1);
steps = 1000;
seed = 100;
rng(seed);

Qlkf = diag([0.0001 0.0001 0.01 0.1 0.1 0.01]);
Qekf = diag([.0015, .0015, 0.01, 0.001, 0.005, 0.01]);
P0 = diag([1 1 0.025 1 1 0.025]);

runs = 50;
EX = zeros(n, steps+1, runs);
p = 5;
EY = zeros(p, steps+1, runs);
PS = zeros(n, n, steps+1, runs);
SS = zeros(p, p, steps+1, runs);
fig1 = figure(1);
fig2 = figure(2);
fig3 = figure(3);
fig4 = figure(4);
enablePlotDuring = true;
for run = 1:runs
    disp(['run #', num2str(run)]);
    
    % generate truth for run
    [x, y] = GenerateTruth(x0, u0, P0, Qtrue, Rtrue, Dt, steps, false);
    t = (0:(length(x)-1))*Dt;

    % assume we can get exact measurement noise from
    % specifications of sensors
    R = Rtrue;
    
    %----------------------------------------------------------------------
    % LKF
    
    % generate nominal trajectory for run, along with DT matrices
    [x_nom,y_nom] = GenerateNom(x0, u0, steps, Dt);
    [Fk, Hk, Ok] = GenerateLKFMats(u0, x_nom, steps+1, p, Dt);
    dx_init = x(:,1) - x_nom(:,1);
    P_init = eye(n);
    
    % Run filter for all time-steps of run #k
    [x_est,y_est,~,P,S,~,~] = LKF(dx_init, P_init, x_nom, y_nom, x, y, ...
        Fk, Hk, Ok, Qlkf, R);
    
    % wrap angle diff too!!
    ex = x - x_est;
    ex(3,:) = angdiff(x_est(3,:),x(3,:));
    ex(6,:) = angdiff(x_est(6,:),x(6,:));
    ey = y - y_est;
    ey(1,:) = angdiff(y_est(1,:),y(1,:));
    ey(3,:) = angdiff(y_est(3,:),y(3,:));
    
    % save run data from NEES/NIS tests
    EX(:, :, run) = ex;
    EY(:, :, run) = ey;
    PS(:, :, :, run) = P;
    SS(:, :, :, run) = S;
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % EKF
    [x_est, y_est, P, S] = EKF(x0, P0, u0, y, Qekf, R, Dt);
    
    % wrap angle diff too!!
    ex = x - x_est;
    ex(3,:) = angdiff(x_est(3,:),x(3,:));
    ex(6,:) = angdiff(x_est(6,:),x(6,:));
    ey = y - y_est;
    ey(1,:) = angdiff(y_est(1,:),y(1,:));
    ey(3,:) = angdiff(y_est(3,:),y(3,:));
    
    % save run data from NEES/NIS tests
    EX(:, :, run) = ex;
    EY(:, :, run) = ey;
    PS(:, :, :, run) = P;
    SS(:, :, :, run) = S;
    %----------------------------------------------------------------------
    
    % Plot error during monte carlo runs
    if enablePlotDuring == true
        PlotStates(fig1,t,ex, ['State Errors, Run ',num2str(run)], P);
        PlotMeasurements(fig2,t,y,'Ground Truth Measurements');
        PlotStates(fig3,t,x,'Ground Truth States');
        PlotMeasurements(fig4,t,ey,['Ground Truth Measurement Errors, Run ',num2str(run)], S);
    end
end

%% Calculate NEES and NIS statistics 
[NEES_bar, NIS_bar] = CalcStats(EX, EY, PS, SS);

%--------------------------------------------------------------------------
% Plots for (a)
PlotStates(fig1,t,x - x_est, ['State Errors, Run ',num2str(run)], P);
PlotMeasurements(fig2,t,y,'Ground Truth Measurements');
PlotStates(fig3,t,x,'Ground Truth States');
PlotMeasurements(fig4,t,y - y_est,['Ground Truth Measurement Errors, Run ',num2str(run)]);

%--------------------------------------------------------------------------
% Plots for (b)
fig5 = figure(5);
alpha = 0.05;
PlotNees(fig5, NEES_bar, runs, n, alpha);
%--------------------------------------------------------------------------
% Plots for (c)
fig6 = figure(6);
PlotNis(fig6, NIS_bar, runs, p, alpha);
