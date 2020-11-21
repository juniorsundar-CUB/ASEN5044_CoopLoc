function [] = presetPlot(x,y,tit,xlab,ylab,lims,legend)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
plot(x,y,'LineWidth',1.5)
title(tit,'FontSize',16,'Interpreter','latex')
xlabel(xlab,'FontSize',14,'Interpreter','latex')
ylabel(ylab,'FontSize',14,'Interpreter','latex')
axis(lims)
legend(legend,'FontSize',12,'Interpreter','latex')
grid on
end

