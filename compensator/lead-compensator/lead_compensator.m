clear; clc; close all;
s = tf('s');

% Plant
G = 5/(s^2 + 2*s + 5);

% Lead compensator: zero before pole
K = 1;
T = 0.5;
alpha = 0.2;
C = K*(T*s + 1)/(alpha*T*s + 1);

% Unity-feedback systems
T_uncomp = feedback(G, 1);
T_comp = feedback(C*G, 1);

% Step response
figure;
step(T_uncomp, T_comp, 10);
grid on;
legend('Uncompensated', 'Lead compensated');
title('Lead Compensator: Step Response');
xlabel('Time (s)');
ylabel('Output');

% Bode comparison
figure;
bode(G, C*G);
grid on;
legend('Plant', 'Lead compensated open loop');
title('Lead Compensator: Bode Plot');

% Performance metrics
disp('Uncompensated system:');
disp(stepinfo(T_uncomp));

disp('Lead compensated system:');
disp(stepinfo(T_comp));

% Gain and phase margins
figure;
margin(G);
grid on;
title('Uncompensated Open-Loop Margins');

figure;
margin(C*G);
grid on;
title('Lead Compensated Open-Loop Margins');

% Pole-zero map
figure;
pzmap(C);
grid on;
title('Lead Compensator Pole-Zero Map');