function [y] = NL_MeasModel(x,Mnoise)
%NL_MeasModel
%   input: x - state vector; Mnoise - measurement noice vector
%   output: y - sensor readings;
%   Uses NL state inputs and measurement noise vector to get sensor
%   readings

% y = [gamma_ag rho_ga gamma_ga xi_a eta_a]';
% x = [xi_g eta_g theta_g xi_a eta_a theta_a]';
% x = [1    2     3       4    5     6      ]';

y = [atan2(x(5)-x(2),x(4)-x(1)) - x(3);
     sqrt((x(1)-x(4))^2 + (x(2)-x(5))^2);
     atan2(-x(5)+x(2),-x(4)+x(1)) - x(6);
     x(4);
     x(5)];

y = y + Mnoise;

end

