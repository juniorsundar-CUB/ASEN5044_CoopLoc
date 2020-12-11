close all
figure(2)
sgtitle('\bf{States Trajectories and 2$\sigma$ bounds w/ LKF Estimate}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,x_est_lkf(1,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(1,1,:)));
C(2,:) = -2*(sqrt(P_lkf(1,1,:)));
hold on
plot(t,x_est_lkf(1,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_lkf(1,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) 0 20])

subplot(3,2,3)
plot(t,x_est_lkf(2,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(2,2,:)));
C(2,:) = -2*(sqrt(P_lkf(2,2,:)));
hold on
plot(t,x_est_lkf(2,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_lkf(2,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) -10 10])

subplot(3,2,5)
plot(t,x_est_lkf(3,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(3,3,:)));
C(2,:) = -2*(sqrt(P_lkf(3,3,:)));
hold on
plot(t,x_est_lkf(3,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_lkf(3,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,x_est_lkf(4,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(4,4,:)));
C(2,:) = -2*(sqrt(P_lkf(4,4,:)));
hold on
plot(t,x_est_lkf(4,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_lkf(4,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,x_est_lkf(5,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(5,5,:)));
C(2,:) = -2*(sqrt(P_lkf(5,5,:)));
hold on
plot(t,x_est_lkf(5,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_lkf(5,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,6)
plot(t,x_est_lkf(6,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(6,6,:)));
C(2,:) = -2*(sqrt(P_lkf(6,6,:)));
hold on
plot(t,x_est_lkf(6,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_lkf(6,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
legend({'$x_{est}$','$\pm 2\sigma$'},'FontSize',12,'Interpreter','latex')

%__________________________________________________________________________
figure(3)
sgtitle('\bf{States Trajectories and 2$\sigma$ bounds w/ EKF Estimate}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,x_est_ekf(1,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(1,1,:)));
C(2,:) = -2*(sqrt(P_ekf(1,1,:)));
hold on
plot(t,x_est_ekf(1,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_ekf(1,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) 0 20])

subplot(3,2,3)
plot(t,x_est_ekf(2,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(2,2,:)));
C(2,:) = -2*(sqrt(P_ekf(2,2,:)));
hold on
plot(t,x_est_ekf(2,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_ekf(2,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) -10 10])

subplot(3,2,5)
plot(t,x_est_ekf(3,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(3,3,:)));
C(2,:) = -2*(sqrt(P_ekf(3,3,:)));
hold on
plot(t,x_est_ekf(3,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_ekf(3,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,x_est_ekf(4,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(4,4,:)));
C(2,:) = -2*(sqrt(P_ekf(4,4,:)));
hold on
plot(t,x_est_ekf(4,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_ekf(4,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,x_est_ekf(5,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(5,5,:)));
C(2,:) = -2*(sqrt(P_ekf(5,5,:)));
hold on
plot(t,x_est_ekf(5,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_ekf(5,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,6)
plot(t,x_est_ekf(6,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(6,6,:)));
C(2,:) = -2*(sqrt(P_ekf(6,6,:)));
hold on
plot(t,x_est_ekf(6,:)+C(1,:),'r--','LineWidth',1.5)
plot(t,x_est_ekf(6,:)+C(2,:),'r--','LineWidth',1.5)
hold off
title('$\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
legend({'$x_{est}$','$\pm 2\sigma$'},'FontSize',12,'Interpreter','latex')

%%
figure(4)
sgtitle('\bf{States Errors and 2$\sigma$ bounds w/ LKF Estimate}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,ex_lkf(1,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(1,1,:)));
C(2,:) = -2*(sqrt(P_lkf(1,1,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\xi_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\xi_g}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) 0 20])

subplot(3,2,3)
plot(t,ex_lkf(2,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(2,2,:)));
C(2,:) = -2*(sqrt(P_lkf(2,2,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\eta_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\eta_g}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) -10 10])

subplot(3,2,5)
plot(t,ex_lkf(3,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(3,3,:)));
C(2,:) = -2*(sqrt(P_lkf(3,3,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\theta_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\theta_g}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,ex_lkf(4,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(4,4,:)));
C(2,:) = -2*(sqrt(P_lkf(4,4,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\xi_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\xi_a}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,ex_lkf(5,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(5,5,:)));
C(2,:) = -2*(sqrt(P_lkf(5,5,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\eta_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\eta_a}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,6)
plot(t,ex_lkf(6,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_lkf(6,6,:)));
C(2,:) = -2*(sqrt(P_lkf(6,6,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\theta_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\theta_a}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
legend({'$e_{x}$','$\pm2\sigma$'},'FontSize',12,'Interpreter','latex')

%__________________________________________________________________________
figure(5)
sgtitle('\bf{States Errors and 2$\sigma$ bounds w/ EKF Estimate}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,ex_ekf(1,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(1,1,:)));
C(2,:) = -2*(sqrt(P_ekf(1,1,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\xi_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\xi_g}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) 0 20])

subplot(3,2,3)
plot(t,ex_ekf(2,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(2,2,:)));
C(2,:) = -2*(sqrt(P_ekf(2,2,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\eta_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\eta_g}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
% axis([min(t) max(t) -10 10])

subplot(3,2,5)
plot(t,ex_ekf(3,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(3,3,:)));
C(2,:) = -2*(sqrt(P_ekf(3,3,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\theta_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\theta_g}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,ex_ekf(4,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(4,4,:)));
C(2,:) = -2*(sqrt(P_ekf(4,4,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\xi_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\xi_a}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,ex_ekf(5,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(5,5,:)));
C(2,:) = -2*(sqrt(P_ekf(5,5,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\eta_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\eta_a}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,6)
plot(t,ex_ekf(6,:),'b-','LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P_ekf(6,6,:)));
C(2,:) = -2*(sqrt(P_ekf(6,6,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\theta_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\theta_a}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
legend({'$e_{x}$','$\pm2\sigma$'},'FontSize',12,'Interpreter','latex')