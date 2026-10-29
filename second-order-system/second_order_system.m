clc; clear; close all;
s = tf('s');

wn = 5;                         % Natural frequency (rad/s)
zetaValues = [0.2 0.5 1.0 1.5];

systems = cell(size(zetaValues));
labels = cell(size(zetaValues));

figure('Name', 'Second-Order System');

% Compare step responses for different damping ratios
subplot(2,2,1);
hold on;

for i = 1:length(zetaValues)
    zeta = zetaValues(i);

    G = wn^2/(s^2 + 2*zeta*wn*s + wn^2);
    systems{i} = G;
    labels{i} = sprintf('zeta = %.1f', zeta);

    step(G, 5);
end

grid on;
title('Step Response vs Damping Ratio');
legend(labels, 'Location', 'best');
hold off;

% Compare impulse responses
subplot(2,2,2);
hold on;

for i = 1:length(zetaValues)
    impulse(systems{i}, 5);
end

grid on;
title('Impulse Response vs Damping Ratio');
legend(labels, 'Location', 'best');
hold off;

% Pole-zero map for zeta = 0.5
zeta = 0.5;
G = wn^2/(s^2 + 2*zeta*wn*s + wn^2);

subplot(2,2,3);
pzmap(G);
grid on;
title('Pole-Zero Map');

% Frequency response
subplot(2,2,4);
margin(G);
grid on;
title('Bode Plot and Stability Margins');

fprintf('Second-Order System\n');
fprintf('Natural frequency: %.2f rad/s\n', wn);
fprintf('Damping ratio: %.2f\n', zeta);
disp('Poles:');
disp(pole(G));
disp('Step response metrics:');
disp(stepinfo(G));