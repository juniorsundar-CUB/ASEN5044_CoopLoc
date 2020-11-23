function [A_t,B_t,C_t] = Linearize(x,u)
%Linearize
%   input: x - nominal state vector; u - nominal control input;
%   output: A_t - A tilde Matrix; B_t - B tilde Matrix; C_t - C tilde
%           Matrix
%   Obtain the CT linearized state perturbation matrices

% u = [v_g, phi_g, v_a, w_a]';
% x = [xi_g eta_g theta_g xi_a eta_a theta_a]';

L = 0.5;

A_t = [0 0 -u(1)*sin(x(3)) 0 0 0;
       0 0 u(1)*cos(x(3))  0 0 0;
       0 0 0               0 0 0;
       0 0 0               0 0 -u(3)*sin(x(6));
       0 0 0               0 0 u(3)*cos(x(6));
       0 0 0               0 0 0];
   

B_t = [cos(x(3))   0                    0         0;
       sin(x(3))   0                    0         0;
       tan(u(2))/L (u(1)/L)*sec(u(2))^2 0         0;
       0           0                    cos(x(6)) 0;
       0           0                    sin(x(6)) 0;
       0           0                    0         1];

% x = [xi_g eta_g theta_g xi_a eta_a theta_a]';

C11 = (x(5)-x(2))/((x(5)-x(2))^2 + (x(4)-x(1))^2);
C12 = -(x(4)-x(1))/((x(5)-x(2))^2 + (x(4)-x(1))^2);
C13 = -1;
C14 = -(x(5)-x(2))/((x(5)-x(2))^2 + (x(4)-x(1))^2);
C15 = (x(4)-x(1))/((x(5)-x(2))^2 + (x(4)-x(1))^2);
C21 = (x(1)-x(4))*((x(1)-x(4))^2 + (x(2)-x(5))^2)^-0.5;
C22 = (x(2)-x(5))*((x(1)-x(4))^2 + (x(2)-x(5))^2)^-0.5;
C24 = -(x(1)-x(4))*((x(1)-x(4))^2 + (x(2)-x(5))^2)^-0.5;
C25 = -(x(2)-x(5))*((x(1)-x(4))^2 + (x(2)-x(5))^2)^-0.5;
C31 = -(x(2)-x(5))/((x(2)-x(5))^2 + (x(1)-x(4))^2);
C32 = (x(1)-x(4))/((x(2)-x(5))^2 + (x(1)-x(4))^2);
C34 = (x(2)-x(5))/((x(2)-x(5))^2 + (x(1)-x(4))^2);
C35 = -(x(1)-x(4))/((x(2)-x(5))^2 + (x(1)-x(4))^2);
C36 = -1;
C44 = 1;
C55 = 1;

C_t = [C11 C12 C13 C14 C15 0;
       C21 C22 0   C24 C25 0;
       C31 C32 0   C34 C35 C36;
       0   0   0   C44 0   0;
       0   0   0   0   C55 0];
end