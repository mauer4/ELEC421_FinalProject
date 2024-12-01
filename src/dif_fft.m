% function X = dif_fft(x)
%     N = length(x);
    
%     % Step 1: Bit-reversal permutation
%     x = bit_reverse_permute(x);
    
%     % Step 2: Apply DIF-FFT
%     for stage = 1:log2(N)
%          half_N = N / 2 
%         for k = 1:sets
%             W = exp(-2*pi*1i*k/N_2);  % Twiddle factor for this stage
            
%             for n = k:2:N
%                 idx1 = n;
%                 idx2 = mod(n + half_N - 1, N) + 1;  % Wrap-around index
                
%                 % Perform the butterfly operation
%                 t = W * x(idx2);
%                 x(idx2) = x(idx1) - t;
%                 x(idx1) = x(idx1) + t;
%             end
%         end
%     end
    
%     % Step 3: Normalize by the length of the signal
%     X = x / N;
% end

% X is the return value of the function, representing the fourier transform of the signal
% x is the input for the function
function X = dif_fft(x)
    N = length(x);
    half_N = N / 2;
    
    n_stages = log2(N);

    for stage = 1: n_stages
        sets = stage^2;

        num_butterflies = half_N / sets;

        nth_root = 1:num_butterflies;

        W_n_set = exp(-1i*2*pi/N*nth_root);

        W_n_set

        for set = 1:sets

            for butterfly = 1:num_butterflies

            end

        end

    end
end

        