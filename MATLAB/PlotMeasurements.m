function PlotMeasurements(hdl,t,y)

figure(hdl)

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
end