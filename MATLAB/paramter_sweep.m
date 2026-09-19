%% ============================================================
%  ROCKET NOZZLE PARAMETER SWEEP
%  ============================================================

clear;
clc;

%% Design Variables

Dt_values = 18:1:22;       % Throat diameter [mm]
De_values = 50:5:70;       % Exit diameter [mm]
Ld_values = 50:10:90;      % Diverging length [mm]

Lc = 30;                   % Converging length [mm]
t = 3;                     % Wall thickness [mm]

%% Number of Designs

num_designs = ...
    length(Dt_values) * ...
    length(De_values) * ...
    length(Ld_values);

%% Results Storage

results = zeros(num_designs, 10);

row = 1;

%% ============================================================
%  PARAMETER SWEEP
%  ============================================================

for Dt = Dt_values

    for De = De_values

        for Ld = Ld_values

            % Check design constraints

            theta_d = atand((De - Dt) / (2 * Ld));

            % Skip invalid designs
            if De <= Dt || theta_d > 20
                continue;
            end

            % Calculate nozzle performance

            [F, mdot, ve, Me, Pe, Te, At, Ae, ...
                nozzle_mass, V_wall] = ...
                nozzle_performance(Dt, De, Lc, Ld, t);

            % Store results

            results(row, :) = [ ...
                Dt, ...
                De, ...
                Ld, ...
                F, ...
                mdot, ...
                ve, ...
                Me, ...
                Pe, ...
                nozzle_mass, ...
                F / nozzle_mass];

            row = row + 1;

        end
    end
end

%% Remove unused rows

results = results(1:row-1, :);

%% ============================================================
%  CONVERT TO TABLE
%  ============================================================

results_table = array2table(results, ...
    'VariableNames', { ...
    'Dt_mm', ...
    'De_mm', ...
    'Ld_mm', ...
    'Thrust_N', ...
    'MassFlow_kg_s', ...
    'ExitVelocity_m_s', ...
    'ExitMach', ...
    'ExitPressure_Pa', ...
    'NozzleMass_kg', ...
    'ThrustToMass_N_kg'});

%% ============================================================
%  FIND BEST DESIGNS
%  ============================================================

[~, max_thrust_index] = ...
    max(results_table.Thrust_N);

[~, max_TM_index] = ...
    max(results_table.ThrustToMass_N_kg);

best_thrust = results_table(max_thrust_index, :);
best_TM = results_table(max_TM_index, :);

%% ============================================================
%  DISPLAY RESULTS
%  ============================================================

fprintf('\n========================================\n');
fprintf('PARAMETER SWEEP RESULTS\n');
fprintf('========================================\n');

fprintf('\nNumber of valid designs: %d\n', height(results_table));

fprintf('\n--- Maximum Thrust ---\n');
fprintf('Throat diameter:       %.2f mm\n', best_thrust.Dt_mm);
fprintf('Exit diameter:         %.2f mm\n', best_thrust.De_mm);
fprintf('Diverging length:      %.2f mm\n', best_thrust.Ld_mm);
fprintf('Thrust:                %.2f N\n', best_thrust.Thrust_N);
fprintf('Mass flow rate:        %.4f kg/s\n', best_thrust.MassFlow_kg_s);
fprintf('Exit velocity:         %.2f m/s\n', best_thrust.ExitVelocity_m_s);
fprintf('Nozzle mass:           %.4f kg\n', best_thrust.NozzleMass_kg);
fprintf('Thrust-to-mass ratio:  %.2f N/kg\n', ...
    best_thrust.ThrustToMass_N_kg);

fprintf('\n--- Maximum Thrust-to-Mass Ratio ---\n');
fprintf('Throat diameter:       %.2f mm\n', best_TM.Dt_mm);
fprintf('Exit diameter:         %.2f mm\n', best_TM.De_mm);
fprintf('Diverging length:      %.2f mm\n', best_TM.Ld_mm);
fprintf('Thrust:                %.2f N\n', best_TM.Thrust_N);
fprintf('Mass flow rate:        %.4f kg/s\n', best_TM.MassFlow_kg_s);
fprintf('Exit velocity:         %.2f m/s\n', best_TM.ExitVelocity_m_s);
fprintf('Nozzle mass:           %.4f kg\n', best_TM.NozzleMass_kg);
fprintf('Thrust-to-mass ratio:  %.2f N/kg\n', ...
    best_TM.ThrustToMass_N_kg);

%% ============================================================
%  SAVE RESULTS
%  ============================================================

if ~exist('../Results/Data', 'dir')
    mkdir('../Results/Data');
end

writetable(results_table, ...
    '../Results/Data/parameter_sweep_results.csv');

fprintf('\nResults saved to:\n');
fprintf('../Results/Data/parameter_sweep_results.csv\n');