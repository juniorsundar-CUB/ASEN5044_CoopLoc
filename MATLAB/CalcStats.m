function [NEES, NIS] = CalcStats(EX, EY, P, S)

steps = size(EX, 2);
runs = size(EX, 3);

NEES_all = zeros(runs,steps);
NIS_all = zeros(runs,steps);
NEES = zeros(1,steps);
NIS = zeros(1,steps);

for run=1:runs
    for step=1:steps
        NEES(step) = EX(:,step, run)' / P(:,:,step, run) * EX(:,step, run);
        NIS(step) = EY(:,step, run)' / S(:,:,step, run) * EY(:,step, run);
    end
    
    NEES_all(run,:) = NEES;
    NIS_all(run,:) = NIS;
end

% calculate mean at each time step
for i=1:steps
    NEES(i) = mean(NEES_all(:,i));
    NIS(i) = mean(NIS_all(:,i));
end
end

