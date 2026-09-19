# Equations and Assumptions

## Model Overview

The MATLAB model uses a simplified 1-D, steady-flow, isentropic nozzle model to estimate:

* Mass flow rate
* Exit Mach number
* Exit temperature and pressure
* Exit velocity
* Thrust
* Nozzle mass
* Thrust-to-nozzle-mass ratio

## Operating Conditions

| Parameter             |        Value |
| --------------------- | -----------: |
| Chamber pressure      |        3 MPa |
| Chamber temperature   |       3000 K |
| Specific heat ratio   |          1.2 |
| Specific gas constant | 355 J/(kg*K) |
| Ambient pressure      |    101325 Pa |
| Material density      |  8000 kg/m^3 |
| Efficiency factor     |         0.95 |

## Main Equations

Throat and exit areas:

A = pi*D^2/4

Throat conditions assume choked flow:

Mt = 1

Tt = Tc/(1 + ((gamma - 1)/2)*Mt^2)

Pt = Pc*(Tt/Tc)^(gamma/(gamma - 1))

Mass flow:

mdot = rho_t*At*Vt

Exit Mach number is obtained from the isentropic area-Mach relation.

Exit velocity:

Ve = sqrt(eta)*Ve_ideal

Thrust:

F = mdot*Ve + (Pe - Pa)*Ae

Nozzle mass:

m_nozzle = rho_material*V_wall

Optimization metric:

F/m_nozzle

## Design Constraints

The optimization varies:

| Variable         |    Range |
| ---------------- | -------: |
| Throat diameter  | 18–22 mm |
| Exit diameter    | 50–70 mm |
| Diverging length | 50–90 mm |

Constraints:

De > Dt

theta_d <= 20 degrees

## Assumptions & Limitations

* One-dimensional, steady, isentropic flow
* Constant gamma and R
* Assumed efficiency factor of 0.95
* Simplified nozzle wall mass model
* No experimental validation
* Diverging length affects modeled mass but not flow performance in the current model

The model is intended for **educational design exploration and optimization**, not physical performance prediction.
