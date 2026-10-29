clear; clc; close all;
s = tf('s');

% Plant
G = 5/(s^2 + 2*s + 5);

% Lag compensator
beta = 5;
T = 5;
C = beta*(T*s + 1)/(beta*T*s + 1);

% Unity-feedback systems
T_uncomp = feedback(G, 1);
T_comp = feedback(C*G, 1);

% Step response
figure;
step(T_uncomp, T_comp, 15);
grid on;
legend('Uncompensated', 'Lag compensated');
title('Lag Compensator: Step Response');
xlabel('Time (s)');
ylabel('Output');

% Bode comparison
figure;
bode(G, C*G);
grid on;
legend('Plant', 'Lag compensated open loop');
title('Lag Compensator: Bode Plot');

% Performance metrics
disp('Uncompensated system:');
disp(stepinfo(T_uncomp));

disp('Lag compensated system:');
disp(stepinfo(T_comp));

% Steady-state error for unit-step input
ess_uncomp = abs(1 - dcgain(T_uncomp));
ess_comp = abs(1 - dcgain(T_comp));

fprintf('Uncompensated step error: %.4f\n', ess_uncomp);
fprintf('Lag compensated step error: %.4f\n', ess_comp);

% Pole-zero map
figure;
pzmap(C);
grid on;
title('Lag Compensator Pole-Zero Map');

% Open-loop margins
figure;
margin(C*G);
grid on;
title('Lag Compensated Open-Loop Margins');