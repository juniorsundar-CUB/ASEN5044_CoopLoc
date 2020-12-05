function PlotMeasurements(hdl,t,y, title, S)

if nargin > 4
    s = zeros(size(y));
    for ind = 1:size(y,2)
        s(:,ind) = 2*sqrt(diag(S(:,:,ind)));
    end
    displayError = true;
else
    displayError = false;
end

figure(hdl)
ftSize = 10;
sgtitle(title,'FontSize',ftSize+2,'Interpreter','latex')
subplot(3,2,1)
output = 1;
plot(t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel('$\gamma_{ag}$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

subplot(3,2,5)
output = output + 1;
plot(t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel('$\rho_{ga}$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

subplot(3,2,3)
output = output + 1;
plot(t,y(3,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel('$\gamma_{ga}$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

subplot(3,2,2)
output = output + 1;
plot(t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel('$\xi_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

subplot(3,2,4)
output = output + 1;
plot(t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel('$\eta_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on
end