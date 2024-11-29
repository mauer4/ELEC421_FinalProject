% Initialize an array to store execution times
Comp_times = zeros(1, 9);

% Loop through input vector sizes from 2 to 10
for N = 2:500
    % random input vector of size N
    input_vector = rand(1, N);
    
    % Measure time for DFT
    tic;
    dft_result = naive_dft(input_vector); % Call your DFT function
    Comp_times(N - 1) = toc;
end

plot(Comp_times)
xlabel("N, input vector size")
ylabel("\Delta t, execution time for given N in seconds")
title("Execution Time (\Delta t) vs Vector Size (N) for random input vectors")
