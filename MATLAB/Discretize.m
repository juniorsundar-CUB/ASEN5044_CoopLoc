function [F, G, H] = Discretize(A_t,B_t,C_t, Dt)
%Linearize
%   Inputs:
%   A_t - linearized CT system matrix
%   B_t - lizearized CT input matrix
%   C_t - linearized CT measurement matrix
%   Output
%   F - state transition matrix
%   G -control effect matrix
%   H - sensing matrix
%
%   Discretizze the CT state perturbation matrices

    H = C_t;
    F = eye(size(A_t)) + Dt * A_t;
    G = Dt * B_t;
end