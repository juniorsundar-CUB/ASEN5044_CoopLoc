function PlotNees(hdl, epsNEESbar, Nsimruns, n, alpha)

figure(hdl);
Nnx = Nsimruns*n;

%%compute intervals:
r1x = chi2inv(alpha/2, Nnx )./ Nsimruns;
r2x = chi2inv(1-alpha/2, Nnx )./ Nsimruns;

figure(hdl)
plot(epsNEESbar,'ro','MarkerSize',6,'LineWidth',2),hold on
plot(r1x*ones(size(epsNEESbar)),'r--','LineWidth',2)
plot(r2x*ones(size(epsNEESbar)),'r--','LineWidth',2)
ylabel('NEES statistic, $\bar{\epsilon}_x$','FontSize',14,'Interpreter','latex')
xlabel('time step, k','FontSize',14)
title('NEES Estimation Results','FontSize',14)
legend('NEES @ time k', 'r_1 bound', 'r_2 bound')
end