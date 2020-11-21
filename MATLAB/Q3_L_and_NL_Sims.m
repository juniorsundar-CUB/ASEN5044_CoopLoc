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

%% Plot
ulab = {'v_g', '\phi_g', 'v_a', '\omega_a'};
xlab = {'\xi_g', '\eta_g', '\theta_g', '\xi_a', '\eta_a', '\theta_a'};
ylab = {'\gamma_{ag}', '\rho_{ga}', '\gamma_ga', '\xi_a', '\eta_a'};

figure(1)
sgtitle('\bf{States Dynamics w/ NL Model}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,x(1,:),'LineWidth',1.5)
title('$\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(x(1,:)) max(x(1,:))])
grid on

subplot(3,2,3)
plot(t,x(2,:),'LineWidth',1.5)
title('$\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(x(2,:)) max(x(2,:))])
grid on

subplot(3,2,5)
plot(t,wrapToPi(x(3,:)),'LineWidth',1.5)
title('$\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(x(3,:))) max(wrapToPi(x(3,:)))])
grid on

subplot(3,2,2)
plot(t,x(4,:),'LineWidth',1.5)
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(x(4,:)) max(x(4,:))])
grid on

subplot(3,2,4)
plot(t,x(5,:),'LineWidth',1.5)
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(x(5,:)) max(x(5,:))])
grid on

subplot(3,2,6)
plot(t,wrapToPi(x(6,:)),'LineWidth',1.5)
title('$\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(x(6,:))) max(wrapToPi(x(6,:)))])
grid on
%__________________________________________________________________________
figure(2)
sgtitle('\bf{Measurements Dynamics w/ NL Model}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,wrapToPi(y(1,:)),'LineWidth',1.5)
title('$\gamma_{ag}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\gamma_{ag}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(y(1,:))) max(wrapToPi(y(1,:)))])
grid on

subplot(3,2,2)
plot(t,y(2,:),'LineWidth',1.5)
title('$\rho_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\rho_{ga}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(y(2,:)) max(y(2,:))])
grid on

subplot(3,2,3)
plot(t,wrapToPi(y(3,:)),'LineWidth',1.5)
title('$\gamma_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\gamma_{ga}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(y(3,:))) max(wrapToPi(y(3,:)))])
grid on

subplot(3,2,4)
plot(t,y(4,:),'LineWidth',1.5)
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(y(4,:)) max(y(4,:))])
grid on

subplot(3,2,[5,6])
plot(t,y(5,:),'LineWidth',1.5)
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
axis([min(t) max(t) min(y(5,:)) max(y(5,:))])
grid on
