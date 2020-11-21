clc
clear

% u = [v_g, phi_g, v_a, w_a]';
% x = [xi_g eta_g theta_g xi_a eta_a theta_a]';
% ~w = [w_x,g w_y,g w_w,g w_x,a w_y,a w_w,a]';

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
x_pert = [0 1 0 0 0 0.1]';
Dt = 0.1;
t = 0:0.1:100;

[~,x] = ode45(@(t,x) NL_DynModel(t,x,u_nom,zeros(6,1)),t,x_nom);
x = x';
y = zeros(5,length(t));
for i=1:length(t)
    y(:,i) = NL_MeasModel(x(:,i),zeros(5,1));
end

figure(1)
subplot(6,1,1)
plot(t,x(1,:))
subplot(6,1,2)
plot(t,x(2,:))
subplot(6,1,3)
plot(t,wrapToPi(x(3,:)))
subplot(6,1,4)
plot(t,x(4,:))
subplot(6,1,5)
plot(t,x(5,:))
subplot(6,1,6)
plot(t,wrapToPi(x(6,:)))

figure(2)
subplot(5,1,1)
plot(t,wrapToPi(y(1,:)))
subplot(5,1,2)
plot(t,y(2,:))
subplot(5,1,3)
plot(t,wrapToPi(y(3,:)))
subplot(5,1,4)
plot(t,y(4,:))
subplot(5,1,5)
plot(t,y(5,:))