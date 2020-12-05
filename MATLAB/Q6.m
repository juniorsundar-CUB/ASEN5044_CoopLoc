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
runs = 5;
p = 5;

Q_lkf = diag([0.0001 0.0001 0.01 0.1 0.1 0.01]);
Q_ekf = diag([.0015, .0015, 0.01, 0.001, 0.005, 0.01]);
P0 = diag([1 1 0.025 1 1 0.025]);


EX_lkf = zeros(n, steps+1, runs);
EY_lkf = zeros(p, steps+1, runs);
PS_lkf = zeros(n, n, steps+1, runs);
SS_lkf = zeros(p, p, steps+1, runs);
EX_ekf = EX_lkf;
EY_ekf = EY_lkf;
PS_ekf = PS_lkf;
SS_ekf = SS_lkf;

fig1 = figure(1);
fig2 = figure(2);
fig3 = figure(3);
fig4 = figure(4);
fig5 = figure(5);
fig6 = figure(6);

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
    [x_est_lkf,y_est_lkf,~,P_lkf,S_lkf,~,~] = LKF(dx_init, P_init, x_nom, y_nom, x, y, ...
        Fk, Hk, Ok, Q_lkf, R);
    
    % wrap angle diff too!!
    ex_lkf = x - x_est_lkf;
    ex_lkf(3,:) = angdiff(x_est_lkf(3,:),x(3,:));
    ex_lkf(6,:) = angdiff(x_est_lkf(6,:),x(6,:));
    ey_lkf = y - y_est_lkf;
    ey_lkf(1,:) = angdiff(y_est_lkf(1,:),y(1,:));
    ey_lkf(3,:) = angdiff(y_est_lkf(3,:),y(3,:));
    
    % save run data from NEES/NIS tests
    EX_lkf(:, :, run) = ex_lkf;
    EY_lkf(:, :, run) = ey_lkf;
    PS_lkf(:, :, :, run) = P_lkf;
    SS_lkf(:, :, :, run) = S_lkf;
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % EKF
    [x_est_ekf, y_est_ekf, P_ekf, S_ekf] = EKF(x0, P0, u0, y, Q_ekf, R, Dt);
    
    % wrap angle diff too!!
    ex_ekf = x - x_est_ekf;
    ex_ekf(3,:) = angdiff(x_est_ekf(3,:),x(3,:));
    ex_ekf(6,:) = angdiff(x_est_ekf(6,:),x(6,:));
    ey_ekf = y - y_est_ekf;
    ey_ekf(1,:) = angdiff(y_est_ekf(1,:),y(1,:));
    ey_ekf(3,:) = angdiff(y_est_ekf(3,:),y(3,:));
    
    % save run data from NEES/NIS tests
    EX_ekf(:, :, run) = ex_ekf;
    EY_ekf(:, :, run) = ey_ekf;
    PS_ekf(:, :, :, run) = P_ekf;
    SS_ekf(:, :, :, run) = S_ekf;
    %----------------------------------------------------------------------
    
    % Plot error during monte carlo runs
    PlotStates(fig1,t,x,'Ground Truth States');
    PlotMeasurements(fig2,t,y,'Ground Truth Measurements');
    PlotStates(fig3,t,ex_lkf, ['LKF State Errors, Run ',num2str(run)], P_lkf);
    PlotMeasurements(fig4,t,ey_lkf,['LKF Ground Truth Measurement Errors, Run ',num2str(run)], S_lkf);
    PlotStates(fig5,t,ex_ekf, ['EKF State Errors, Run ',num2str(run)], P_ekf);
    PlotMeasurements(fig6,t,ey_ekf,['EKF Ground Truth Measurement Errors, Run ',num2str(run)], S_ekf);
end

%% Calculate NEES and NIS statistics 
[NEES_lkf, NIS_lkf] = CalcStats(EX_lkf, EY_lkf, PS_lkf, SS_lkf);
[NEES_ekf, NIS_ekf] = CalcStats(EX_ekf, EY_ekf, PS_ekf, SS_ekf);

%--------------------------------------------------------------------------
% Plots for (b)
fig7 = figure(7);
alpha = 0.05;
PlotNees(fig7, NEES_lkf, runs, n, alpha);
hold all;
PlotNees(fig7, NEES_ekf, runs, n, alpha);
hold off;
legend('LKF $\bar{\epsilon}_x$','$r_1$','$r_2$',...
    'EKF $\bar{\epsilon}_x$','FontSize',12,'Interpreter','latex')
%--------------------------------------------------------------------------
% Plots for (c)
fig8 = figure(8);
PlotNis(fig8, NIS_lkf, runs, p, alpha);
hold all;
PlotNis(fig8, NIS_ekf, runs, p, alpha);
hold off;
legend('LKF $\bar{\epsilon}_y$','$r_1$','$r_2$',...
    'EKF $\bar{\epsilon}_y$','FontSize',12,'Interpreter','latex')
