function X = dif_fft(x)
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
    W_n = exp(-2i * pi * (0:N/2 - 1)' / N); % Twiddle factor: W_N^(k-1)*(n-1)

% Main loop: stages
    for s = n_stages:-1:1 % Start at n_stages and decrements by 1 until we reach 1
        % Every stage (out of logN) has a certain number of sub-signals
        num_subsignals = 2^(n_stages - s);
        % Sub-signal size depends on the stage (out of logN)
        signal_size = 2^s;
        half_size = signal_size / 2;
        % Calculate twiddle factor indices for this stage
        indices = (0:(half_size - 1)) * num_subsignals + 1; % MATLAB indexing starts at 1
        W = W_n(indices);
        
        % Loop over each section
        for section = 0:(num_subsignals - 1)
            offset = section * signal_size;
            idx = offset + (1:half_size);
            idx_pair = idx + half_size;
            % Perform butterfly operations
<<<<<<< HEAD
            bottom_hard = x(idx);
=======
            bottom_half = x(idx);
>>>>>>> c450798fd5fb1a6f234b428ab678153bbda32ad6
            top_half = x(idx_pair);
            % Compute butterflies
            x(idx) = bottom_half + top_half;
            x(idx_pair) = (bottom_half - top_half) .* W;
        end
    end

    % Bit-reversal permutation
    X = bitrevorder(x);
end