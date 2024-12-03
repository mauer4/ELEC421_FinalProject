close all;
clear; clc;

[clean_signal, ~] = audioread('clean_signal.wav');
[noisy_signal, Fs] = audioread('noisy_signal.wav');

% w/o padding
clean_signal_matlab_fft = fftshift(fft(clean_signal));
clean_signal_naive_dft = fftshift(naive_dft(clean_signal));

% Pad with zeros until it is a power of 2 
N = max(size(clean_signal))
if N > 0
    power_of_2 = 2^ceil(log2(N));
    clean_signal_padded = [clean_signal; zeros(16000, 1)];
    N_pad = max(size(clean_signal_padded))
else
    disp('Clean signal is incompatible length');
    return;
end 

% with padding
clean_signal_matlab_fft_padded = fftshift(fft(clean_signal_padded));
clean_signal_naive_dft_padded = fftshift(naive_dft(clean_signal_padded));

% x axis
f = (-N/2:(N/2-1)) * (Fs / N); % Hz, fewer data points
f_padded = (-N_pad/2:(N_pad/2-1)) * (Fs / N) * (N / N_pad); % Hz

% no padding 
figure;
hold on;
stem(f, abs(clean_signal_matlab_fft))
stem(f, abs(clean_signal_naive_dft))
title("naive compared to matlab, no padding")
xlim([420 460])

% with padding
figure;
hold on;
stem(f_padded, abs(clean_signal_matlab_fft_padded))
stem(f_padded, abs(clean_signal_naive_dft_padded))
xlim([420 460])
title("naive compared to matlab, with padding")