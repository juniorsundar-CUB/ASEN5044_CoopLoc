function [x_nom,y_nom] = GenerateNom(x0, u0, steps, Dt)

t = 0:Dt:steps*Dt;
[~,x_nom] = ode45(@(t,x) NL_DynModel(t,x,u0,zeros(6,1)),t,x0);
x_nom = x_nom';
y_nom = zeros(5,length(t));

for i=1:length(t)
    y_nom(:,i) = NL_MeasModel(x_nom(:,i),zeros(5,1));
end

end

