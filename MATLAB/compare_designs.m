% Baseline vs Optimized Nozzle Comparison

clear;
clc;

%% Add functions folder

addpath('functions');

% BASELINE DESIGN


Dt_base = 20;
De_base = 60;
Lc_base = 30;
Ld_base = 70;
t_base = 3;

[F_base, mdot_base, ve_base, Me_base, Pe_base, Te_base, ...
    At_base, Ae_base, mass_base, V_wall_base, ...
    Tt_base, Pt_base, rho_t_base, a_t_base, Vt_base, ...
    ve_ideal_base, rho_e_base, a_e_base] = ...
    nozzle_performance(Dt_base, De_base, Lc_base, Ld_base, t_base);

TM_base = F_base / mass_base;

% OPTIMIZED DESIGN


Dt_opt = 22;
De_opt = 50;
Lc_opt = 30;
Ld_opt = 50;
t_opt = 3;

[F_opt, mdot_opt, ve_opt, Me_opt, Pe_opt, Te_opt, ...
    At_opt, Ae_opt, mass_opt, V_wall_opt, ...
    Tt_opt, Pt_opt, rho_t_opt, a_t_opt, Vt_opt, ...
    ve_ideal_opt, rho_e_opt, a_e_opt] = ...
    nozzle_performance(Dt_opt, De_opt, Lc_opt, Ld_opt, t_opt);

TM_opt = F_opt / mass_opt;

% CALCULATE PERCENT CHANGES


thrust_change = (F_opt / F_base - 1) * 100;
mass_change = (mass_opt / mass_base - 1) * 100;
TM_change = (TM_opt / TM_base - 1) * 100;
mdot_change = (mdot_opt / mdot_base - 1) * 100;
ve_change = (ve_opt / ve_base - 1) * 100;

% DISPLAY RESULTS


fprintf('\n========================================\n');
fprintf('BASELINE VS OPTIMIZED NOZZLE\n');
fprintf('========================================\n');

fprintf('\n--- Geometry ---\n');

fprintf('                    Baseline      Optimized\n');
fprintf('Throat diameter:    %8.2f mm    %8.2f mm\n', ...
    Dt_base, Dt_opt);

fprintf('Exit diameter:      %8.2f mm    %8.2f mm\n', ...
    De_base, De_opt);

fprintf('Converging length:  %8.2f mm    %8.2f mm\n', ...
    Lc_base, Lc_opt);

fprintf('Diverging length:   %8.2f mm    %8.2f mm\n', ...
    Ld_base, Ld_opt);

fprintf('Wall thickness:     %8.2f mm    %8.2f mm\n', ...
    t_base, t_opt);

fprintf('\n--- Performance ---\n');

fprintf('                    Baseline      Optimized\n');

fprintf('Thrust:             %8.2f N     %8.2f N\n', ...
    F_base, F_opt);

fprintf('Mass flow rate:     %8.4f kg/s  %8.4f kg/s\n', ...
    mdot_base, mdot_opt);

fprintf('Exit velocity:      %8.2f m/s   %8.2f m/s\n', ...
    ve_base, ve_opt);

fprintf('Exit Mach:           %8.3f       %8.3f\n', ...
    Me_base, Me_opt);

fprintf('Exit pressure:      %8.2f Pa    %8.2f Pa\n', ...
    Pe_base, Pe_opt);

fprintf('Nozzle mass:        %8.4f kg    %8.4f kg\n', ...
    mass_base, mass_opt);

fprintf('Thrust-to-mass:     %8.2f N/kg  %8.2f N/kg\n', ...
    TM_base, TM_opt);

% PERCENT CHANGES


fprintf('\n--- Change from Baseline ---\n');

fprintf('Thrust:             %+8.2f %%\n', thrust_change);
fprintf('Mass flow rate:     %+8.2f %%\n', mdot_change);
fprintf('Exit velocity:      %+8.2f %%\n', ve_change);
fprintf('Nozzle mass:        %+8.2f %%\n', mass_change);
fprintf('Thrust-to-mass:     %+8.2f %%\n', TM_change);

fprintf('\n========================================\n');
