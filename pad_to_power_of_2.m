function x_padded = pad_to_power_of_2(x)
    % pad_to_power_of_2 - Pads the input signal to the next power of 2 in length.
    %
    % Input:
    %   x - Input signal (1D array)
    %
    % Output:
    %   x_padded - Zero-padded signal with length as a power of 2

    N = 2^nextpow2(length(x)); % Compute the next power of 2
    x_padded = [x, zeros(1, N - length(x))]; % Zero-pad to length N
end
