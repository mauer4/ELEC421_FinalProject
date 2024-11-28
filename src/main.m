% main_script.m - Test and analyze audio signals using DFT and FFT implementations

% Load audio signals
[noisy_signal, fs] = audioread('noisy_signal.wav');
[clean_signal, ~] = audioread('clean_signal.wav');

% Select a segment for analysis (optional)
noisy_signal = noisy_signal(1:1024);
clean_signal = clean_signal(1:1024);

% Apply Naive DFT
X_dft_noisy = naive_dft(noisy_signal);
X_dft_clean = naive_dft(clean_signal);

% Apply DIT FFT
X_dit_noisy = dit_fft(noisy_signal);
X_dit_clean = dit_fft(clean_signal);

% Apply DIF FFT
X_dif_noisy = dif_fft(noisy_signal);
X_dif_clean = dif_fft(clean_signal);

% Plot magnitude spectra
f_axis = (0:length(noisy_signal)-1) * (fs / length(noisy_signal));

figure;
subplot(2, 1, 1);
plot(f_axis, abs(X_dit_noisy));
title('Magnitude Spectrum (Noisy Signal)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

subplot(2, 1, 2);
plot(f_axis, abs(X_dit_clean));
title('Magnitude Spectrum (Clean Signal)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;

% Compare computational performance
N_values = [64, 128, 256, 512, 1024];
time_dft = zeros(size(N_values));
time_dit = zeros(size(N_values));
time_dif = zeros(size(N_values));

for i = 1:length(N_values)
    signal = randn(1, N_values(i)); % Random signal of length N

    % Measure time for Naive DFT
    tic;
    naive_dft(signal);
    time_dft(i) = toc;

    % Measure time for DIT FFT
    tic;
    dit_fft(signal);
    time_dit(i) = toc;

    % Measure time for DIF FFT
    %tic;
    %dif_fft(signal);
    %time_dif(i) = toc;
end

% Plot computational performance
figure;
plot(N_values, time_dft, '-o', 'DisplayName', 'Naive DFT');
hold on;
plot(N_values, time_dit, '-x', 'DisplayName', 'DIT FFT');
plot(N_values, time_dif, '-s', 'DisplayName', 'DIF FFT');
xlabel('Signal Length (N)');
ylabel('Execution Time (seconds)');
legend;
title('Computational Performance of DFT and FFT Implementations');
grid on;