function PlotNees(hdl, epsNEESbar, Nsimruns, n, alpha)

figure(hdl);
Nnx = Nsimruns*n;

%%compute intervals:
r1x = chi2inv(alpha/2, Nnx )./ Nsimruns;
r2x = chi2inv(1-alpha/2, Nnx )./ Nsimruns;

figure(hdl)
plot(epsNEESbar,'o','MarkerSize',6),hold on
plot(r1x*ones(size(epsNEESbar)),'r--')
plot(r2x*ones(size(epsNEESbar)),'r--')
ylabel('NEES statistic, $\bar{\epsilon}_x$','FontSize',14,'Interpreter','latex')
xlabel('time step, k','FontSize',14)
title('NEES Estimation Results','FontSize',14)
legend('$\bar{\epsilon}_x$','$r_1$','$r_2$','FontSize',12,'Interpreter','latex')
end