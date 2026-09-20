% Optimized Nozzle Design Test

clear;
clc;

% Add functions folder

addpath('functions');

% Optimized SolidWorks dimensions

Dt = 22;
De = 50;
Lc = 30;
Ld = 50;
t = 3;

% Run nozzle model

[F, mdot, ve, Me, Pe, Te, At, Ae, nozzle_mass, V_wall, ...
    Tt, Pt, rho_t, a_t, Vt, ve_ideal, rho_e, a_e] = ...
    nozzle_performance(Dt, De, Lc, Ld, t);

% Calculate thrust-to-mass ratio

TM = F / nozzle_mass;

% Display results

fprintf('\n========================================\n');
fprintf('OPTIMIZED NOZZLE DESIGN\n');
fprintf('========================================\n');

fprintf('\n--- Geometry ---\n');
fprintf('Throat diameter:       %.2f mm\n', Dt);
fprintf('Exit diameter:         %.2f mm\n', De);
fprintf('Converging length:     %.2f mm\n', Lc);
fprintf('Diverging length:      %.2f mm\n', Ld);
fprintf('Wall thickness:        %.2f mm\n', t);

fprintf('\n--- Flow ---\n');
fprintf('Throat area:            %.6f m^2\n', At);
fprintf('Exit area:              %.6f m^2\n', Ae);
fprintf('Area ratio:             %.3f\n', Ae / At);

fprintf('\n--- Throat Conditions ---\n');
fprintf('Throat Mach number:     %.3f\n', 1);
fprintf('Throat temperature:     %.2f K\n', Tt);
fprintf('Throat pressure:        %.2f Pa\n', Pt);
fprintf('Throat density:         %.4f kg/m^3\n', rho_t);
fprintf('Throat velocity:        %.2f m/s\n', Vt);

fprintf('\n--- Exit Conditions ---\n');
fprintf('Exit Mach number:       %.3f\n', Me);
fprintf('Exit temperature:       %.2f K\n', Te);
fprintf('Exit pressure:          %.2f Pa\n', Pe);
fprintf('Exit density:           %.4f kg/m^3\n', rho_e);
fprintf('Exit speed of sound:    %.2f m/s\n', a_e);

fprintf('\n--- Performance ---\n');
fprintf('Mass flow rate:         %.4f kg/s\n', mdot);
fprintf('Ideal exit velocity:    %.2f m/s\n', ve_ideal);
fprintf('Model exit velocity:    %.2f m/s\n', ve);
fprintf('Thrust:                 %.2f N\n', F);
fprintf('Nozzle mass:            %.4f kg\n', nozzle_mass);
fprintf('Thrust-to-mass ratio:   %.2f N/kg\n', TM);

fprintf('\n========================================\n');
