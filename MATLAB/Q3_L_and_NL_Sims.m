clc
clear

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
x_pert = [0 1 0 0 0 0.1]';
Dt = 0.1;
t = 0:0.1:100;

[~,x] = ode45(@(t,x) NL_DynModel(t,x,u_nom,zeros(6,1)),t,x_nom);
x = x';
y = zeros(5,length(t));
for i=1:length(t)
    y(:,i) = NL_MeasModel(x(:,i),zeros(5,1));
end

fig1 = figure(1);
sgtitle('\bf{States Dynamics w/ NL Model}','FontSize',18,...
    'Interpreter','latex');
PlotStates(fig1,t,x);

fig2 = figure(2);
sgtitle('\bf{Measurements Dynamics w/ NL Model}','FontSize',18,...
    'Interpreter','latex');
PlotMeasurements(fig2,t,y);
