# Inverted Pendulum Stabilization Using LQR

Simulation of a Linear Quadratic Regulator (LQR) controller to stabilize an inverted pendulum and return the cart to its equilibrium position.

An inverted pendulum is an inherently unstable system consisting of a pendulum mounted on a movable cart. LQR is a state-feedback control technique that minimizes a quadratic cost function:

\[
J=\int_0^\infty (x^TQx+u^TRu)\,dt
\]

The control input is:

\[
u=-Kx
\]

where \(x\) is the state vector, \(K\) is the LQR gain matrix, and \(Q\) and \(R\) determine the relative penalties on state errors and control effort.

## Implementation
The system is modeled using linearized state-space equations. MATLAB's `lqr()` function calculates the feedback gain matrix. The closed-loop system is simulated using `ode45()` from an initial pendulum angle of \(5^\circ\).

The state vector contains cart position, cart velocity, pendulum angle, and angular velocity.

### LQR Gain Matrix

K = [-10.0000  -10.9418  59.6122  10.3426]

All closed-loop poles have negative real parts, indicating asymptotic stability of the linearized closed-loop system.

## Graph Interpretation

- Cart position: The cart initially moves to counteract the pendulum's angular displacement and eventually returns to its equilibrium position.
- Pendulum angle: The angle converges toward \(0^\circ\), indicating successful stabilization around the upright equilibrium.
- Control input: The controller applies a corrective force, with a maximum magnitude of 5.2022 N, before the force decreases as the system settles.

## Conclusion
The LQR controller successfully stabilizes the linearized inverted pendulum from an initial angular displacement of \(5^\circ\). The cart returns to its equilibrium position, the pendulum approaches the upright position, and all closed-loop poles lie in the left half-plane. The maximum cart displacement is 0.0721 m, demonstrating effective stabilization for the simulated initial condition.