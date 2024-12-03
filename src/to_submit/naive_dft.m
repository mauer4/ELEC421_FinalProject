function X = naive_dft(x)
    % Ensure the input is a vector
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
            W_n = exp(-2i * pi * (k-1) * (n-1) / N);
            % Accumulate the summation
            X(k) = X(k) + x(n) * W_n;
        end
    end
end