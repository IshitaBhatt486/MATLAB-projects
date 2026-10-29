# Interpretation of the Graphs

## 1. Step Response

- **Uncompensated:** Rise time is 0.4259 s, settling time is 3.5359 s, and overshoot is 35.07%. The response is relatively fast but oscillatory.
- **Lead compensated:** Rise and settling times decrease to 0.2484 s and 1.4081 s, respectively. Overshoot decreases slightly to 33.45%, indicating a faster transient response.
- **Lag compensated:** Overshoot becomes zero, but settling time increases to 24.57 s. The response is slower but reaches a final value closer to the reference.
- **Lead–lag compensated:** Overshoot remains zero, but settling time increases to 24.98 s. The lag section dominates the transient response.

All systems have a steady-state error of 0.5 without compensation or with lead compensation, compared with 0.1667 for lag and lead–lag compensation.

## 2. Bode Plot

- **Plant:** Shows the original open-loop magnitude and phase characteristics.
- **Lead compensation:** Introduces positive phase over a frequency range and can improve phase margin and bandwidth.
- **Lag compensation:** Increases low-frequency gain relative to high-frequency gain, improving steady-state accuracy but potentially reducing bandwidth.
- **Lead–lag compensation:** Combines the phase-advancing and low-frequency gain effects. Its overall performance depends on the selected parameters.

## 3. Pole–Zero Map

The lead compensator has a zero at `s = -2` and a pole at `s = -10`. The lag compensator has a zero at `s = -0.2` and a pole at `s = -0.04`.

The pole–zero map illustrates the compensator dynamics. Closed-loop stability must be assessed using the poles of the complete closed-loop system, not the compensator alone.

## 4. Stability Margins

The gain margin and phase margin plots indicate how much additional gain or phase change the open-loop system can tolerate before reaching instability. The uncompensated and compensated margins can be compared to assess the effect of each design.

## Overall Interpretation

Lead compensation primarily improves transient speed, while lag compensation improves steady-state accuracy at the expense of speed. The selected lead–lag design achieves the lag compensator's steady-state performance but does not retain the lead-only system's fast response. Appropriate parameter tuning is therefore essential to balance transient response, steady-state error, and stability margins.