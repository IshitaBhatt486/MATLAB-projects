clc; clear; close all;
s = tf('s');

% System: G(s) = K/(tau*s + 1)
K = 2;
tau = 1.5;
G = K/(tau*s + 1);

% Unity negative-feedback system
T = feedback(G, 1);

fprintf('First-Order System\n');
fprintf('Pole: %.3f\n', pole(G));
fprintf('Time constant: %.3f s\n', tau);
fprintf('Open-loop DC gain: %.3f\n', dcgain(G));
fprintf('Closed-loop DC gain: %.3f\n', dcgain(T));
disp('Step response metrics:');
disp(stepinfo(G));

figure('Name', 'First-Order System');

subplot(2,2,1);
step(G, 8*tau);
grid on;
title('Step Response');

subplot(2,2,2);
impulse(G, 8*tau);
grid on;
title('Impulse Response');

subplot(2,2,3);
step(G, T, 8*tau);
grid on;
legend('Open Loop', 'Closed Loop');
title('Effect of Feedback');

subplot(2,2,4);
pzmap(G);
grid on;
title('Pole-Zero Map');