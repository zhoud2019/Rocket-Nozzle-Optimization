%% Save Baseline vs Optimized Comparison Data

clear;
clc;

%% Add functions folder

addpath('functions');

%% ============================================================
% BASELINE DESIGN
% ============================================================

Dt_base = 20;
De_base = 60;
Lc_base = 30;
Ld_base = 70;
t_base = 3;

[F_base, mdot_base, ve_base, Me_base, Pe_base, Te_base, ...
    At_base, Ae_base, mass_base, ~, ...
    ~, ~, ~, ~, ~, ~, ~, ~] = ...
    nozzle_performance(Dt_base, De_base, Lc_base, Ld_base, t_base);

TM_base = F_base / mass_base;

%% ============================================================
% OPTIMIZED DESIGN
% ============================================================

Dt_opt = 22;
De_opt = 50;
Lc_opt = 30;
Ld_opt = 50;
t_opt = 3;

[F_opt, mdot_opt, ve_opt, Me_opt, Pe_opt, Te_opt, ...
    At_opt, Ae_opt, mass_opt, ~, ...
    ~, ~, ~, ~, ~, ~, ~, ~] = ...
    nozzle_performance(Dt_opt, De_opt, Lc_opt, Ld_opt, t_opt);

TM_opt = F_opt / mass_opt;

%% ============================================================
% CREATE COMPARISON TABLE
% ============================================================

Design = ["Baseline"; "Optimized"];

Dt_mm = [Dt_base; Dt_opt];
De_mm = [De_base; De_opt];
Lc_mm = [Lc_base; Lc_opt];
Ld_mm = [Ld_base; Ld_opt];
WallThickness_mm = [t_base; t_opt];

Thrust_N = [F_base; F_opt];
MassFlow_kg_s = [mdot_base; mdot_opt];
ExitVelocity_m_s = [ve_base; ve_opt];
ExitMach = [Me_base; Me_opt];
ExitPressure_Pa = [Pe_base; Pe_opt];
NozzleMass_kg = [mass_base; mass_opt];
ThrustToMass_N_kg = [TM_base; TM_opt];

comparison = table( ...
    Design, ...
    Dt_mm, ...
    De_mm, ...
    Lc_mm, ...
    Ld_mm, ...
    WallThickness_mm, ...
    Thrust_N, ...
    MassFlow_kg_s, ...
    ExitVelocity_m_s, ...
    ExitMach, ...
    ExitPressure_Pa, ...
    NozzleMass_kg, ...
    ThrustToMass_N_kg);

%% ============================================================
% SAVE DATA
% ============================================================

writetable( ...
    comparison, ...
    '../Results/Data/baseline_vs_optimized.csv');

%% ============================================================
% DISPLAY
% ============================================================

fprintf('\n========================================\n');
fprintf('COMPARISON DATA SAVED\n');
fprintf('========================================\n');

disp(comparison);

fprintf('\nSaved to:\n');
fprintf('../Results/Data/baseline_vs_optimized.csv\n');