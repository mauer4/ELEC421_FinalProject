function X = dif_fft(x)
    N = length(x);
    
    % Step 1: Bit-reversal permutation
    x = bit_reverse_permute(x);
    
    % Step 2: Apply DIF-FFT
    for stage = 1:log2(N)
        N_2 = 2^stage;  % Size of the current subproblem
        half_N = N_2 / 2;

        for k = 1:half_N
            W = exp(-2*pi*1i*k/N_2);  % Twiddle factor for this stage
            
            for n = k:2:N
                idx1 = n;
                idx2 = mod(n + half_N - 1, N) + 1;  % Wrap-around index
                
                % Perform the butterfly operation
                t = W * x(idx2);
                x(idx2) = x(idx1) - t;
                x(idx1) = x(idx1) + t;
            end
        end
    end
    
    % Step 3: Normalize by the length of the signal
    X = x / N;
end
