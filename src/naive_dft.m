function X = naive_dft(x)
    % Check if input is a vector
    if ~isvector(x)
        error('Input must be a vector');
    end
    
    
    N = length(x);
    
    % Make all elements of X for efficiency
    X = zeros(size(x));
    
    % Compute X[k] = Sum{x[n]*exp(-j*2*pi*(k-1)*n/N))} for k = 1,2,...,N
    for k = 1:N
        for n = 1:N
            X(k) = X(k) + x(n)*exp(-1i*2*pi*(k-1)*(n-1)/N);
        end
    end
end