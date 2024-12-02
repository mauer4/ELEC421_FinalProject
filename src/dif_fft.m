function X = two_radix_dif_fft(x)
    N = length(x);
    x = x(:); % Ensure x is a column vector
    % Check if N is a power of 2
    if mod(log2(N), 1) ~= 0
        N_next = 2^ceil(log2(N));
        disp("Signal length is not a power of 2. Padding with zeros to length " + N_next)
        x = [x; zeros(N_next - N, 1)];
        N = N_next; % Update N to the new length
    end
    n_stages = log2(N);
    W_N = exp(-2i * pi * (0:N/2 - 1)' / N);
% Main loop: stages
    for s = n_stages:-1:1
        num_sections = 2^(n_stages - s);
        signal_size = 2^s;
        half_size = signal_size / 2;
        % Calculate twiddle factor indices for this stage
        indices = (0:(half_size - 1)) * num_sections + 1; % MATLAB indexing starts at 1
        W = W_N(indices);
        % Loop over each section
        for section = 0:(num_sections - 1)
            offset = section * signal_size;
            idx = offset + (1:half_size);
            idx_pair = idx + half_size;
            % Perform butterfly operations
            a = x(idx);
            b = x(idx_pair);
            % Compute butterflies
            x(idx) = a + b;
            x(idx_pair) = (a - b) .* W;
        end
    end
    % Bit-reversal permutation
    X = bitrevorder(x);
end