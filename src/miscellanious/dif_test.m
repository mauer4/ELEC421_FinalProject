% Example signal: A simple sine wave with noise
fs = 1000;               % Sampling frequency (Hz)
T = 1 / fs;              % Sampling period (s)
L = 1024;                % Length of signal (must be power of 2)
t = (0:L-1) * T;         % Time vector

% Generate a signal with two frequency components: 50 Hz and 120 Hz
f1 = 50;                 % First frequency component (Hz)
f2 = 120;                % Second frequency component (Hz)

signal = 0.7 * sin(2 * pi * f1 * t) + sin(2 * pi * f2 * t);

% Add some noise to the signal
noisy_signal = signal + 0.5 * randn(size(t));

% Make sure the signal is of length power of 2, if needed
padded_signal = pad_to_power_of_2(noisy_signal);  % This function should pad the signal to the nearest power of 2 if not already

% Show the signal for debugging
figure;
plot(t, padded_signal);
title('Generated Noisy Signal');
xlabel('Time (s)');
ylabel('Amplitude');


subplot(2,1,2);
plot(f, magnitude_dif, 'r', f, magnitude_builtin, 'b--');
legend('DIF FFT', 'MATLAB FFT');
title('Magnitude Spectrum of the Signal');
xlabel('Frequency (Hz)');
ylabel('Magnitude');

