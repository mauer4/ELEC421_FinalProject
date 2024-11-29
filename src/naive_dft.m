function X = naive_dft(x)
    % naive_dft - Compute the Discrete Fourier Transform (DFT) of a signal
    % using the naive O(N^2) approach.
    %
    % Syntax: X = naive_dft(x)
    %
    % Input:
    %   x - Input signal (1D array)
    %
    % Output:
    %   X - DFT of the input signal (1D array, complex values)

    % Check if input is a vector
    if ~isvector(x)
        error('Input must be a vector');
    end

    % Length of the input signal
    N = length(x);
    
    % Initialize the output array with zeros (complex type)
    X = zeros(1, N);
    
    % Compute the DFT using the summation formula
    for k = 1:N
        for n = 1:N
            % Twiddle factor: W_N^(k-1)*(n-1)
            twiddle = exp(-1i * 2 * pi * (k-1) * (n-1) / N);
            % Accumulate the summation
            X(k) = X(k) + x(n) * twiddle;
        end
    end
end