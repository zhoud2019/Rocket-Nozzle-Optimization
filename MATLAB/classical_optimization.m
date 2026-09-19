%% ============================================================
%  CLASSICAL ROCKET NOZZLE OPTIMIZATION
%  ============================================================

clear;
clc;

%% Design Variables
%
% x = [Dt, De, Ld]
%
% Dt = throat diameter [mm]
% De = exit diameter [mm]
% Ld = diverging length [mm]

x0 = [20, 60, 70];

%% Design Bounds

lb = [18, 50, 50];
ub = [22, 70, 90];

%% Optimization Options

options = optimoptions('fmincon', ...
    'Display', 'iter', ...
    'Algorithm', 'sqp', ...
    'OptimalityTolerance', 1e-10, ...
    'StepTolerance', 1e-10, ...
    'ConstraintTolerance', 1e-10);

%% ============================================================
%  1. MAXIMIZE THRUST
%  ============================================================

fprintf('\n========================================\n');
fprintf('MAXIMUM THRUST OPTIMIZATION\n');
fprintf('========================================\n');

[x_thrust, fval_thrust, exitflag_thrust] = ...
    fmincon( ...
    @objective_thrust, ...
    x0, ...
    [], ...
    [], ...
    [], ...
    [], ...
    lb, ...
    ub, ...
    @nozzle_constraints, ...
    options);

%% Evaluate optimized thrust design

Dt = x_thrust(1);
De = x_thrust(2);
Ld = x_thrust(3);

Lc = 30;
t = 3;

[F, mdot, ve, Me, Pe, Te, At, Ae, ...
    nozzle_mass, V_wall] = ...
    nozzle_performance(Dt, De, Lc, Ld, t);

theta_d = atand((De - Dt) / (2 * Ld));

fprintf('\n--- Optimized Design ---\n');
fprintf('Throat diameter:       %.4f mm\n', Dt);
fprintf('Exit diameter:         %.4f mm\n', De);
fprintf('Diverging length:      %.4f mm\n', Ld);
fprintf('Divergence angle:      %.4f deg\n', theta_d);

fprintf('\n--- Performance ---\n');
fprintf('Thrust:                %.4f N\n', F);
fprintf('Mass flow rate:        %.6f kg/s\n', mdot);
fprintf('Exit velocity:         %.4f m/s\n', ve);
fprintf('Exit Mach number:      %.4f\n', Me);
fprintf('Exit pressure:         %.4f Pa\n', Pe);
fprintf('Nozzle mass:           %.6f kg\n', nozzle_mass);
fprintf('Thrust-to-mass ratio:  %.4f N/kg\n', F / nozzle_mass);

fprintf('\nOptimization exit flag: %d\n', exitflag_thrust);

%% ============================================================
%  2. MAXIMIZE THRUST-TO-MASS RATIO
%  ============================================================

fprintf('\n========================================\n');
fprintf('MAXIMUM THRUST-TO-MASS OPTIMIZATION\n');
fprintf('========================================\n');

[x_TM, fval_TM, exitflag_TM] = ...
    fmincon( ...
    @objective_thrust_mass, ...
    x0, ...
    [], ...
    [], ...
    [], ...
    [], ...
    lb, ...
    ub, ...
    @nozzle_constraints, ...
    options);

%% Evaluate optimized thrust-to-mass design

Dt = x_TM(1);
De = x_TM(2);
Ld = x_TM(3);

[F, mdot, ve, Me, Pe, Te, At, Ae, ...
    nozzle_mass, V_wall] = ...
    nozzle_performance(Dt, De, Lc, Ld, t);

theta_d = atand((De - Dt) / (2 * Ld));

fprintf('\n--- Optimized Design ---\n');
fprintf('Throat diameter:       %.4f mm\n', Dt);
fprintf('Exit diameter:         %.4f mm\n', De);
fprintf('Diverging length:      %.4f mm\n', Ld);
fprintf('Divergence angle:      %.4f deg\n', theta_d);

fprintf('\n--- Performance ---\n');
fprintf('Thrust:                %.4f N\n', F);
fprintf('Mass flow rate:        %.6f kg/s\n', mdot);
fprintf('Exit velocity:         %.4f m/s\n', ve);
fprintf('Exit Mach number:      %.4f\n', Me);
fprintf('Exit pressure:         %.4f Pa\n', Pe);
fprintf('Nozzle mass:           %.6f kg\n', nozzle_mass);
fprintf('Thrust-to-mass ratio:  %.4f N/kg\n', F / nozzle_mass);

fprintf('\nOptimization exit flag: %d\n', exitflag_TM);

%% ============================================================
%  FINAL COMPARISON
%  ============================================================

fprintf('\n========================================\n');
fprintf('OPTIMIZATION SUMMARY\n');
fprintf('========================================\n');

fprintf('\nMaximum Thrust Design:\n');
fprintf('Dt = %.4f mm | De = %.4f mm | Ld = %.4f mm\n', ...
    x_thrust(1), x_thrust(2), x_thrust(3));

fprintf('\nMaximum Thrust-to-Mass Design:\n');
fprintf('Dt = %.4f mm | De = %.4f mm | Ld = %.4f mm\n', ...
    x_TM(1), x_TM(2), x_TM(3));

%% ============================================================
%  SAVE OPTIMIZATION RESULTS
%  ============================================================

if ~exist('../Results/Data', 'dir')
    mkdir('../Results/Data');
end

optimization_results = table( ...
    ["Maximum Thrust"; "Maximum Thrust-to-Mass"], ...
    [x_thrust(1); x_TM(1)], ...
    [x_thrust(2); x_TM(2)], ...
    [x_thrust(3); x_TM(3)], ...
    'VariableNames', { ...
    'Objective', ...
    'Dt_mm', ...
    'De_mm', ...
    'Ld_mm'});

writetable(optimization_results, ...
    '../Results/Data/classical_optimization_results.csv');

fprintf('\nOptimization results saved to:\n');
fprintf('../Results/Data/classical_optimization_results.csv\n');