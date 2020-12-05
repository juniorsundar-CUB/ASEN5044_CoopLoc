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
if isempty(hdl.Children)
    tiledlayout(3,2);
    ax1 = nexttile;
    ax2 = nexttile;
    ax3 = nexttile;
    ax4 = nexttile;
    ax5 = nexttile;
    ax6 = nexttile;
else
    thdl = hdl.Children;
    ax1 = thdl.Children(6,1);
    ax2 = thdl.Children(5,1);
    ax3 = thdl.Children(4,1);
    ax4 = thdl.Children(3,1);
    ax5 = thdl.Children(2,1);
    ax6 = thdl.Children(1,1);
end

hold([ax1 ax2 ax3 ax4 ax5 ax6],'on');

ftSize = 10;
sgtitle(title,'FontSize',ftSize+2,'Interpreter','latex')
state = 1;

plot(ax1, t,x(state,:))
if displayError == true
    plot(ax1, p(state,:),'r--'), plot(ax1, -p(state,:),'r--')
end
ylabel(ax1, '$\xi_g$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax1, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])

state = state + 1;
plot(ax3, t,x(state,:))
if displayError == true
    plot(ax3, p(state,:),'r--'), plot(ax3, -p(state,:),'r--')
end
ylabel(ax3, '$\eta_g$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax3, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])

state = state + 1;
plot(ax5, t,wrapToPi(x(state,:)))
if displayError == true
    plot(ax5, p(state,:),'r--'), plot(ax5, -p(state,:),'r--')
end
ylabel(ax5, '$\theta_g$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax5, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(x(state,:))) ...
max(wrapToPi(x(state,:)))])

state = state + 1;
plot(ax2, t,x(state,:))
if displayError == true
    plot(ax2, p(state,:),'r--'), plot(ax2, -p(state,:),'r--')
end
ylabel(ax2, '$\xi_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax2, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])

state = state + 1;
plot(ax4, t,x(state,:))
if displayError == true
    plot(ax4, p(state,:),'r--'), plot(ax4, -p(state,:),'r--')
end
ylabel(ax4, '$\eta_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax4, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(x(state,:)) ...
max(x(state,:))])

state = state + 1;
plot(ax6, t,wrapToPi(x(state,:)))
if displayError == true
    plot(ax6, p(state,:),'r--'), plot(ax6, -p(state,:),'r--')
end
ylabel(ax6, '$\theta_a$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax6, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(wrapToPi(x(state,:))) ...
max(wrapToPi(x(state,:)))])

grid([ax1 ax2 ax3 ax4 ax5 ax6],'on');
hold([ax1 ax2 ax3 ax4 ax5 ax6],'off');
end