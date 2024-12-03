% Main driver script for producing all plots including in report 

close all;
clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the magnitude spectrums of clean and noisy signals 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read data from signals 
[clean_signal, ~] = audioread('clean_signal.wav');
[noisy_signal, Fs] = audioread('noisy_signal.wav');

% Compute dft of each signal using each algorithm
clean_signal_dit_fft = dit_fft(clean_signal);
noisy_signal_dit_fft = dit_fft(noisy_signal);
disp("Computed DIT FFT of signals")
clean_signal_dif_fft = dif_fft(clean_signal);
noisy_signal_dif_fft = dif_fft(noisy_signal);
disp("Computed DIF FFT of signals")
clean_signal_naive_dft = naive_dft(clean_signal);
noisy_signal_naive_dft = naive_dft(noisy_signal);
disp("Computed Naive DFT of signals")

% Find the length of the audio signals
N = max(size(clean_signal)); % Same for noisy signal
% dif and dit ffts pad the input, the naive dft does not 
N_fft = max(size(clean_signal_dit_fft));

% Compute x axes in time and frequency domains 
f_dft = (-N/2:(N/2-1)) * (Fs / N); % Hz, fewer data points
f_dif_dit = (-N_fft/2:(N_fft/2-1)) * (Fs / N) * (N / N_fft); % Hz

% Figure formatting
f1 = figure(1); % Plot clean signal on left, noisy signal on right
y_lim_top  = 4500; y_lim_bottom = -100; % Range of y for each plot
x_lim_left = 3540; x_lim_right  = 3580; % Zoomed in x domain 
linewidth = 3;
font_size = 18;

subplot(2,2,1);
hold on 
plot(f_dif_dit, abs(clean_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(clean_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(clean_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title({"Clean signal - Magnitude spectrum" 
       "Output of DIT and DIF FFT compared to Naive DFT"})
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT","Naive DFT"], 'Location', 'north')
ax = gca;
ax.FontSize = font_size;

subplot(2,2,3);
hold on 
plot(f_dif_dit, abs(clean_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(clean_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(clean_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title("Zoomed in")
xlabel("Frequency (Hz)")
xlim([x_lim_left x_lim_right])
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT","Naive DFT"], 'Location', 'best')
ax = gca;
ax.FontSize = font_size;

subplot(2,2,2);
hold on 
plot(f_dif_dit, abs(noisy_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(noisy_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(noisy_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title({"Noisy signal - Magnitude spectrum" 
       "Output of DIT and DIF FFT compared to Naive DFT"})
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT","Naive DFT"], 'Location', 'north')
ax = gca;
ax.FontSize = font_size;

subplot(2,2,4);
hold on 
plot(f_dif_dit, abs(noisy_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(noisy_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(noisy_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title("Zoomed in")
xlabel("Frequency (Hz)")
xlim([x_lim_left x_lim_right])
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT","Naive DFT"], 'Location', 'best')
ax = gca;
ax.FontSize = font_size;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computational cost analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

