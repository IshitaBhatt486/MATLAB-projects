# First-Order System Analysis

## 1. System Model

The transfer function used was:

\[
G(s)=\frac{2}{1.5s+1}
\]

The system has a gain \(K=2\) and a time constant \(\tau=1.5\,s\). The closed-loop system uses unity negative feedback.

## 2. Results and Interpretation

| Parameter | Result | Interpretation |
|---|---:|---|
| Pole | -0.667 | Negative pole indicates a stable system |
| Time constant | 1.5 s | Output reaches approximately 63.2% of its final value after 1.5 s |
| Open-loop DC gain | 2.000 | Final output for a unit-step input approaches 2 |
| Closed-loop DC gain | 0.667 | Feedback reduces the final output to approximately 0.667 |
| Rise time | 3.296 s | Time taken for the open-loop response to rise from 10% to 90% of its final value |
| Settling time | 5.868 s | Time taken to enter and remain within the settling band |
| Overshoot | 0% | The response does not exceed its final value |
| Peak | 1.999 | Maximum output is approximately 2 |

## 3. Graph Interpretation

- **Step response:** The output rises smoothly toward 2 without oscillations or overshoot.
- **Impulse response:** The output initially responds strongly and then decays exponentially toward zero.
- **Open-loop vs. closed-loop:** Unity negative feedback reduces the steady-state output from 2 to \(2/3\), changing the system's response.
- **Pole-zero map:** The pole at \(-0.667\) lies in the left half of the complex plane, indicating stability. The system has no finite zeros.

## 4. Conclusion

The first-order system is stable and exhibits a smooth, non-oscillatory response. Its time constant determines the response speed, while unity negative feedback reduces the steady-state gain. The absence of overshoot is characteristic of this first-order model.