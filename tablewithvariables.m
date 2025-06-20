% INTER-ARRIVAL TIME TABLE
inter_arrival_times = [1 2 4 7 12];
inter_arrival_probs = [0.15 0.25 0.30 0.20 0.10];

% Calculate CDF and ranges
inter_arrival_cdf = cumsum(inter_arrival_probs);
inter_arrival_ranges = [0, inter_arrival_cdf(1:end-1); inter_arrival_cdf]';

disp('INTER-ARRIVAL TIME DISTRIBUTION');
disp('--------------------------------');
fprintf('| %-10s | %-11s | %-6s | %-14s |\n', 'Time (min)', 'Probability', 'CDF', 'Random Range');
for i = 1:length(inter_arrival_times)
    fprintf('| %-10d | %-11.2f | %-6.2f | %-5.3f - %-5.3f |\n', ...
            inter_arrival_times(i), ...
            inter_arrival_probs(i), ...
            inter_arrival_cdf(i), ...
            inter_arrival_ranges(i,1), ...
            inter_arrival_ranges(i,2));
end
disp(' ');

% PETROL TYPE TABLE
petrol_names = {'Primax 95', 'Primax 97', 'Dynamic Diesel'};
petrol_probs = [0.45 0.25 0.30];
petrol_prices = [2.05 2.55 2.15];

% Calculate CDF and ranges
petrol_cdf = cumsum(petrol_probs);
petrol_ranges = [0, petrol_cdf(1:end-1); petrol_cdf]';

disp('PETROL TYPE DISTRIBUTION');
disp('------------------------');
fprintf('| %-14s | %-11s | %-6s | %-14s | %-12s |\n', ...
        'Petrol Type', 'Probability', 'CDF', 'Random Range', 'Price/Liter');
for i = 1:length(petrol_names)
    fprintf('| %-14s | %-11.2f | %-6.2f | %-5.3f - %-5.3f | RM%-10.2f |\n', ...
            petrol_names{i}, ...
            petrol_probs(i), ...
            petrol_cdf(i), ...
            petrol_ranges(i,1), ...
            petrol_ranges(i,2), ...
            petrol_prices(i));
end
disp(' ');

% REFUELING TIME TABLE 
refuel_times = [0 3 5 7 10 15];
refuel_probs = [0.05 0.20 0.35 0.25 0.10 0.05];

% Calculate CDF and ranges
refuel_cdf = cumsum(refuel_probs);
refuel_ranges = [0, refuel_cdf(1:end-1); refuel_cdf]';

disp('REFUELING TIME DISTRIBUTION');
disp('----------------------------');
fprintf('| %-10s | %-11s | %-6s | %-14s |\n', ...
        'Time (min)', 'Probability', 'CDF', 'Random Range');
for i = 1:length(refuel_times)
    fprintf('| %-10d | %-11.2f | %-6.2f | %-5.3f - %-5.3f |\n', ...
            refuel_times(i), ...
            refuel_probs(i), ...
            refuel_cdf(i), ...
            refuel_ranges(i,1), ...
            refuel_ranges(i,2));
end