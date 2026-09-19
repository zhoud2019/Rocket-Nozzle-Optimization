function J = objective_thrust_mass(x)

%% Design variables

Dt = x(1);
De = x(2);
Ld = x(3);

%% Fixed geometry

Lc = 30;
t = 3;

%% Calculate nozzle performance

[F, ~, ~, ~, ~, ~, ~, ~, nozzle_mass, ~] = ...
    nozzle_performance(Dt, De, Lc, Ld, t);

%% Objective

J = -F / nozzle_mass;

end