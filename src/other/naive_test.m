% Define a test signal (e.g., a sine wave)
fs = 1000;          % Sampling frequency (Hz)
t = 0:1/fs:1-1/fs;  % Time vector
f = 10;             % Frequency of the sine wave (Hz)
x = sin(2 * pi * f * t);  % Test signal

% Compute the DFT using the naive implementation
X = naive_dft(x);

% Plot the magnitude spectrum
f_axis = (0:length(X)-1) * (fs / length(X));  % Frequency axis
figure;
plot(f_axis, abs(X));
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;