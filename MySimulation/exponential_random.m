function t = exponential_random(lambda,N)
    
    U = rand(N,1);

    
    t = -(1 / lambda) * log(1 - U);

    
    t = round(t);

    
    t = min(max(t, 0), 100);  
end

