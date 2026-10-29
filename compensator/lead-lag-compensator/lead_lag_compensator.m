clear; clc; close all;
s = tf('s');

% Plant
G = 5/(s^2 + 2*s + 5);

% Lead section
T_lead = 0.5;
alpha = 0.2;
C_lead = (T_lead*s + 1)/(alpha*T_lead*s + 1);

% Lag section
T_lag = 5;
beta = 5;
C_lag = beta*(T_lag*s + 1)/(beta*T_lag*s + 1);

% Combined compensator
C = C_lead*C_lag;

% Unity-feedback systems
T_uncomp = feedback(G, 1);
T_lead_only = feedback(C_lead*G, 1);
T_lag_only = feedback(C_lag*G, 1);
T_leadlag = feedback(C*G, 1);

% Compare step responses
figure;
step(T_uncomp, T_lead_only, T_lag_only, T_leadlag, 15);
grid on;
legend('Uncompensated', 'Lead only', ...
    'Lag only', 'Lead-Lag', ...
    'Location', 'best');
title('Lead-Lag Compensator: Step Response');
xlabel('Time (s)');
ylabel('Output');

% Bode plot
figure;
bode(G, C_lead*G, C_lag*G, C*G);
grid on;
legend('Plant', 'Lead', 'Lag', 'Lead-Lag');
title('Open-Loop Frequency Response');

% Step response performance comparison
systems = {T_uncomp, T_lead_only, T_lag_only, T_leadlag};
names = {'Uncompensated'; 'Lead'; 'Lag'; 'Lead-Lag'};

RiseTime = zeros(4,1);
SettlingTime = zeros(4,1);
Overshoot = zeros(4,1);
SteadyStateError = zeros(4,1);

for k = 1:4
    info = stepinfo(systems{k});
    RiseTime(k) = info.RiseTime;
    SettlingTime(k) = info.SettlingTime;
    Overshoot(k) = info.Overshoot;
    SteadyStateError(k) = abs(1 - dcgain(systems{k}));
end

Results = table(names, RiseTime, SettlingTime, ...
    Overshoot, SteadyStateError, ...
    'VariableNames', {'System', 'RiseTime_s', ...
    'SettlingTime_s', 'Overshoot_percent', 'StepError'});

disp(Results);

% Pole-zero map of combined compensator
figure;
pzmap(C);
grid on;
title('Lead-Lag Compensator Pole-Zero Map');

% Open-loop stability margins
figure;
margin(C*G);
grid on;
title('Lead-Lag Open-Loop Stability Margins');