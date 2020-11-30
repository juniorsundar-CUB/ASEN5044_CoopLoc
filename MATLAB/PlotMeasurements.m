function PlotMeasurements(hdl,t,y, title)
figure(hdl)
ftSize = 10;
sgtitle(title,'FontSize',ftSize+2,'Interpreter','latex')
subplot(3,2,1)
plot(t,wrapToPi(y(1,:)))
ylabel('$\gamma_{ag}$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(y(1,:))) max(wrapToPi(y(1,:)))])
grid on

subplot(3,2,2)
plot(t,y(2,:))
ylabel('$\rho_{ga}$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(2,:)) max(y(2,:))])
grid on

subplot(3,2,3)
plot(t,wrapToPi(y(3,:)))
ylabel('$\gamma_{ga}$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(y(3,:))) max(wrapToPi(y(3,:)))])
grid on

subplot(3,2,4)
plot(t,y(4,:))
ylabel('$\xi_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(4,:)) max(y(4,:))])
grid on

subplot(3,2,[5,6])
plot(t,y(5,:))
ylabel('$\eta_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(5,:)) max(y(5,:))])
grid on
end