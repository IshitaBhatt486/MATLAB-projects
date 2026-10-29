clear; clc; close all;
rng(42);

%% 1. Configuration
N_values = [8 16 32 64 128 256 512 1024];
N_runs = 100;

num_N = length(N_values);
dft_time = zeros(1, num_N);
fft_time = zeros(1, num_N);
dft_mult = zeros(1, num_N);
fft_mult = zeros(1, num_N);
dft_add = zeros(1, num_N);
fft_add = zeros(1, num_N);
max_error = zeros(1, num_N);

fprintf('============================================\n');
fprintf('        DFT vs FFT        ');
fprintf('============================================\n\n');

%% 2. Benchmark both algorithms
for i = 1:num_N
    N = N_values(i);

    % Same random complex input for both algorithms
    x = randn(1,N) + 1j*randn(1,N);

    % Warm-up runs (not included in timing)
    myDFT(x);
    myFFT(x);

    % Direct DFT benchmark
    elapsed = 0;
    for r = 1:N_runs
        tic;
        [X_dft, nmul_dft, nadd_dft] = myDFT(x);
        elapsed = elapsed + toc;
    end
    dft_time(i) = elapsed/N_runs;

    % FFT benchmark
    elapsed = 0;
    for r = 1:N_runs
        tic;
        [X_fft, nmul_fft, nadd_fft] = myFFT(x);
        elapsed = elapsed + toc;
    end
    fft_time(i) = elapsed/N_runs;

    % Operation counts
    dft_mult(i) = nmul_dft;
    fft_mult(i) = nmul_fft;
    dft_add(i) = nadd_dft;
    fft_add(i) = nadd_fft;

    % Numerical accuracy
    max_error(i) = max(abs(X_dft-X_fft));

    fprintf('N = %4d | DFT = %9.4f ms | FFT = %9.4f ms | Speedup = %8.2fx\n', ...
        N, dft_time(i)*1000, fft_time(i)*1000, ...
        dft_time(i)/max(fft_time(i),eps));
end

%% 3. Print results table
fprintf('\n================ RESULTS TABLE ================\n');
fprintf('%6s %13s %13s %12s %12s %12s\n', ...
    'N','DFT mult','FFT mult','DFT time(ms)','FFT time(ms)','Max error');

for i = 1:num_N
    fprintf('%6d %13d %13d %12.4f %12.4f %12.3e\n', ...
        N_values(i), dft_mult(i), fft_mult(i), ...
        dft_time(i)*1000, fft_time(i)*1000, max_error(i));
end

%% 4. Figure 1: Runtime comparison
figure('Name','Runtime Comparison','Color','w');

loglog(N_values, dft_time*1000, 'o-', ...
    'LineWidth',2,'MarkerSize',7);
hold on;
loglog(N_values, fft_time*1000, 's-', ...
    'LineWidth',2,'MarkerSize',7);

% Theoretical complexity curves, scaled to measured results
dft_theory = dft_time(end)*1000 * ...
    (N_values/N_values(end)).^2;

fft_theory = fft_time(end)*1000 * ...
    (N_values.*log2(N_values)) ./ ...
    (N_values(end)*log2(N_values(end)));

loglog(N_values,dft_theory,'--','LineWidth',1.5);
loglog(N_values,fft_theory,'--','LineWidth',1.5);

grid on;
xlabel('Input length N');
ylabel('Average execution time (ms)');
title('Direct DFT vs FFT: Runtime');
legend('Direct DFT measured','FFT measured', ...
    'O(N^2) reference','O(N log_2 N) reference', ...
    'Location','northwest');

%% 5. Figure 2: Multiplication counts
figure('Name','Operation Counts','Color','w');

loglog(N_values,dft_mult,'o-','LineWidth',2,'MarkerSize',7);
hold on;
loglog(N_values,fft_mult,'s-','LineWidth',2,'MarkerSize',7);

loglog(N_values,N_values.^2,'--','LineWidth',1.5);
loglog(N_values,(N_values/2).*log2(N_values), ...
    '--','LineWidth',1.5);

grid on;
xlabel('Input length N');
ylabel('Complex multiplication count');
title('Computational Complexity');
legend('Direct DFT measured','FFT measured', ...
    'N^2 reference','(N/2)log_2(N) reference', ...
    'Location','northwest');

%% 6. Figure 3: FFT speedup
speedup = dft_time ./ max(fft_time,eps);

figure('Name','FFT Speedup','Color','w');
semilogx(N_values,speedup,'o-','LineWidth',2,'MarkerSize',8);
hold on;
yline(1,'--','Equal runtime');
grid on;
xlabel('Input length N');
ylabel('DFT time / FFT time');
title('Measured FFT Speedup');
xticks(N_values);

%% 7. Figure 4: Numerical accuracy
figure('Name','Numerical Accuracy','Color','w');
semilogy(N_values,max(max_error,eps),'o-', ...
    'LineWidth',2,'MarkerSize',8);
grid on;
xlabel('Input length N');
ylabel('Maximum absolute difference');
title('Numerical Agreement: Direct DFT vs FFT');
xticks(N_values);

%% 8. Summary
fprintf('\n================ SUMMARY =====================\n');
fprintf('Largest input size: %d\n',N_values(end));
fprintf('Speedup at largest N: %.2fx\n',speedup(end));
fprintf('Maximum numerical error: %.3e\n',max(max_error));
fprintf('Figures generated: 4\n');

%% Local function 1: Direct DFT
function [X,nmul,nadd] = myDFT(x)
    x = x(:).';
    N = length(x);
    X = zeros(1,N);
    W = exp(-1j*2*pi/N);

    nmul = 0;
    nadd = 0;

    for k = 0:N-1
        acc = 0;
        for n = 0:N-1
            acc = acc + x(n+1)*W^(k*n);
            nmul = nmul + 1;
            nadd = nadd + 1;
        end
        X(k+1) = acc;
    end
end

%% Local function 2: Radix-2 DIT FFT
function [X,nmul,nadd] = myFFT(x)
    x = x(:).';
    M = length(x);

    % Pad input to the next power of two
    N = 2^nextpow2(M);
    x = [x zeros(1,N-M)];

    % Bit-reversal permutation
    x = bitrevorder(x);

    nmul = 0;
    nadd = 0;
    num_stages = log2(N);

    % Iterative radix-2 butterfly stages
    for S = 1:num_stages
        L = 2^S;
        halfL = L/2;
        W = exp(-1j*2*pi/L);

        for b = 0:L:N-1
            for m = 0:halfL-1
                p = b+m+1;
                q = p+halfL;

                t = W^m*x(q);

                xq = x(p)-t;
                xp = x(p)+t;

                x(p) = xp;
                x(q) = xq;

                % Count nontrivial twiddle multiplications only
                if m ~= 0
                    nmul = nmul+1;
                end

                % Two butterfly additions/subtractions
                nadd = nadd+2;
            end
        end
    end

    X = x;
end
