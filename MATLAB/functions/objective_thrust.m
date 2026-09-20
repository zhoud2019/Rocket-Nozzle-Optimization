function J = objective_thrust(x)

% Design variables

Dt = x(1);
De = x(2);
Ld = x(3);

% Fixed geometry

Lc = 30;
t = 3;

% Calculate nozzle performance

[F, ~, ~, ~, ~, ~, ~, ~, ~, ~] = ...
    nozzle_performance(Dt, De, Lc, Ld, t);

%% Objective

% fmincon minimizes the objective,
% so use negative thrust to maximize thrust.

J = -F;

end
