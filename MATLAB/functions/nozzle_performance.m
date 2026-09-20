function [F, mdot, ve, Me, Pe, Te, At, Ae, nozzle_mass, V_wall, ...
          Tt, Pt, rho_t, a_t, Vt, ve_ideal, rho_e, a_e] = ...
    nozzle_performance(Dt, De, Lc, Ld, t)


%  OPERATING CONDITIONS


Pc = 3e6;              % Chamber pressure [Pa]
Tc = 3000;             % Chamber temperature [K]
gamma = 1.2;           % Specific heat ratio
R = 355;               % Specific gas constant [J/(kg*K)]
Pa = 101325;           % Ambient pressure [Pa]

% MATERIAL PROPERTIES


rho_material = 8000;  % Material density [kg/m^3]

% NOZZLE EFFICIENCY


% Simplified constant nozzle efficiency.
%
% This accounts approximately for losses that are not captured
% by the ideal 1-D isentropic flow model.
%
% This is an engineering assumption for this educational model,
% not a measured value for a specific physical nozzle.

eta = 0.95;

% CONVERT GEOMETRY FROM mm TO m


Dt_m = Dt / 1000;
De_m = De / 1000;
Lc_m = Lc / 1000;
Ld_m = Ld / 1000;
t_m  = t / 1000;

% FIXED CHAMBER DIAMETER


Dc = 40;                % Chamber diameter [mm]
Dc_m = Dc / 1000;

% FLOW AREAS


At = pi * Dt_m^2 / 4;
Ae = pi * De_m^2 / 4;

% AREA RATIO


AR = Ae / At;

% GEOMETRY CALCULATIONS


Rc = Dc_m / 2;
Rt = Dt_m / 2;
Re = De_m / 2;

% Converging half-angle

theta_c = atand((Rc - Rt) / Lc_m);

% Diverging half-angle

theta_d = atand((Re - Rt) / Ld_m);

% THROAT CONDITIONS

Mt = 1;

% Throat temperature
Tt = Tc / (1 + ((gamma - 1)/2) * Mt^2);

% Throat pressure
Pt = Pc * ...
    (Tt / Tc)^(gamma / (gamma - 1));

% Throat density using the ideal gas law
rho_t = Pt / (R * Tt);

% Speed of sound at throat
a_t = sqrt(gamma * R * Tt);

% Throat velocity
Vt = Mt * a_t;

% EXIT MACH NUMBER


areaMach = @(M) ...
    (1/M) * ...
    ((2/(gamma+1)) * ...
    (1 + ((gamma-1)/2)*M^2))^...
    ((gamma+1)/(2*(gamma-1))) - AR;

% Supersonic solution
Me = fzero(areaMach, 3);

% EXIT TEMPERATURE


Te = Tc / ...
    (1 + ((gamma - 1)/2) * Me^2);

% EXIT PRESSURE


Pe = Pc * ...
    (Te / Tc)^(gamma/(gamma - 1));

% Exit Density and Speed of Sound

rho_e = Pe / (R * Te);

a_e = sqrt(gamma * R * Te);


% EXIT VELOCITY


ve_ideal = sqrt( ...
    (2 * gamma / (gamma - 1)) * R * Tc * ...
    (1 - (Pe / Pc)^((gamma - 1) / gamma)));

% Apply simplified nozzle efficiency
ve = sqrt(eta) * ve_ideal;

% MASS FLOW RATE


% Calculate mass flow from throat conditions:
%
% mdot = rho_t * At * Vt
%
% Since the throat is choked, Mt = 1 and Vt is the
% local speed of sound.

mdot = rho_t * At * Vt;

% THRUST


F_momentum = mdot * ve;

F_pressure = (Pe - Pa) * Ae;

F = F_momentum + F_pressure;

% NOZZLE WALL MASS


% Inner radii after accounting for wall thickness

Rc_inner = Rc - t_m;
Rt_inner = Rt - t_m;
Re_inner = Re - t_m;

% Outer converging volume

V_conv_outer = ...
    (pi * Lc_m / 3) * ...
    (Rc^2 + Rc*Rt + Rt^2);

% Inner converging volume

V_conv_inner = ...
    (pi * Lc_m / 3) * ...
    (Rc_inner^2 + ...
     Rc_inner*Rt_inner + ...
     Rt_inner^2);

% Outer diverging volume

V_div_outer = ...
    (pi * Ld_m / 3) * ...
    (Re^2 + Re*Rt + Rt^2);

% Inner diverging volume

V_div_inner = ...
    (pi * Ld_m / 3) * ...
    (Re_inner^2 + ...
     Re_inner*Rt_inner + ...
     Rt_inner^2);

% Wall volumes

V_conv = V_conv_outer - V_conv_inner;

V_div = V_div_outer - V_div_inner;

V_wall = V_conv + V_div;

% Nozzle mass

nozzle_mass = rho_material * V_wall;

end
