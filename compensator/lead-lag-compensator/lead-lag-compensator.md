# Lead–Lag Compensator Simulation

## Objective
To compare uncompensated, lead, lag, and combined lead–lag control systems using step-response metrics.

## System
- Plant: `G(s) = 5/(s² + 2s + 5)`
- Lead section: `(0.5s + 1)/(0.1s + 1)`
- Lag section: `5(5s + 1)/(25s + 1)`
- Combined compensator: `C(s) = C_lead(s) × C_lag(s)`

## Results

| System | Rise time (s) | Settling time (s) | Overshoot (%) | Step error |
|---|---:|---:|---:|---:|
| Uncompensated | 0.4259 | 3.5359 | 35.07 | 0.5000 |
| Lead | 0.2484 | 1.4081 | 33.45 | 0.5000 |
| Lag | 11.1684 | 24.5706 | 0 | 0.1667 |
| Lead–Lag | 11.4610 | 24.9840 | 0 | 0.1667 |

## Conclusion
The combined lead–lag system improved steady-state accuracy and eliminated overshoot, but its transient response remained slow. With the selected parameters, the lag section dominated the response, so combining it with the lead section did not recover the speed of the lead-only system. Further tuning is required to achieve a better balance between speed and accuracy.