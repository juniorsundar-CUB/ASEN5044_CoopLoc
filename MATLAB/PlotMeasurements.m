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
if isempty(hdl.Children)
    tiledlayout(3,2);
    ax1 = nexttile;
    ax2 = nexttile;
    ax3 = nexttile;
    ax4 = nexttile;
    ax5 = nexttile;
else
    thdl = hdl.Children;
    ax1 = thdl.Children(5,1);
    ax2 = thdl.Children(4,1);
    ax3 = thdl.Children(3,1);
    ax4 = thdl.Children(2,1);
    ax5 = thdl.Children(1,1);
end

hold([ax1 ax2 ax3 ax4 ax5],'on');
ftSize = 10;
sgtitle(title,'FontSize',ftSize+2,'Interpreter','latex')
output = 1;
plot(ax1, t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel(ax1, '$\gamma_{ag}$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax1, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

output = output + 1;
plot(ax5, t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel(ax5, '$\rho_{ga}$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax5, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

output = output + 1;
plot(ax3, t,y(3,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel(ax3, '$\gamma_{ga}$ (rad)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax3, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

output = output + 1;
plot(ax2, t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel(ax2, '$\xi_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax2, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

output = output + 1;
plot(ax4, t,y(output,:))
if displayError == true
    hold all, plot(s(output,:),'r--'), plot(-s(output,:),'r--'), hold off
end
ylabel(ax4, '$\eta_a$ (m)','FontSize',ftSize,'Interpreter','latex')
xlabel(ax4, 'Time(s)','FontSize',ftSize,'Interpreter','latex')
axis([min(t) max(t) min(y(output,:)) max(y(output,:))])
grid on

grid([ax1 ax2 ax3 ax4 ax5],'on');
hold([ax1 ax2 ax3 ax4 ax5],'off');
end