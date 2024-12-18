% Main driver script for producing all plots included in report 

close all;
clear; clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plotting the magnitude spectrums of clean and noisy signals 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Read data from signals 
[clean_signal, ~] = audioread('clean_signal.wav');
[noisy_signal, Fs] = audioread('noisy_signal.wav');

% Compute dft of each signal using each algorithm
% Shift zero-frequency component to center of spectrum
clean_signal_dit_fft = fftshift(dit_fft(clean_signal));
noisy_signal_dit_fft = fftshift(dit_fft(noisy_signal));
disp("Computed DIT FFT of signals")
clean_signal_dif_fft = fftshift(dif_fft(clean_signal));
noisy_signal_dif_fft = fftshift(dif_fft(noisy_signal));
disp("Computed DIF FFT of signals")
clean_signal_naive_dft = fftshift(naive_dft(clean_signal));
noisy_signal_naive_dft = fftshift(naive_dft(noisy_signal));
disp("Computed Naive DFT of signals")
clean_signal_fft = fftshift(fft(clean_signal));
noisy_signal_fft = fftshift(fft(noisy_signal));
disp("Computed Matlab FFT of signals")

% Find the length of the audio signals
N = max(size(clean_signal)); % Same for noisy signal
% dif and dit ffts pad the input, the naive dft does not 
N_fft = max(size(clean_signal_dit_fft));

% Compute x axes in frequency domain
f_dft = (-N/2:(N/2-1)) * (Fs / N); % Hz, fewer data points
f_dif_dit = (-N_fft/2:(N_fft/2-1)) * (Fs / N) * (N / N_fft); % Hz

% Figure formatting
f1 = figure(1); % Plot clean signal on left, noisy signal on right
y_lim_top  = 4500; y_lim_bottom = -100; % Range of y for each plot
x_lim_left = 420; x_lim_right  = 460; % Zoomed in x domain 
linewidth = 3;
font_size = 18;

% Plot data
subplot(2,2,1);
hold on 
plot(f_dif_dit, abs(clean_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(clean_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(clean_signal_fft), 'Linewidth', linewidth);
plot(f_dft, abs(clean_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title({"Clean signal - Magnitude spectrum" 
       "Output of DFT/FFT implementations compared"})
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT", "Matlab FFT", "Naive DFT"], 'Location', 'best')
ax = gca;
ax.FontSize = font_size;

subplot(2,2,3);
hold on 
plot(f_dif_dit, abs(clean_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(clean_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(clean_signal_fft), 'Linewidth', linewidth);
plot(f_dft, abs(clean_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title("Zoomed in")
xlabel("Frequency (Hz)")
xlim([x_lim_left x_lim_right])
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT", "Matlab FFT", "Naive DFT"], 'Location', 'best')
ax = gca;
ax.FontSize = font_size;

subplot(2,2,2);
hold on 
plot(f_dif_dit, abs(noisy_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(noisy_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(noisy_signal_fft), 'Linewidth', linewidth);
plot(f_dft, abs(noisy_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title({"Noisy signal - Magnitude spectrum" 
       "Output of DFT/FFT implementations compared"})
xlabel("Frequency (Hz)")
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT", "Matlab FFT", "Naive DFT"], 'Location', 'best')
ax = gca;
ax.FontSize = font_size;

subplot(2,2,4);
hold on 
plot(f_dif_dit, abs(noisy_signal_dit_fft), 'Linewidth', linewidth);
plot(f_dif_dit, abs(noisy_signal_dif_fft), 'Linewidth', linewidth, 'LineStyle', '--');
plot(f_dft, abs(noisy_signal_fft), 'Linewidth', linewidth);
plot(f_dft, abs(noisy_signal_naive_dft), 'Linewidth', linewidth, 'LineStyle', ':');
title("Zoomed in")
xlabel("Frequency (Hz)")
xlim([x_lim_left x_lim_right])
ylabel("Magnitude of DFT")
ylim([y_lim_bottom y_lim_top])
legend(["DIT FFT", "DIF FFT", "Matlab FFT", "Naive DFT"], 'Location', 'best')
ax = gca;
ax.FontSize = font_size;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Computational cost analysis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create vector for different lengths of 2^8 to 2^20
lengths = 2.^(5:14);
num_tests = length(lengths);

% Create output vector for the times and frequency for sinusoids
dft_time = zeros(1, num_tests);
dit_fft_time = zeros(1, num_tests);
dif_fft_time = zeros(1, num_tests);
sinusoid_frequency = 200;
sampling_frequency = 1000;

% For each size test the time it takes for the functions to run
for i = 1:num_tests
    current_length = lengths(i);
    time = (0:current_length-1) / sampling_frequency;
    sinusoid_signal = sin(2*pi*sinusoid_frequency*time);
    noise = randn(1, current_length);
    signal = sinusoid_signal + noise;

    % start time for naive_dft
    tic;
    naive_dft(signal(:));
    naive_dft_time(i) = toc;

    % start time for dit_fft
    tic;
    dit_fft(signal(:));
    dit_fft_time(i) = toc;

    % start time for dit_fft
    tic;
    dif_fft(signal(:));
    dif_fft_time(i) = toc;

    % start time to matlab fft
    tic;
    fft(signal(:));
    fft_time(i) = toc;
end

disp("Lengths size: " + size(lengths));
disp("Naive DFT time size: " + size(naive_dft_time));
disp("DIF FFT time size: " + size(dif_fft_time));
disp("DIT FFT time size: " + size(dit_fft_time));
disp("Matlab FFT time size: " + size(fft_time));

% Plot signal length vs time
f2 = figure(2);
% loglog(lengths, naive_dft_time, lengths, dif_fft_time, lengths, dit_fft_time, "--");
loglog(lengths, dit_fft_time,   "o-", ...  % DIT FFT
       lengths, dif_fft_time,  "o--", ...  % DIF FFT
       lengths, fft_time, "o-", ... % Matlab FFT
       lengths, naive_dft_time, "o--", ...  % Naive DFT
       'Linewidth', 2);     

% Update x-axis to log base 2
set(gca, 'XScale', 'log', 'YScale', 'log'); % Use log scale
xticks(lengths); % Tick marks only at powers of 2
xticklabels("2^{"+log2(lengths)+"}"); % Label ticks as log2(lengths)

xlabel("Signal Input Size (Log Base 2)");
ylabel("Execution Time (s)");
legend("DIT FFT", "DIF FFT", "Matlab FFT", "Naive DFT", 'Location', 'northwest');
title("Time comparison for DFT/FFT Implementations");
grid on;
% Add grid lines to improve readability
grid minor;
ax = gca;
ax.FontSize = 12;
