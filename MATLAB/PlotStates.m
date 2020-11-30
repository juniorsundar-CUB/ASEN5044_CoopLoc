function PlotStates(hdl,t,x, title, P)

if nargin > 4
    p = zeros(size(x));
    for ind = 1:size(x,2)
        p(:,ind) = 2*sqrt(diag(P(:,:,ind)));
    end
    displayError = true;
else
    displayError = false;
end

figure(hdl)
ftSize = 10;
sgtitle(title,'FontSize',ftSize+2,'Interpreter','latex')
subplot(3,2,1)
state = 1;
plot(t,x(state,:))
if displayError == true
    hold all, plot(p(state,:),'b--'), plot(-p(state,:),'b--'), hold off
end
ylabel('$\xi_g$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])
grid on

subplot(3,2,3)
state = state + 1;
plot(t,x(state,:))
if displayError == true
    hold all, plot(p(state,:),'b--'), plot(-p(state,:),'b--'), hold off
end
ylabel('$\eta_g$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])
grid on

subplot(3,2,5)
state = state + 1;
plot(t,wrapToPi(x(state,:)))
if displayError == true
    hold all, plot(p(state,:),'b--'), plot(-p(state,:),'b--'), hold off
end
ylabel('$\theta_g$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(x(state,:))) ...
max(wrapToPi(x(state,:)))])
grid on

subplot(3,2,2)
state = state + 1;
plot(t,x(state,:))
if displayError == true
    hold all, plot(p(state,:),'b--'), plot(-p(state,:),'b--'), hold off
end
ylabel('$\xi_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])
grid on

subplot(3,2,4)
state = state + 1;
plot(t,x(state,:))
if displayError == true
    hold all, plot(p(state,:),'b--'), plot(-p(state,:),'b--'), hold off
end
ylabel('$\eta_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])
grid on

subplot(3,2,6)
state = state + 1;
plot(t,wrapToPi(x(state,:)))
if displayError == true
    hold all, plot(p(state,:),'b--'), plot(-p(state,:),'b--'), hold off
end
ylabel('$\theta_a$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel('Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(x(state,:))) ...
max(wrapToPi(x(state,:)))])
grid on
end