function x_padded = pad_to_power_of_2(x)
    N = 2^nextpow2(length(x)); % Compute the next power of 2
    x_padded = [x, zeros(1, N - length(x))]; % Zero-pad to length N
end
