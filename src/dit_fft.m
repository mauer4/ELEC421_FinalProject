function X = dit_fft(x)
    % dit_fft - Compute the FFT using the Decimation-in-Time (DIT) algorithm.
    %
    % Syntax: X = dit_fft(x)
    %
    % Input:
    %   x - Input signal (length must be a power of 2)
    %
    % Output:
    %   X - FFT of the input signal

    N = length(x);
    
    % Base case: if N == 1, return the input
    if N == 1
        X = x;
        return;
    end

    % Ensure input length is a power of 2
    if mod(N, 2) ~= 0
        error('Input length must be a power of 2.');
    end

    % Split into even and odd indexed elements
    even_part = dit_fft(x(1:2:end));
    odd_part = dit_fft(x(2:2:end));

    % Combine results using the butterfly operation
    X = zeros(1, N);
    for k = 1:(N/2)
        twiddle = exp(-1i * 2 * pi * (k-1) / N);
        X(k) = even_part(k) + twiddle * odd_part(k);
        X(k + N/2) = even_part(k) - twiddle * odd_part(k);
    end
end