function PlotNis(hdl, epsNISbar, Nsimruns, p, alpha)

figure(hdl);
Nny = Nsimruns*p;

%%compute intervals:
r1y = chi2inv(alpha/2, Nny )./ Nsimruns;
r2y = chi2inv(1-alpha/2, Nny )./ Nsimruns;

plot(epsNISbar,'bo','MarkerSize',6),hold on
plot(r1y*ones(size(epsNISbar)),'r--')
plot(r2y*ones(size(epsNISbar)),'r--')
ylabel('NIS statistic, $\bar{\epsilon}_y$','FontSize',14,'Interpreter','latex')
xlabel('time step, k','FontSize',14)
title('NIS Estimation Results','FontSize',14)
legend('$\bar{\epsilon}_y$','$r_1$','$r_2$','FontSize',12,'Interpreter','latex')
end

