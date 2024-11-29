%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clean Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read data from signal
[signal,Fs] = audioread('clean_signal.wav');

% Pad with zeros until it is a power of 2 
N = max(size(signal));
if N > 0
    power_of_2 = 2^ceil(log2(N));
    signal = [signal; zeros(power_of_2 - N, 1)];
else
    disp('Clean signal is incompatible length');
    return;
end

% Compute FFTs
signal_fft = fft(signal);
signal_dit_fft = dit_fft(signal);

% Compute x axes in time and frequency domains 
t = linspace(0, N/Fs, N); % seconds
f = (-length(signal)/2:(length(signal)/2-1)) * (Fs / N); % Hz

% Figure formatting
f1 = figure(1);
subplot(2,1,1);
hold on 
plot(f, abs(signal_dit_fft), 'Linewidth', 2);
plot(f, abs(signal_fft), 'Linewidth', 2, 'LineStyle', '--');
title("Clean signal - MATLAB FFT compared to DIT FFT")
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
legend(["DIT FFT", "MATLAB FFT"])
ax = gca;
ax.FontSize = 12;

subplot(2,1,2);
hold on 
plot(f, abs(signal_dit_fft), 'Linewidth', 2);
plot(f, abs(signal_fft), 'Linewidth', 2, 'LineStyle', '--');
xlim([3620 3670])
title("Zoomed in")
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
legend(["DIT FFT", "MATLAB FFT"])
ax = gca;
ax.FontSize = 12;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Noisy Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read data from signal
[signal,Fs] = audioread('noisy_signal.wav');

% Pad with zeros until it is a power of 2 
N = max(size(signal));
if N > 0
    power_of_2 = 2^ceil(log2(N));
    signal = [signal; zeros(power_of_2 - N, 1)];
else
    disp('Noisy signal is incompatible length');
    return;
end

% Compute FFTs
signal_fft = fft(signal);
signal_dit_fft = dit_fft(signal);

% Compute x axes in time and frequency domains 
t = linspace(0, N/Fs, N); % seconds
f = (-length(signal)/2:(length(signal)/2-1)) * (Fs / N); % Hz

% Figure formatting
f2 = figure(2);
subplot(2,1,1);
hold on 
plot(f, abs(signal_dit_fft), 'Linewidth', 2);
plot(f, abs(signal_fft), 'Linewidth', 2, 'LineStyle', '--');
title("Noisy signal - MATLAB FFT compared to DIT FFT")
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
legend(["DIT FFT", "MATLAB FFT"])
ax = gca;
ax.FontSize = 12;

subplot(2,1,2);
hold on 
plot(f, abs(signal_dit_fft), 'Linewidth', 2);
plot(f, abs(signal_fft), 'Linewidth', 2, 'LineStyle', '--');
xlim([3620 3670])
title("Zoomed in")
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
legend(["DIT FFT", "MATLAB FFT"])
ax = gca;
ax.FontSize = 12;