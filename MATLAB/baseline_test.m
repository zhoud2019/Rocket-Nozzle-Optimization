clear;
clc;

% Add functions folder
addpath('functions');

% BASELINE NOZZLE GEOMETRY


Dt = 20;    % Throat diameter [mm]
De = 60;    % Exit diameter [mm]
Lc = 30;    % Converging length [mm]
Ld = 70;    % Diverging length [mm]
t  = 3;     % Wall thickness [mm]

% CALCULATE NOZZLE PERFORMANCE


[F, mdot, ve, Me, Pe, Te, At, Ae, nozzle_mass, V_wall, ...
 Tt, Pt, rho_t, a_t, Vt, ve_ideal, rho_e, a_e] = ...
    nozzle_performance(Dt, De, Lc, Ld, t);

% DISPLAY RESULTS


fprintf('==============================\n');
fprintf('BASELINE NOZZLE\n');
fprintf('==============================\n');

fprintf('Throat diameter:       %.2f mm\n', Dt);
fprintf('Exit diameter:         %.2f mm\n', De);
fprintf('Converging length:     %.2f mm\n', Lc);
fprintf('Diverging length:      %.2f mm\n', Ld);
fprintf('Wall thickness:        %.2f mm\n', t);

fprintf('\n--- Flow Areas ---\n');
fprintf('Throat area:            %.6f m^2\n', At);
fprintf('Exit area:              %.6f m^2\n', Ae);
fprintf('Area ratio:             %.3f\n', Ae/At);

fprintf('\n--- Throat Conditions ---\n');
fprintf('Throat Mach number:     %.3f\n', 1.0);
fprintf('Throat temperature:     %.2f K\n', Tt);
fprintf('Throat pressure:        %.2f Pa\n', Pt);
fprintf('Throat density:         %.4f kg/m^3\n', rho_t);
fprintf('Throat speed of sound:  %.2f m/s\n', a_t);
fprintf('Throat velocity:        %.2f m/s\n', Vt);

% Mass flow consistency check

mdot_check = rho_t * At * Vt;

fprintf('\n--- Mass Flow Check ---\n');
fprintf('Mass flow rate:         %.4f kg/s\n', mdot);
fprintf('Throat-based mdot:      %.4f kg/s\n', mdot_check);
fprintf('Difference:             %.6e kg/s\n', mdot - mdot_check);

fprintf('\n--- Performance ---\n');
fprintf('Mass flow rate:         %.4f kg/s\n', mdot);
fprintf('Thrust:                 %.2f N\n', F);
fprintf('Nozzle mass:            %.4f kg\n', nozzle_mass);
fprintf('Thrust-to-mass ratio:   %.2f N/kg\n', F/nozzle_mass);

fprintf('\n--- Geometry ---\n');
fprintf('Wall volume:            %.6e m^3\n', V_wall);

fprintf('Ideal exit velocity:    %.2f m/s\n', ve_ideal);
fprintf('Model exit velocity:    %.2f m/s\n', ve);

fprintf('\n--- Exit Conditions ---\n');
fprintf('Exit Mach number:       %.3f\n', Me);
fprintf('Exit temperature:       %.2f K\n', Te);
fprintf('Exit pressure:          %.2f Pa\n', Pe);
fprintf('Exit density:           %.4f kg/m^3\n', rho_e);
fprintf('Exit speed of sound:    %.2f m/s\n', a_e);

fprintf('\nExit velocity:          %.2f m/s\n', ve);
fprintf('Ideal exit velocity:    %.2f m/s\n', ve_ideal);
fprintf('Model exit velocity:    %.2f m/s\n', ve);
