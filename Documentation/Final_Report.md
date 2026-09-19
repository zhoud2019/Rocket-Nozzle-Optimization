**Final Report — Rocket Nozzle Design Optimization**



**Objective**



Investigate how nozzle geometry affects modeled thrust and thrust-to-nozzle-mass ratio using SolidWorks and MATLAB.



**Baseline**



| Parameter         | Value |

| ----------------- | ----- |

| Throat diameter   | 20 mm |

| Exit diameter     | 60 mm |

| Converging length | 30 mm |

| Diverging length  | 70 mm |

| Wall thickness    |  3 mm |



**Method**



1\. Created a baseline nozzle in SolidWorks.

2\. Developed a simplified MATLAB performance model.

3\. Evaluated 125 geometry combinations.

4\. Applied geometric constraints, leaving 98 valid designs.

5\. Used 'fmincon' to optimize thrust and thrust-to-mass.

6\. Created the optimized geometry in SolidWorks.

7\. Compared the baseline and optimized designs with the help of graphs.



**Final Design**



| Parameter        | Baseline | Optimized |

| ---------------- | -------: | --------: |

| Throat diameter  |    20 mm |     22 mm |

| Exit diameter    |    60 mm |     50 mm |

| Diverging length |    70 mm |     50 mm |

| Wall thickness   |     3 mm |      3 mm |



\*Every other dimension stayed the same



**Results**



| Metric         |     Baseline |    Optimized |  Change |

| -------------- | -----------: | -----------: | ------: |

| Modeled thrust |    1304.77 N |    1639.06 N | +25.62% |

| Nozzle mass    |    0.2564 kg |    0.1877 kg | -26.76% |

| Thrust-to-mass | 5089.72 N/kg | 8730.42 N/kg | +71.53% |

| Mass flow      |  0.5923 kg/s |  0.7167 kg/s | +21.00% |

| Exit velocity  |  2480.19 m/s |  2313.94 m/s |  -6.70% |



**Conclusion**



The optimized geometry increased modeled thrust and substantially improved modeled thrust-to-nozzle-mass ratio while reducing the estimated nozzle mass.



The results are based on a simplified analytical model and have not been experimentally validated.



