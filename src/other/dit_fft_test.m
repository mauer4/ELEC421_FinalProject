%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clean Signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read data from signal
[signal,Fs] = audioread('clean_signal.wav');

% Compute dit fft
signal_dit_fft = dit_fft(signal);

% Pad with zeros until it is a power of 2 to get matlab fft of same length
N_orig = max(size(signal));
if N_orig > 0
    power_of_2 = 2^ceil(log2(N_orig));
    signal_padded = [signal; zeros(power_of_2 - N_orig, 1)];
    N_pad = max(size(signal_padded));
else
    disp('Clean signal is incompatible length');
    return;
end
% Compute matlab fft
signal_fft = fft(signal_padded);

% Compute x axes in time and frequency domains 
t = linspace(0, N_orig/Fs, N_orig); % seconds
f = (-N_pad/2:(N_pad/2-1)) * (Fs / N_orig); % Hz

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

clear;

% Read data from signal
[signal,Fs] = audioread('noisy_signal.wav');

% Compute dit fft
signal_dit_fft = dit_fft(signal);

% Pad with zeros until it is a power of 2 to get matlab fft of same length
N_orig = max(size(signal));
if N_orig > 0
    power_of_2 = 2^ceil(log2(N_orig));
    signal_padded = [signal; zeros(power_of_2 - N_orig, 1)];
    N_pad = max(size(signal_padded));
else
    disp('Clean signal is incompatible length');
    return;
end
% Compute matlab fft
signal_fft = fft(signal_padded);

% Compute x axes in time and frequency domains 
t = linspace(0, N_orig/Fs, N_orig); % seconds
f = (-N_pad/2:(N_pad/2-1)) * (Fs / N_orig); % Hz

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