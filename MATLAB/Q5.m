% Tune EKF
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

enablePlotsDuring = false;
runs = 1000;
for runInd = 1:runs
    [x, y] = GenerateTruth(x0, u0, P0.*0.01, Qtrue, Rtrue, Dt, steps);
    t = (0:(length(x)-1))*Dt;
    if enablePlotsDuring == true
        fig1 = figure(1);
        PlotStates(fig1,t,x,'Ground Truth States');
    end

    % assume we can get exact measurement noise from
    % specifications of sensors
    R = Rtrue;
    [x_est, y_est, P] = EKF(x0, P0, u0, y, Q, R, Dt);
    
    if enablePlotsDuring == true
        fig3 = figure(3);
        t = (0:(size(x_est,2)-1))*Dt;
        PlotStates(fig3,t,x - x_est, 'State Error');
    end
end

%--------------------------------------------------------------------------
% Plots for (a)
fig1 = figure(1);
PlotStates(fig1,t,x,'Ground Truth States');

fig2 = figure(2);
PlotMeasurements(fig2,t,x,'Ground Truth Measurements');

fig3 = figure(3);
PlotStates(fig3,t,x - x_est, 'State Errors', P);

%--------------------------------------------------------------------------
% Plots for (b)

%--------------------------------------------------------------------------
% Plots for (c)