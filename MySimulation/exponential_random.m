function t = exponential_random(lambda)
    % exponential_random Generates an exponential inter-arrival time
    %   rounded to nearest minute, with a minimum value of 2 minutes.
    %
    %   Usage:
    %       t = generateInterArrivalTime(lambda)
    %
    %   Inputs:
    %       lambda - arrival rate (vehicles per minute)
    %
    %   Output:
    %       t - inter-arrival time (rounded integer, at least 2)

    % Step 1: Generate uniform random number
    U = rand();

    % Step 2: Compute exponential inter-arrival time
    t = -(1 / lambda) * log(1 - U);

    % Step 3: Round to nearest minute
    t = round(t);

    % Step 4: Ensure minimum time of 2 minutes
    t = max(t, 2);
    t = min(t, 100);
end

%numVehiclesWaiting = sum(waitingTimes > 0);
%totalVehicles = length(waitingTimes);

%probWaiting = numVehiclesWaiting / totalVehicles;

% Display result
%disp(['Probability of Waiting: ', num2str(probWaiting * 100), '%']);