# Lag Compensator Simulation

## Objective
To investigate how a lag compensator affects steady-state accuracy and transient response in a unity-feedback control system.

## System
- Plant: `G(s) = 5/(s² + 2s + 5)`
- Compensator: `C(s) = 5(5s + 1)/(25s + 1)`

## Results

| Parameter | Uncompensated | Lag Compensated |
|---|---:|---:|
| Rise time (s) | 0.4259 | 11.1684 |
| Settling time (s) | 3.5359 | 24.5706 |
| Overshoot (%) | 35.07 | 0 |
| Step error | 0.5000 | 0.1667 |

## Conclusion
The lag compensator reduced steady-state step error from 0.5 to 0.1667, a reduction of approximately 66.7%. However, rise time and settling time increased considerably. Overshoot was eliminated, demonstrating the trade-off between steady-state accuracy and transient speed.