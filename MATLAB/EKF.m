% Extended Kalman Filter

x_nom = [10 0 pi/2 -60 0 -pi/2]';
u_nom = [2 -pi/18 12 pi/25]';
Dt = 0.1;

[A_t,B_t,C_t] = Linearize(x_nom, u_nom);
[F, G, H] = Discretize(A_t,B_t,C_t, Dt);
disp('F: '), disp(F);
disp('G: '), disp(G);
disp('H: '), disp(H);