function X = dit_fft(x)
    N = length(x);
    x = x(:); % Ensure x is a column vector

    % Check if N is a power of 2
    if mod(log2(N), 1) ~= 0
        N_next = 2^ceil(log2(N));
        disp("Signal length is not a power of 2. Padding with zeros to length " + N_next)
        x = [x; zeros(N_next - N, 1)];
        N = N_next; % Update N to the new length
    end
    
    % Base case: if N == 1, return the input
    if N == 1
        X = x;
        return;
    end

    % Split into even and odd elements
    even_part = dit_fft(x(1:2:end));
    odd_part = dit_fft(x(2:2:end));

    % Combine results using the butterfly operation
    X = zeros(1, N);
    for k = 1:(N/2)
        twiddle = exp(-2i * pi * (k-1) / N);
        X(k) = even_part(k) + twiddle * odd_part(k);
        X(k + N/2) = even_part(k) - twiddle * odd_part(k);
    end
end