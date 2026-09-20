% 3D Design Space Visualization - Final Version

clear;
clc;
close all;

% Add functions folder to MATLAB path

addpath('functions');

% Load parameter sweep data

data = readtable('../Results/Data/parameter_sweep_results.csv');

Dt = data.Dt_mm;
De = data.De_mm;
Ld = data.Ld_mm;

thrust = data.Thrust_N;
thrust_mass = data.ThrustToMass_N_kg;

%  BASELINE DESIGN

Dt_baseline = 20;
De_baseline = 60;
Ld_baseline = 70;

[F_base, ~, ~, ~, ~, ~, ~, ~, mass_base, ~] = ...
    nozzle_performance(Dt_baseline, De_baseline, 30, Ld_baseline, 3);

TM_base = F_base / mass_base;

%  MAXIMUM THRUST DESIGN

Dt_thrust = 22;
De_thrust = 50;
Ld_thrust = 70;

[F_thrust, ~, ~, ~, ~, ~, ~, ~, mass_thrust, ~] = ...
    nozzle_performance(Dt_thrust, De_thrust, 30, Ld_thrust, 3);

TM_thrust = F_thrust / mass_thrust;

%  MAXIMUM THRUST-TO-MASS DESIGN

Dt_TM = 22;
De_TM = 50;
Ld_TM = 50;

[F_TM, ~, ~, ~, ~, ~, ~, ~, mass_TM, ~] = ...
    nozzle_performance(Dt_TM, De_TM, 30, Ld_TM, 3);

TM_TM = F_TM / mass_TM;

%  FIGURE 1 - THRUST DESIGN SPACE

figure;

scatter3(Dt, De, thrust, 60, Ld, 'filled');

xlabel('Throat Diameter D_t [mm]');
ylabel('Exit Diameter D_e [mm]');
zlabel('Thrust [N]');

title('Nozzle Design Space - Thrust');

cb = colorbar;
cb.Label.String = 'Diverging Length L_d [mm]';

grid on;
view(135, 25);

hold on;

% Baseline

scatter3(Dt_baseline, De_baseline, F_base, ...
    150, 'k', 'filled');

% Maximum thrust

scatter3(Dt_thrust, De_thrust, F_thrust, ...
    180, 'r', 'filled');

legend( ...
    'Parameter Sweep', ...
    'Baseline', ...
    'Maximum Thrust', ...
    'Location', 'best');

annotation('textbox', ...
    [0.02 0.78 0.40 0.15], ...
    'String', { ...
    'THRUST OPTIMIZATION', ...
    '', ...
    sprintf('Baseline:    %.2f N', F_base), ...
    sprintf('Maximum:     %.2f N', F_thrust), ...
    sprintf('Increase:    %.1f%%', ...
        (F_thrust/F_base - 1)*100)}, ...
    'FitBoxToText', 'on', ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'black', ...
    'FontSize', 9);

hold off;

saveas(gcf, '../Results/Figures/design_space_thrust.png');

%  FIGURE 2 - THRUST-TO-MASS DESIGN SPACE

figure;

scatter3(Dt, De, thrust_mass, 60, Ld, 'filled');

xlabel('Throat Diameter D_t [mm]');
ylabel('Exit Diameter D_e [mm]');
zlabel('Thrust-to-Mass Ratio [N/kg]');

title('Nozzle Design Space - Thrust-to-Mass Ratio');

cb = colorbar;
cb.Label.String = 'Diverging Length L_d [mm]';

grid on;
view(135, 25);

hold on;

% Baseline

scatter3(Dt_baseline, De_baseline, TM_base, ...
    150, 'k', 'filled');

% Maximum thrust-to-mass

scatter3(Dt_TM, De_TM, TM_TM, ...
    180, 'g', 'filled');

legend( ...
    'Parameter Sweep', ...
    'Baseline', ...
    'Maximum Thrust-to-Mass', ...
    'Location', 'best');

annotation('textbox', ...
    [0.02 0.78 0.40 0.15], ...
    'String', { ...
    'THRUST-TO-MASS OPTIMIZATION', ...
    '', ...
    sprintf('Baseline:    %.2f N/kg', TM_base), ...
    sprintf('Maximum:     %.2f N/kg', TM_TM), ...
    sprintf('Increase:    %.1f%%', ...
        (TM_TM/TM_base - 1)*100)}, ...
    'FitBoxToText', 'on', ...
    'BackgroundColor', 'white', ...
    'EdgeColor', 'black', ...
    'FontSize', 9);

hold off;

saveas(gcf, '../Results/Figures/design_space_thrust_mass.png');

%  PRINT SUMMARY

fprintf('\n========================================\n');
fprintf('DESIGN SPACE VISUALIZATION\n');
fprintf('========================================\n');

fprintf('\n--- Baseline ---\n');
fprintf('Dt:                 %.2f mm\n', Dt_baseline);
fprintf('De:                 %.2f mm\n', De_baseline);
fprintf('Ld:                 %.2f mm\n', Ld_baseline);
fprintf('Thrust:             %.2f N\n', F_base);
fprintf('Thrust-to-Mass:     %.2f N/kg\n', TM_base);

fprintf('\n--- Maximum Thrust ---\n');
fprintf('Dt:                 %.2f mm\n', Dt_thrust);
fprintf('De:                 %.2f mm\n', De_thrust);
fprintf('Ld:                 %.2f mm\n', Ld_thrust);
fprintf('Thrust:             %.2f N\n', F_thrust);
fprintf('Thrust-to-Mass:     %.2f N/kg\n', TM_thrust);

fprintf('\n--- Maximum Thrust-to-Mass ---\n');
fprintf('Dt:                 %.2f mm\n', Dt_TM);
fprintf('De:                 %.2f mm\n', De_TM);
fprintf('Ld:                 %.2f mm\n', Ld_TM);
fprintf('Thrust:             %.2f N\n', F_TM);
fprintf('Thrust-to-Mass:     %.2f N/kg\n', TM_TM);

fprintf('\n========================================\n');
