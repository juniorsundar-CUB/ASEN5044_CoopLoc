% Question 6 - Compare Filter Performance
close all, clearvars, clc
load("cooplocalization_finalproj_KFdata.mat");

useUnwrappedY = true;       % wrap Y for LKF
runMonteCarlo = false;      % run MC or use Mat data
overlayAllRuns = true;      % plot all runs on top of each other

if runMonteCarlo == true
    x0 = [10 0 pi/2 -60 0 -pi/2]';
    u0 = [2 -pi/18 12 pi/25]';
    steps = 1000;
    runs = 1;

    Q_lkf = diag([0.0001 0.0001 0.01 0.1 0.1 0.01]);
    Q_ekf = diag([.0015, .0015, 0.01, 0.001, 0.005, 0.01]);
    P0 = diag([1 1 0.025 1 1 0.025]);
else
    x0 = [10 0 pi/2 -60 0 -pi/2]';
    u0 = [2 -pi/18 12 pi/25]';
    steps = size(ydata,2) - 2;
    runs = 1;
    Q_lkf = diag([0.0001 0.0001 0.01 0.1 0.1 0.01]);
    Q_ekf = diag([.0015, .0015, 0.01, 0.001, 0.005, 0.01]);
    P0 = diag([1 1 0.025 1 1 0.025]);
end

p = 5;
Dt = 0.1;
n = size(x0,1);
seed = 100;
rng(seed);

EX_lkf = zeros(n, steps+1, runs);
EY_lkf = zeros(p, steps+1, runs);
PS_lkf = zeros(n, n, steps+1, runs);
SS_lkf = zeros(p, p, steps+1, runs);
EX_ekf = EX_lkf;
EY_ekf = EY_lkf;
PS_ekf = PS_lkf;
SS_ekf = SS_lkf;

if runMonteCarlo == true
    fig1 = figure;
    fig3 = figure;
    fig5 = figure;
end

fig2 = figure;
fig4 = figure;
fig6 = figure;

for run = 1:runs
    disp(['run #', num2str(run)]);
    %----------------------------------------------------------------------
    % generate data
    if runMonteCarlo == true
        [x, y] = GenerateTruth(x0, u0, P0, Qtrue, Rtrue, Dt, steps, false);
        t = (0:(length(x)-1))*Dt;
        unwrapped_y = y;
    else
        y = ydata(:,2:end);
        unwrapped_y = y;
        unwrapped_y(1,:) = unwrap(y(1,:));
        unwrapped_y(3,:) =  unwrap(y(3,:));
        x = ones(size(x0,1),size(y,2));
        x(:,1) = x0;
        t = tvec(:,2:end);
        steps = size(y,2) - 1;
    end
    if overlayAllRuns == true
        if runMonteCarlo == true
            PlotStates(fig1,t,x,'Ground Truth States, All Runs');
        end
        PlotMeasurements(fig2,t,y,'Ground Truth Measurements, All Runs');
    end

    % assume we can get exact measurement noise from
    % specifications of sensors
    R = Rtrue;
    
    %----------------------------------------------------------------------
    %----------------------------------------------------------------------
    % LKF
    
    % generate nominal trajectory for run, along with DT matrices
    [x_nom,y_nom] = GenerateNom(x0, u0, steps, Dt);
    [Fk, Hk, Ok] = GenerateLKFMats(u0, x_nom, steps+1, p, Dt);
    dx_init = x0 - x_nom(:,1);
    P_init = eye(n);
    
    % Run filter for all time-steps of run #k
    [x_est_lkf,y_est_lkf,~,P_lkf,S_lkf,~,~] = LKF(dx_init, P_init, x_nom, y_nom, x, unwrapped_y, ...
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
    %----------------------------------------------------------------------
    % Plot error during monte carlo runs
    if overlayAllRuns == true
        if runMonteCarlo == true
            PlotStates(fig3,t,ex_lkf, ['LKF State Errors, Runs ',num2str(run)]);
            PlotStates(fig5,t,ex_ekf, ['EKF State Errors, Runs ',num2str(run)]);
        end
        PlotMeasurements(fig4,t,ey_lkf,['LKF Ground Truth Measurement Errors, Runs ',num2str(run)]);
        PlotMeasurements(fig6,t,ey_ekf,['EKF Ground Truth Measurement Errors, Runs ',num2str(run)]);
    end
end

if overlayAllRuns == false
    if runMonteCarlo == true
        PlotStates(fig1,t,x,'Ground Truth States, All Runs');
        PlotStates(fig3,t,ex_lkf, ['LKF State Errors, Runs ',num2str(run)]);
        PlotStates(fig5,t,ex_ekf, ['EKF State Errors, Runs ',num2str(run)]);
    end
    PlotMeasurements(fig2,t,y,'Ground Truth Measurements, All Runs');
    PlotMeasurements(fig4,t,ey_lkf,['LKF Ground Truth Measurement Errors, Runs ',num2str(run)]);
    PlotMeasurements(fig6,t,ey_ekf,['EKF Ground Truth Measurement Errors, Runs ',num2str(run)]);
end

%% Calculate NEES and NIS statistics 
[NEES_lkf, NIS_lkf] = CalcStats(EX_lkf, EY_lkf, PS_lkf, SS_lkf);
[NEES_ekf, NIS_ekf] = CalcStats(EX_ekf, EY_ekf, PS_ekf, SS_ekf);

%--------------------------------------------------------------------------
% NEES Plot
alpha = 0.05;
if runMonteCarlo == true
    fig7 = figure;
    PlotNees(fig7, NEES_lkf, runs, n, alpha);
    hold all;
    PlotNees(fig7, NEES_ekf, runs, n, alpha);
    hold off;
    legend('LKF $\bar{\epsilon}_x$','$r_1$','$r_2$',...
        'EKF $\bar{\epsilon}_x$','FontSize',12,'Interpreter','latex')
end
%--------------------------------------------------------------------------
% NIS Plot
fig8 = figure;
PlotNis(fig8, NIS_lkf, runs, p, alpha);
hold all;
PlotNis(fig8, NIS_ekf, runs, p, alpha);
hold off;
legend('LKF $\bar{\epsilon}_y$','$r_1$','$r_2$',...
    'EKF $\bar{\epsilon}_y$','FontSize',12,'Interpreter','latex')

%--------------------------------------------------------------------------
%% Comparison Plots
if runMonteCarlo == true
    fig9 = figure;
    fig11 = figure;
end

fig10 = figure;
fig12 = figure;

if runMonteCarlo == true
    x(3,:) = wrapToPi(x(3,:));
    x(6,:) = wrapToPi(x(6,:));
    PlotStates(fig9,t,x,'Ground Truth States');
    PlotStates(fig9,t,x_est_ekf,'Ground Truth States');
    PlotStates(fig9,t,x_est_lkf,'Ground Truth States');
    legend('Truth','LKF','EKF');
end

y(3,:) = wrapToPi(y(3,:));
y(1,:) = wrapToPi(y(1,:));
PlotMeasurements(fig10,t,y,'Ground Truth Measurements');
y_est_lkf(3,:) = wrapToPi(y_est_lkf(3,:));
y_est_lkf(1,:) = wrapToPi(y_est_lkf(1,:));
PlotMeasurements(fig10,t,y_est_lkf,'Ground Truth Measurements');
PlotMeasurements(fig10,t,y_est_ekf,'Ground Truth Measurements');
legend('Truth','LKF','EKF');

if runMonteCarlo == true
    PlotStates(fig11,t,ex_lkf, ['State Errors, Run ',num2str(run)]);
    PlotStates(fig11,t,ex_ekf, ['State Errors, Run ',num2str(run)]);
    legend('LKF','EKF');
end
PlotMeasurements(fig12,t,ey_lkf,['Ground Truth Measurement Errors, Run ',num2str(run)]);
PlotMeasurements(fig12,t,ey_ekf,['Ground Truth Measurement Errors, Run ',num2str(run)]);
legend('LKF','EKF');
