% Inverted Pendulum Stabilization (cart-pole)
% Educational simulation: linearized LQR gains control the nonlinear model.
% Requires Control System Toolbox (lqr).
clc; clear; close all;

% Parameters (illustrative SI units)
M = 0.5;      % cart mass (kg)
m = 0.2;      % pendulum mass (kg)
b = 0.1;      % cart friction (N s/m)
ell = 0.3;    % pivot-to-pendulum-center distance (m)
g = 9.81;     % gravity (m/s^2)
I = 0.006;    % pendulum moment of inertia about its center (kg m^2)

% Linearized state: x = [cart position; cart velocity; angle; angular velocity]
p = I*(M + m) + M*m*ell^2;
A = [0 1 0 0;
     0 -(I + m*ell^2)*b/p (m^2*g*ell^2)/p 0;
     0 0 0 1;
     0 -(m*ell*b)/p m*g*ell*(M + m)/p 0];
B = [0; (I + m*ell^2)/p; 0; m*ell/p];

% Penalize angle strongly; allow some cart movement.
Q = diag([10 1 150 2]);
R = 0.5;
K = lqr(A, B, Q, R);
disp('LQR gain K ='); disp(K);

% Nonlinear simulation with saturation
x0 = [0; 0; deg2rad(8); 0]; % 8 degree initial tilt
tspan = [0 8];
uMax = 10; % force limit in newtons
opts = odeset('RelTol', 1e-7, 'AbsTol', 1e-9);

[t, X] = ode45(@(t,x) cartPoleODE(t, x, M, m, b, ell, g, I, K, uMax), ...
    tspan, x0, opts);

figure;
subplot(3,1,1);
plot(t, X(:,1), 'LineWidth', 1.5); grid on;
ylabel('Cart x (m)'); title('Inverted Pendulum Stabilization');
subplot(3,1,2);
plot(t, rad2deg(X(:,3)), 'LineWidth', 1.5); grid on;
ylabel('Angle (deg)');
subplot(3,1,3);
plot(t, X(:,2), t, X(:,4), 'LineWidth', 1.5); grid on;
xlabel('Time (s)'); ylabel('Velocity');
legend('Cart velocity (m/s)', 'Angular velocity (rad/s)', 'Location', 'best');

fprintf('Final cart position: %.4f m\n', X(end,1));
fprintf('Final pendulum angle: %.4f deg\n', rad2deg(X(end,3)));

function dx = cartPoleODE(~, x, M, m, b, ell, g, I, K, uMax)
    % Angle is measured from the upright position (theta = 0).
    state = x(:);
    u = -K*state;
    u = max(min(u, uMax), -uMax);

    pos = state(1);
    vel = state(2);
    theta = state(3);
    omega = state(4);

    totalMass = M + m;
    denom = I + m*ell^2;
    s = sin(theta);
    c = cos(theta);

    % Coupled nonlinear cart-pole equations.
    temp = (u - b*vel + m*ell*omega^2*s) / totalMass;
    thetaAcc = (g*s - c*temp) / (ell*(4/3 - m*c^2/totalMass));
    xAcc = temp - m*ell*thetaAcc*c/totalMass;

    dx = [vel; xAcc; omega; thetaAcc];
end
