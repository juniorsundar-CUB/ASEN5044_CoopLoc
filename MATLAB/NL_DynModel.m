function xdot = NL_DynModel(t,x,u,Pnoise)
%NL_DynModel
%   input: t - time model; x - state vector; u - control input vector;
%          Pnoise - process noice vector
%   output: ___
%   Function input for ode45 for NL dynamics model

% u = [v_g, phi_g, v_a, w_a]';
% x = [xi_g eta_g theta_g xi_a eta_a theta_a]';
% ~w = [w_x,g w_y,g w_w,g w_x,a w_y,a w_w,a]';
L = 0.5;

xdot = [u(1)*cos(x(3)) + Pnoise(1);
        u(1)*sin(x(3)) + Pnoise(2);
        (u(1)/L)*(tan(u(2))) + Pnoise(3);
        u(3)*cos(x(6)) + Pnoise(4);
        u(3)*sin(x(6)) + Pnoise(5);
        u(4) + Pnoise(6)];
end

