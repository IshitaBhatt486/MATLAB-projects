# Lead Compensator Simulation

## Objective
To study the effect of a lead compensator on the transient response and stability margins of a unity-feedback control system.

## System
- Plant: `G(s) = 5/(s² + 2s + 5)`
- Compensator: `C(s) = (0.5s + 1)/(0.1s + 1)`

## Results

| Parameter | Uncompensated | Lead Compensated |
|---|---:|---:|
| Rise time (s) | 0.4259 | 0.2484 |
| Settling time (s) | 3.5359 | 1.4081 |
| Overshoot (%) | 35.07 | 33.45 |
| Peak time (s) | 1.0592 | 0.6755 |
| Step error | 0.5000 | 0.5000 |

## Conclusion
The lead compensator reduced rise time by approximately 42% and settling time by 60%. Overshoot decreased slightly, while steady-state error remained unchanged. The results demonstrate improved transient response without improving steady-state accuracy.