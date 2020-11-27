clc
clear

seed = 100;
rng(seed);
Dt = 0.1;
steps = 1000;
n = 6; p = 5; t = 0:Dt:steps*Dt;

N = 10;        % No. of Monte Carlo runs
NEES_all = zeros(N,steps+1);
NIS_all = zeros(N,steps+1);

% Tuning parameters
% Q = 0.01*eye(6);
Q = 0.001*ones(6,6);
R = 30*eye(5);
% load('cooplocalization_finalproj_KFdata.mat')
% Q = Qtrue;
% R = Rtrue;
for i=1:N
    disp(i)
    NEES = zeros(1,steps+1);
    NIS = zeros(1,steps+1);
    
    [x_truth,y_truth,x_est,y_est,dx,P,S,e_x,e_y] = LKF_MonteCarlo(Q,R,steps);
    
    for k=1:steps+1
        NEES(:,k) = e_x(:,k)'*inv(P(:,:,k))*e_x(:,k);
        NIS(:,k) = e_y(:,k)'*inv(S(:,:,k))*e_y(:,k);
    end
    
    NEES_all(i,:) = NEES;
    NIS_all(i,:) = NIS;
end

NEES_bar = zeros(1,steps+1);
NIS_bar = zeros(1,steps+1);

for i=1:steps+1
    NEES_bar(1,i) = mean(NEES_all(:,i));
    NIS_bar(1,i) = mean(NIS_all(:,i));
end

alpha = 0.01;
rx1 = (chi2inv(alpha/2,N*n))./N;
rx2 = (chi2inv(1-alpha/2,N*n))./N;
ry1 = (chi2inv(alpha/2,N*p))./N;
ry2 = (chi2inv(1-alpha/2,N*p))./N;

figure(1)
subplot(2,1,1)
scatter(t,NEES_bar)
hold on
plot(t,ones(1,length(t))*rx1,'r--','LineWidth',1.5)
plot(t,ones(1,length(t))*rx2,'r--','LineWidth',1.5)
hold off
subplot(2,1,2)
scatter(t,NIS_bar)
hold on
plot(t,ones(1,length(t))*ry1,'r--','LineWidth',1.5)
plot(t,ones(1,length(t))*ry2,'r--','LineWidth',1.5)
hold off