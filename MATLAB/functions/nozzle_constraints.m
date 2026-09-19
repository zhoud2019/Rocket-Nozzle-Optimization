function [c, ceq] = nozzle_constraints(x)

%% ============================================================
%  NOZZLE DESIGN CONSTRAINTS
%  ============================================================

Dt = x(1);       % Throat diameter [mm]
De = x(2);       % Exit diameter [mm]
Ld = x(3);       % Diverging length [mm]

%% Diverging half-angle

theta_d = atand((De - Dt) / (2 * Ld));

%% Inequality constraints
%
% fmincon requires:
%       c(x) <= 0
%
% 1. Exit diameter must be greater than throat diameter
% 2. Diverging half-angle must not exceed 20 degrees

c1 = Dt - De;

c2 = theta_d - 20;

c = [c1; c2];

%% No equality constraints

ceq = [];

end