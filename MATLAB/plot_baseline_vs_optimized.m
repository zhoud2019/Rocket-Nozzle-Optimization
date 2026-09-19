%% Baseline vs Optimized Nozzle - Final Comparison Plots

clear;
clc;
close all;

%% ============================================================
% LOAD COMPARISON DATA
% ============================================================

data = readtable('../Results/Data/baseline_vs_optimized.csv');

%% Extract data

design = categorical(data.Design);

thrust = data.Thrust_N;
mass = data.NozzleMass_kg;
thrust_mass = data.ThrustToMass_N_kg;
mass_flow = data.MassFlow_kg_s;
exit_velocity = data.ExitVelocity_m_s;

%% ============================================================
% CREATE FIGURES FOLDER IF NEEDED
% ============================================================

if ~exist('../Results/Figures', 'dir')
    mkdir('../Results/Figures');
end

%% ============================================================
% FIGURE 1 - THRUST
% ============================================================

figure;

bar(design, thrust);

ylabel('Thrust [N]');
title('Baseline vs Optimized Nozzle - Thrust');

grid on;

saveas(gcf, '../Results/Figures/baseline_vs_optimized_thrust.png');

%% ============================================================
% FIGURE 2 - THRUST-TO-MASS RATIO
% ============================================================

figure;

bar(design, thrust_mass);

ylabel('Thrust-to-Mass Ratio [N/kg]');
title('Baseline vs Optimized Nozzle - Thrust-to-Mass Ratio');

grid on;

saveas(gcf, ...
    '../Results/Figures/baseline_vs_optimized_thrust_mass.png');

%% ============================================================
% FIGURE 3 - NOZZLE MASS
% ============================================================

figure;

bar(design, mass);

ylabel('Nozzle Mass [kg]');
title('Baseline vs Optimized Nozzle - Nozzle Mass');

grid on;

saveas(gcf, ...
    '../Results/Figures/baseline_vs_optimized_mass.png');

%% ============================================================
% FIGURE 4 - MASS FLOW RATE
% ============================================================

figure;

bar(design, mass_flow);

ylabel('Mass Flow Rate [kg/s]');
title('Baseline vs Optimized Nozzle - Mass Flow Rate');

grid on;

saveas(gcf, ...
    '../Results/Figures/baseline_vs_optimized_mass_flow.png');

%% ============================================================
% FIGURE 5 - EXIT VELOCITY
% ============================================================

figure;

bar(design, exit_velocity);

ylabel('Exit Velocity [m/s]');
title('Baseline vs Optimized Nozzle - Exit Velocity');

grid on;

saveas(gcf, ...
    '../Results/Figures/baseline_vs_optimized_exit_velocity.png');

%% ============================================================
% DISPLAY
% ============================================================

fprintf('\n========================================\n');
fprintf('COMPARISON FIGURES SAVED\n');
fprintf('========================================\n');

fprintf('\nFigures saved to:\n');
fprintf('../Results/Figures/\n');

fprintf('\nFiles:\n');
fprintf('1. baseline_vs_optimized_thrust.png\n');
fprintf('2. baseline_vs_optimized_thrust_mass.png\n');
fprintf('3. baseline_vs_optimized_mass.png\n');
fprintf('4. baseline_vs_optimized_mass_flow.png\n');
fprintf('5. baseline_vs_optimized_exit_velocity.png\n');

fprintf('\n========================================\n');