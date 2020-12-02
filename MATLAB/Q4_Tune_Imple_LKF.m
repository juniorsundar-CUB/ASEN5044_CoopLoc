clc
clear
load('cooplocalization_finalproj_KFdata.mat')
seed = 100;
rng(seed);
Dt = 0.1;
steps = 1000;
n = 6; p = 5; t = 0:Dt:steps*Dt;

N = 50;        % No. of Monte Carlo runs
NEES_all = zeros(N,steps+1);
NIS_all = zeros(N,steps+1);

% Tuning parameters
% Q(1,1) = 0.5;
% Q(2,2) = 0.5;
% Q(3,3) = 5;
% Q(4,4) = 5;
% Q(5,5) = 5;
% Q(6,6) = 5;

Q(1,1) = 1;
Q(2,2) = 1;
Q(3,3) = 3;
Q(4,4) = 1;
Q(5,5) = 1;
Q(6,6) = 3;
% Q = 100*eye(6);
% Q = Qtrue;
R = Rtrue;

for i=1:N
    disp(i)
    NEES = zeros(1,steps+1);
    NIS = zeros(1,steps+1);
    
    [x_truth,y_truth,x_est,y_est,dx,P,S,e_x,e_y] = LKF_MonteCarlo(Q,R,steps);
    
    for k=1:steps+1
        NEES(:,k) = e_x(:,k)'*inv(P(:,:,k))*e_x(:,k);
        NIS(:,k) = e_y(:,k)'*inv(S(:,:,k))*e_y(:,k);
    end
    
    NEES_all(i,:) = NEES;
    NIS_all(i,:) = NIS;
end

NEES_bar = zeros(1,steps+1);
NIS_bar = zeros(1,steps+1);

for i=1:steps+1
    NEES_bar(1,i) = mean(NEES_all(:,i));
    NIS_bar(1,i) = mean(NIS_all(:,i));
end

alpha = 0.01;
rx1 = (chi2inv(alpha/2,N*n))./N;
rx2 = (chi2inv(1-alpha/2,N*n))./N;
ry1 = (chi2inv(alpha/2,N*p))./N;
ry2 = (chi2inv(1-alpha/2,N*p))./N;

%% Plots

figure(1)
subplot(2,1,1)
scatter(t,NEES_bar)
hold on
plot(t,ones(1,length(t))*rx1,'r--','LineWidth',1.5)
plot(t,ones(1,length(t))*rx2,'r--','LineWidth',1.5)
hold off
title('NEES Test: $\bar{\epsilon}_x$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('NEES Value | $\bar{\epsilon}_x$','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
legend('$\bar{\epsilon}_x$','$r_1$','$r_2$','FontSize',12,'Interpreter','latex')
axis([min(t) max(t) rx1-1 rx2+1])

subplot(2,1,2)
scatter(t,NIS_bar)
hold on
plot(t,ones(1,length(t))*ry1,'r--','LineWidth',1.5)
plot(t,ones(1,length(t))*ry2,'r--','LineWidth',1.5)
hold off
title('NIS Test: $\bar{\epsilon}_y$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('NIS Value | $\bar{\epsilon}_y$','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
legend('$\bar{\epsilon}_y$','$r_1$','$r_2$','FontSize',12,'Interpreter','latex')
axis([min(t) max(t) ry1-1 ry2+1])

%__________________________________________________________________________

figure(3)
sgtitle('\bf{States Dynamics of Coop Localization}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,x_truth(1,:),'LineWidth',1.5)
hold on
plot(t,x_est(1,:),'r--','LineWidth',1.5)
hold off
title('$\xi_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) 0 20])

subplot(3,2,3)
plot(t,x_truth(2,:),'LineWidth',1.5)
hold on
plot(t,x_est(2,:),'r--','LineWidth',1.5)
hold off
title('$\eta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_g$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) -10 10])

subplot(3,2,5)
plot(t,wrapToPi(x_truth(3,:)),'LineWidth',1.5)
hold on
plot(t,wrapToPi(x_est(3,:)),'r--','LineWidth',1.5)
hold off
title('$\theta_g$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_g$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,2)
plot(t,x_truth(4,:),'LineWidth',1.5)
hold on
plot(t,x_est(4,:),'r--','LineWidth',1.5)
hold off
title('$\xi_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\xi_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,4)
plot(t,x_truth(5,:),'LineWidth',1.5)
hold on
plot(t,x_est(5,:),'r--','LineWidth',1.5)
hold off
title('$\eta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\eta_a$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on

subplot(3,2,6)
plot(t,wrapToPi(x_truth(6,:)),'LineWidth',1.5)
hold on
plot(t,wrapToPi(x_est(6,:)),'r--','LineWidth',1.5)
hold off
title('$\theta_a$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$\theta_a$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
legend({'$x_{truth}$','$x_{estimate}$'},'FontSize',12,'Interpreter','latex')

%__________________________________________________________________________

figure(2)
sgtitle('\bf{State Estimate Errors}','FontSize',18,'Interpreter','latex')
subplot(3,2,1)
plot(t,e_x(1,:),'LineWidth',1.5)
C = zeros(2,length(t));
C(1,:) = 2*(sqrt(P(1,1,:)));
C(2,:) = -2*(sqrt(P(1,1,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\xi_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\xi_g}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) -20 20])

subplot(3,2,3)
plot(t,e_x(2,:),'LineWidth',1.5)
C(1,:) = 2*(sqrt(P(2,2,:)));
C(2,:) = -2*(sqrt(P(2,2,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\eta_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\eta_g}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) -20 20])

subplot(3,2,5)
plot(t,e_x(3,:),'LineWidth',1.5)
C(1,:) = 2*(sqrt(P(3,3,:)));
C(2,:) = -2*(sqrt(P(3,3,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\theta_g}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\theta_g}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) -1 1])

subplot(3,2,2)
plot(t,e_x(4,:),'LineWidth',1.5)
C(1,:) = 2*(sqrt(P(4,4,:)));
C(2,:) = -2*(sqrt(P(4,4,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\xi_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\xi_a}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) -10 10])

subplot(3,2,4)
plot(t,e_x(5,:),'LineWidth',1.5)
C(1,:) = 2*(sqrt(P(5,5,:)));
C(2,:) = -2*(sqrt(P(5,5,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\eta_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\eta_a}$ (m)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
axis([min(t) max(t) -10 10])

subplot(3,2,6)
plot(t,e_x(6,:),'LineWidth',1.5)
C(1,:) = 2*(sqrt(P(6,6,:)));
C(2,:) = -2*(sqrt(P(6,6,:)));
hold on
plot(t,C(1,:),'r--','LineWidth',1.5)
plot(t,C(2,:),'r--','LineWidth',1.5)
hold off
title('$e_{\theta_a}$ vs. $t$','FontSize',16,'Interpreter','latex')
ylabel('$e_{\theta_a}$ (rad)','FontSize',14,'Interpreter','latex')
xlabel('Time | $t$ (s)','FontSize',14,'Interpreter','latex')
grid on
legend({'$e_{x}$','$\pm2\sigma$'},'FontSize',12,'Interpreter','latex')
axis([min(t) max(t) -1 1])