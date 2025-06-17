% Simulation parameters
lambda = 1/3; % Mean inter-arrival time (per minute)
mu = 5;       % Mean refueling time (minutes)
sigma = 1;    % Standard deviation of refueling time
numVehicles = 100; % Total number of vehicles to simulate

% Columns:
% 1: Vehicle ID
% 2: Petrol Type
% 3: Refueling Time
% 4: Quantity (to be filled later)
% 5: Price (to be filled later)
% 6: Inter-arrival Time
% 7: Arrival Time
% 8: Assigned Lane
% 9: Assigned Pump
% 10: Service Start Time
% 11: Service End Time

vehicleData = cell(numVehicles, 11); % Use cell array to store mixed data types

% Set column headers
vehicleData(1, :) = {'ID', 'Petrol', 'Quantity', 'Price', 'Inter-arrival', ...
                     'Arrival', 'Line', 'Pump', 'Start', 'End', 'Waiting Time'};
                     
% Track cumulative arrival time
cumulativeTime = 0;

% Simulate vehicle arrivals
for i = 2:numVehicles  % First row is header, start filling from second row
    % Generate inter-arrival time
    interArrival = generateInterArrivalTime(lambda);
    cumulativeTime = cumulativeTime + interArrival;
    
    % Generate petrol type
    petrolType = generatePetrolType();
    
    % Generate refueling time
    refuelingTime = generateRefuelingTime(mu, sigma);
    
    % Update vehicle data (use {} for assignment in cell arrays)
    vehicleData{i, 1} = i - 1;              % ID
    vehicleData{i, 2} = petrolType;          % Petrol Type
    vehicleData{i, 3} = [];                  % Quantity (can be left empty or randomly generated)
    vehicleData{i, 4} = [];                  % Price
    vehicleData{i, 5} = interArrival;        % Inter-arrival time
    vehicleData{i, 6} = cumulativeTime;      % Arrival time
    vehicleData{i, 7} = [];                  % Assigned Line
    vehicleData{i, 8} = [];                  % Assigned Pump
    vehicleData{i, 9} = [];                  % Start time
    vehicleData{i, 10} = [];                 % End time
    vehicleData{i, 11} = [];                 % Waiting time
end

% Display results
for i = 1:5
    for j = 1:size(vehicleData, 2)
        printf('%12s ', char(vehicleData{i,j}));
    end
    printf('\n');
end