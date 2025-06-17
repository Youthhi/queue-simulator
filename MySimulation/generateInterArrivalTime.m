function interArrivalTime = generateInterArrivalTime(lambda)
    U = rand(); % Generate a random number between 0 and 1
    interArrivalTime = -(1/lambda) * log(1 - U); % Inverse transform
end