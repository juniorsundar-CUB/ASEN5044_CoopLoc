%% NL Model
clc
clear

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
y_nom = NL_MeasModel(x_nom,zeros(5,1));
x_pert = [0 1 0 0 0 0.1]';
Dt = 0.1;
t = 0:Dt:100;

[~,x_NL] = ode45(@(t,x) NL_DynModel(t,x,u_nom,zeros(6,1)),t,x_nom);
x_NL = x_NL';
y_NL = zeros(5,length(t));
for i=1:length(t)
    y_NL(:,i) = NL_MeasModel(x_NL(:,i),zeros(5,1));
end

%% DT L Model
x_nominal = [x_NL(1,:); x_NL(2,:);
             wrapToPi(x_NL(3,:)); x_NL(4,:);
             x_NL(5,:); wrapToPi(x_NL(6,:))];
y_nominal = y_NL;

F = zeros(6,6,length(t));
H = zeros(5,6,length(t));


for i=1:length(t)
    [A_t, ~, C_t] = Linearize(x_nominal(:,i),u_nom);
    F(:,:,i) = eye(6) + A_t*Dt;
    H(:,:,i) = C_t;
end

[x_DTL, dx_DTL, y_DTL, dy_DTL, ~,~,~] = DT_L_Model(t,Dt,x_NL,y_NL,x_pert,u_nom);

%% Plot 2
ulab = {'v_g', '\phi_g', 'v_a', '\omega_a'};
xlab = {'\xi_g', '\eta_g', '\theta_g', '\xi_a', '\eta_a', '\theta_a'};
ylab = {'\gamma_{ag}', '\rho_{ga}', '\gamma_ga', '\xi_a', '\eta_a'};

figure(1)
sgtitle('\bf{States Dynamics DTL and NL Model}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,x_DTL(1,:),'LineWidth',1.5)
hold on
plot(t,x_NL(1,:),'r--','LineWidth',1.5)
hold off
title('$\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_DTL(1,:)) max(x_DTL(1,:))])
grid on

subplot(3,2,3)
plot(t,x_DTL(2,:),'LineWidth',1.5)
hold on
plot(t,x_NL(2,:),'r--','LineWidth',1.5)
hold off
title('$\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_DTL(2,:)) max(x_DTL(2,:))])
grid on

subplot(3,2,5)
plot(t,wrapToPi(x_DTL(3,:)),'LineWidth',1.5)
hold on
plot(t,wrapToPi(x_NL(3,:)),'r--','LineWidth',1.5)
hold off
title('$\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(x_DTL(3,:))) max(wrapToPi(x_DTL(3,:)))])
grid on

subplot(3,2,2)
plot(t,x_DTL(4,:),'LineWidth',1.5)
hold on
plot(t,x_NL(4,:),'r--','LineWidth',1.5)
hold off
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_DTL(4,:)) max(x_DTL(4,:))])
grid on

subplot(3,2,4)
plot(t,x_DTL(5,:),'LineWidth',1.5)
hold on
plot(t,x_NL(5,:),'r--','LineWidth',1.5)
hold off
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_DTL(5,:)) max(x_DTL(5,:))])
grid on

subplot(3,2,6)
plot(t,wrapToPi(x_DTL(6,:)),'LineWidth',1.5)
hold on
plot(t,wrapToPi(x_NL(6,:)),'r--','LineWidth',1.5)
hold off
title('$\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(x_DTL(6,:))) max(wrapToPi(x_DTL(6,:)))])
grid on
legend({'DT Linearised','Nonlinear'},'FontSize',12,'Interpreter','latex')

%__________________________________________________________________________
figure(2)
sgtitle('\bf{Measurements Dynamics DTL and NL Model}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,wrapToPi(y_DTL(1,:)),'LineWidth',1.5)
hold on
plot(t,wrapToPi(y_NL(1,:)),'r--','LineWidth',1.5)
hold off
title('$\gamma_{ag}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\gamma_{ag}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(y_DTL(1,:))) max(wrapToPi(y_DTL(1,:)))])
grid on

subplot(3,2,2)
plot(t,y_DTL(2,:),'LineWidth',1.5)
hold on
plot(t,y_NL(2,:),'r--','LineWidth',1.5)
hold off
title('$\rho_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\rho_{ga}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(y_DTL(2,:)) max(y_DTL(2,:))])
grid on

subplot(3,2,3)
plot(t,wrapToPi(y_DTL(3,:)),'LineWidth',1.5)
hold on
plot(t,wrapToPi(y_NL(3,:)),'r--','LineWidth',1.5)
hold off
title('$\gamma_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\gamma_{ga}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(y_DTL(3,:))) max(wrapToPi(y_DTL(3,:)))])
grid on

subplot(3,2,4)
plot(t,y_DTL(4,:),'LineWidth',1.5)
hold on
plot(t,y_NL(4,:),'r--','LineWidth',1.5)
hold off
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(y_DTL(4,:)) max(y_DTL(4,:))])
grid on

subplot(3,2,[5,6])
plot(t,y_DTL(5,:),'LineWidth',1.5)
hold on
plot(t,y_NL(5,:),'r--','LineWidth',1.5)
hold off
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(y_DTL(5,:)) max(y_DTL(5,:))])
grid on
legend({'DT Linearised','Nonlinear'},'FontSize',12,'Interpreter','latex')
%__________________________________________________________________________
% figure(3)
% sgtitle('\bf{States Dynamics w/ NL Model}','FontSize',18,'Interpreter','latex')
% subplot(3,2,1)
% plot(t,x_NL(1,:),'LineWidth',1.5)
% title('$\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\xi_g$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_NL(1,:)) max(x_NL(1,:))])
% grid on

% subplot(3,2,3)
% plot(t,x_NL(2,:),'LineWidth',1.5)
% title('$\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\eta_g$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_NL(2,:)) max(x_NL(2,:))])
% grid on

% subplot(3,2,5)
% plot(t,wrapToPi(x_NL(3,:)),'LineWidth',1.5)
% title('$\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(x_NL(3,:))) max(wrapToPi(x_NL(3,:)))])
% grid on

% subplot(3,2,2)
% plot(t,x_NL(4,:),'LineWidth',1.5)
% title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_NL(4,:)) max(x_NL(4,:))])
% grid on

% subplot(3,2,4)
% plot(t,x_NL(5,:),'LineWidth',1.5)
% title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(x_NL(5,:)) max(x_NL(5,:))])
% grid on

% subplot(3,2,6)
% plot(t,wrapToPi(x_NL(6,:)),'LineWidth',1.5)
% title('$\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(x_NL(6,:))) max(wrapToPi(x_NL(6,:)))])
% grid on
%__________________________________________________________________________
% figure(4)
% sgtitle('\bf{Measurements Dynamics w/ NL Model}','FontSize',18,'Interpreter','latex')
% subplot(3,2,1)
% plot(t,wrapToPi(y_NL(1,:)),'LineWidth',1.5)
% title('$\gamma_{ag}$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\gamma_{ag}$ (rad)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(y_NL(1,:))) max(wrapToPi(y_NL(1,:)))])
% grid on

% subplot(3,2,2)
% plot(t,y_NL(2,:),'LineWidth',1.5)
% title('$\rho_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\rho_{ga}$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(y_NL(2,:)) max(y_NL(2,:))])
% grid on

% subplot(3,2,3)
% plot(t,wrapToPi(y_NL(3,:)),'LineWidth',1.5)
% title('$\gamma_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\gamma_{ga}$ (rad)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(wrapToPi(y_NL(3,:))) max(wrapToPi(y_NL(3,:)))])
% grid on

% subplot(3,2,4)
% plot(t,y_NL(4,:),'LineWidth',1.5)
% title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(y_NL(4,:)) max(y_NL(4,:))])
% grid on

% subplot(3,2,[5,6])
% plot(t,y_NL(5,:),'LineWidth',1.5)
% title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
% ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
% xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
% axis([min(t) max(t) min(y_NL(5,:)) max(y_NL(5,:))])
% grid on
%__________________________________________________________________________
figure(5)
sgtitle('\bf{States Perturbations w/ DT Linear Model}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,dx_DTL(1,:),'LineWidth',1.5)
title('$\delta\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\xi_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,3)
plot(t,dx_DTL(2,:),'LineWidth',1.5)
title('$\delta\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\eta_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,5)
plot(t,wrapToPi(dx_DTL(3,:)),'LineWidth',1.5)
title('$\delta\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,dx_DTL(4,:),'LineWidth',1.5)
title('$\delta\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,dx_DTL(5,:),'LineWidth',1.5)
title('$\delta\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,6)
plot(t,wrapToPi(dx_DTL(6,:)),'LineWidth',1.5)
title('$\delta\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
%__________________________________________________________________________
figure(6)
sgtitle('\bf{Measurements Perturbations w/ DT Linear Model}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,wrapToPi(dy_DTL(1,:)),'LineWidth',1.5)
title('$\delta\gamma_{ag}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\gamma_{ag}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,dy_DTL(2,:),'LineWidth',1.5)
title('$\delta\rho_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\rho_{ga}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,3)
plot(t,wrapToPi(dy_DTL(3,:)),'LineWidth',1.5)
title('$\delta\gamma_{ga}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\gamma_{ga}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,dy_DTL(4,:),'LineWidth',1.5)
title('$\delta\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,[5,6])
plot(t,dy_DTL(5,:),'LineWidth',1.5)
title('$\delta\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\delta\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
