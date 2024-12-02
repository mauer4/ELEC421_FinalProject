%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verify time complexity of dit, and naive dft %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create vector for different lengths of 2^8 to 2^20
lengths = 2.^(5:12);
size = length(lengths);

% Create output vector for the times and frequency for sinusoids
dft_time = zeros(1, size);
dit_fft_time = zeros(1, size);
dif_fft_time = zeros(1, size);
sinusoid_frequency = 200;
sampling_frequency = 1000;

% for each size test the time it takes for the functions to run
for i = 1:size
    current_length = length(lengths);
    time = (0:current_length-1) / sampling_frequency;
    sinusoid_signal = sin(2*pi*sinusoid_frequency*time);

    % start time for naive_dft
    tic;
    naive_dft(sinusoid_signal);
    naive_dft_time(i) = toc;

    % start time for dit_fft
    % tic;
    % dit_fft(sinusoid_signal);
    % dit_fft_time(i) = toc;

    % start time for dit_fft
    tic;
    dif_fft(sinusoid_signal);
    dif_fft_time(i) = toc;

end

% plot signal length vs time
figure;
loglog(lengths, naive_dft_time, lengths, dif_fft_time, "--")
xlabel("Signal Input Size")
ylabel("Execution Time (s)")
legend("Naive DFT", "DIF_FFT")
title("Time comparison for Naive DFT vs DIF")
grid on;