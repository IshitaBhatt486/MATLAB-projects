clc; clear; close all;
s = tf('s');
G = 1/(s^2 + 2*s + 1);  % example plant

% Each row is [Kp Ki Kd]
gainSets = [
    1  0  0
    5  0  0
    3  2  0
    5  0  1
    5  2  1
    ];

labels = {'P: low gain', 'P: higher gain', 'PI', 'PD', 'PID'};
responses = cell(size(gainSets, 1), 1);

figure; hold on;
for i = 1:size(gainSets, 1)
    Kp = gainSets(i, 1); Ki = gainSets(i, 2); Kd = gainSets(i, 3);
    C = Kp + Ki/s + Kd*s;
    T = feedback(C*G, 1);  
    responses{i} = T;
    step(T, 10);
end
grid on;
legend(labels, 'Location', 'best');
title('PID : Closed-Loop Step Responses');
xlabel('Time (s)'); ylabel('Output');

fprintf('\n%-16s %10s %10s %10s %10s\n', ...
    'Controller', 'Rise(s)', 'Settle(s)', 'Overshoot%', 'SSE');
for i = 1:numel(responses)
    T = responses{i};
    info = stepinfo(T);
    yFinal = dcgain(T);
    ess = abs(1 - yFinal);
    fprintf('%-16s %10.3f %10.3f %10.2f %10.4f\n', ...
        labels{i}, info.RiseTime, info.SettlingTime, info.Overshoot, ess);
end