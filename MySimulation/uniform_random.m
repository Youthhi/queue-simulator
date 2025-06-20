function X = uniform_rvg_floor(N, a, b)
    % uniform_rvg_floor - Uniform Distribution Random Variate Generator
    % with FLOOR applied to R values — produces integer X values
    %
    % Formula: X_i = a + (b - a) * R_i
    % Then: X_i = floor(X_i)
    %
    % Inputs:
    %    N = number of random variates to generate
    %    a = lower bound
    %    b = upper bound
    %
    % Output:
    %    X = vector of N floored uniform random variates (integers)
    
    % Step 1: Generate R_i ? [0,1)
    R = rand(N, 1);
    
    % Step 2: Apply formula
    X_real = a + (b - a) * R;
    
    % Step 3: Floor X_i
    X = floor(X_real);
end