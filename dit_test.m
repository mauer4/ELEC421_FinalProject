% Define a test signal (e.g., a sine wave)
fs = 1000;          % Sampling frequency (Hz)
t = 0:1/fs:1-1/fs;  % Time vector
f = 200;             % Frequency of the sine wave (Hz)
x = sin(2 * pi * f * t);  % Test signal

% Ensure the signal length is a power of 2 by padding with zeros if necessary
x_padded = pad_to_power_of_2(x);

% Compute the FFT using the DIT implementation
X_dit = dit_fft(x_padded);

% Plot the magnitude spectrum
f_axis = (0:length(X_dit)-1) * (fs / length(X_dit));  % Frequency axis
figure;
plot(f_axis, abs(X_dit));
title('Magnitude Spectrum (DIT FFT)');
xlabel('Frequency (Hz)');
ylabel('|X(f)|');
grid on;
