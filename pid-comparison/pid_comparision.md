# PID Controller Comparison and Tuning

Comparision of P, PI, PD, and PID controllers using MATLAB and analyzing their effects on closed-loop system performance.

A PID controller combines three control actions:

- **Proportional (P):** Responds to the current error.
- **Integral (I):** Reduces steady-state error.
- **Derivative (D):** Responds to the rate of change of error.

The controller transfer function is:

\[
C(s)=K_p+\frac{K_i}{s}+K_ds
\]

The closed-loop transfer function with unity negative feedback is:

\[
T(s)=\frac{C(s)G(s)}{1+C(s)G(s)}
\]

where \(G(s)\) is the plant transfer function and \(K_p\), \(K_i\), and \(K_d\) are the controller gains.

The experiment compares P, PI, PD, and PID controllers for the same plant. The `step()` function plots their closed-loop responses, allowing comparison of rise time, settling time, overshoot, and steady-state behavior.

## Graph Interpretation
The step-response graph compares how quickly each controller reaches its target, how much it overshoots, and how it behaves as time increases.

- P control adjusts the response through proportional gain.
- PI control adds integral action to reduce steady-state error.
- PD control adds derivative action that can improve transient behavior.
- PID control combines all three actions, balancing response speed, steady-state accuracy, and damping depending on the selected gains.

## Conclusion
The experiment demonstrates how different controller structures affect closed-loop step response.