# Second-Order System Analysis

## 1. System Model

The transfer function used was:

\[
G(s)=\frac{\omega_n^2}{s^2+2\zeta\omega_n s+\omega_n^2}
\]

With natural frequency \(\omega_n=5\text{ rad/s}\) and damping ratio \(\zeta=0.5\):

\[
G(s)=\frac{25}{s^2+5s+25}
\]

## 2. Results and Interpretation

| Parameter | Result | Interpretation |
|---|---:|---|
| Natural frequency | 5 rad/s | Characteristic frequency of the system |
| Damping ratio | 0.50 | Underdamped system |
| Poles | \(-2.5 \pm 4.3301i\) | Complex poles indicate oscillatory behavior; negative real parts indicate stability |
| Rise time | 0.3278 s | Time taken for the response to rise from 10% to 90% of its final value |
| Settling time | 1.6152 s | Time taken to settle within the specified tolerance |
| Overshoot | 16.29% | Output exceeds its final value by approximately 16.29% |
| Peak value | 1.1629 | Maximum output following a unit-step input |
| Peak time | 0.7184 s | Time at which the maximum output occurs |
| Undershoot | 0% | No undershoot |

## 3. Graph Interpretation

- **Step response:** The output rises quickly, exceeds its final value, and then settles toward 1. The overshoot is caused by insufficient damping.
- **Impulse response:** The output oscillates while its amplitude decreases over time, eventually approaching zero.
- **Pole-zero map:** The complex-conjugate poles lie in the left half of the complex plane, indicating a stable, underdamped system.
- **Bode plot:** Shows how the system's gain and phase change with frequency. The damping ratio influences the system's resonant behavior.

## 4. Conclusion

The system is stable and underdamped, as indicated by its complex-conjugate poles and damping ratio of 0.5. It responds relatively quickly but exhibits 16.29% overshoot before settling. Increasing the damping ratio would generally reduce oscillations and overshoot, although the overall response speed may also change.

**Key observation:** Unlike a first-order system, this second-order system can oscillate and overshoot its final value because of its complex poles.
