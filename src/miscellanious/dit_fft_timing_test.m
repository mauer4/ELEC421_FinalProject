%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Verify time complexity of dit, and naive dft %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create vector for different lengths of 2^8 to 2^20
lengths = 2.^(5:14);
num_tests = length(lengths);

% Create output vector for the times and frequency for sinusoids
dft_time = zeros(1, num_tests);
dit_fft_time = zeros(1, num_tests);
dif_fft_time = zeros(1, num_tests);
sinusoid_frequency = 200;
sampling_frequency = 1000;

% for each size test the time it takes for the functions to run
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
end

disp("Lengths size: " + size(lengths));
disp("Naive DFT time size: " + size(naive_dft_time));
disp("DIF FFT time size: " + size(dif_fft_time));
disp("DIT FFT time size: " + size(dit_fft_time));


% Plot signal length vs time
figure;
% loglog(lengths, naive_dft_time, lengths, dif_fft_time, lengths, dit_fft_time, "--");
loglog(lengths, naive_dft_time, 'o-', ...  % Naive DFT
       lengths, dif_fft_time, 's--', ...   % DIF FFT
       lengths, dit_fft_time, 'd-.');     % DIT FFT


% Update x-axis to log base 2
set(gca, 'XScale', 'log', 'YScale', 'log'); % Use log scale
xticks(lengths); % Tick marks only at powers of 2
xticklabels("2^{"+log2(lengths)+"}"); % Label ticks as log2(lengths)

xlabel("Signal Input Size (Log Base 2)");
ylabel("Execution Time (s)");
legend("Naive DFT", "DIF_FFT", "DIT_FFT");
title("Time comparison for Naive DFT vs DIF FFT vs DIT FFT");
grid on;
% Add grid lines to improve readability
grid minor;