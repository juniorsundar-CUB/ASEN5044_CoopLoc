function PlotStates(hdl,t,x)

figure(hdl)
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
end