% PEAK INTER-ARRIVAL TIME TABLE
peak_inter_arrival_times = [1 2 4 7 11 12];
peak_inter_arrival_probs = [0.10 0.05 0.25 0.30 0.20 0.10];

% Calculate CDF and ranges
peak_inter_arrival_cdf = cumsum(peak_inter_arrival_probs);
peak_highs = round(peak_inter_arrival_cdf * 100);
peak_lows = [0 peak_highs(1:end-1)+1];
peak_inter_arrival_ranges = [peak_lows; peak_highs]';


disp('PEAK INTER-ARRIVAL TIME DISTRIBUTION');
disp('--------------------------------');
fprintf('| %-10s | %-11s | %-6s | %-14s |\n', 'Time (min)', 'Probability', 'CDF', 'Random Range');
for i = 1:length(peak_inter_arrival_times)
    fprintf('| %-10d | %-11.2f | %.2f | %3d - %3d |\n', ...
            peak_inter_arrival_times(i), ...
            peak_inter_arrival_probs(i), ...
            peak_inter_arrival_cdf(i), ...
            peak_inter_arrival_ranges(i,1), ...
            peak_inter_arrival_ranges(i,2));
end
disp(' ');

%NON-PEAK INTER-ARRIVAL TIME TABLE 

nonpeak_inter_arrival_times = [3 5 6 8 9 10];
nonpeak_inter_arrival_probs = [0.10 0.05 0.25 0.30 0.20 0.10];

% Calculate CDF and ranges
nonpeak_inter_arrival_cdf = cumsum(nonpeak_inter_arrival_probs);
nonpeak_highs = round(nonpeak_inter_arrival_cdf * 100);
nonpeak_lows = [0 nonpeak_highs(1:end-1)+1];
nonpeak_inter_arrival_ranges = [nonpeak_lows; nonpeak_highs]';


disp('NON-PEAK INTER-ARRIVAL TIME DISTRIBUTION');
disp('--------------------------------');
fprintf('| %-10s | %-11s | %-6s | %-14s |\n', 'Time (min)', 'Probability', 'CDF', 'Random Range');
for i = 1:length(nonpeak_inter_arrival_times)
    fprintf('| %-10d | %-11.2f | %.2f | %3d - %3d |\n', ...
            nonpeak_inter_arrival_times(i), ...
            nonpeak_inter_arrival_probs(i), ...
            nonpeak_inter_arrival_cdf(i), ...
            nonpeak_inter_arrival_ranges(i,1), ...
            nonpeak_inter_arrival_ranges(i,2));
end
disp(' ');



% PETROL TYPE TABLE
petrol_names = {'Primax 95', 'Primax 97', 'Dynamic Diesel'};
petrol_probs = [0.45 0.25 0.30];
petrol_prices = [2.05 2.55 2.15];

% Calculate CDF and ranges
petrol_cdf = cumsum(petrol_probs);
petrol_highs = round(petrol_cdf * 100);
petrol_lows = [0 petrol_highs(1:end-1)+1];
petrol_ranges = [petrol_lows; petrol_highs]';


disp('PETROL TYPE DISTRIBUTION');
disp('------------------------');
fprintf('| %-14s | %-11s | %-6s | %-14s | %-12s |\n', ...
        'Petrol Type', 'Probability', 'CDF', 'Random Range', 'Price/Liter');
for i = 1:length(petrol_names)
    fprintf('| %-14s | %-11.2f | %.2f | %3d - %3d | RM%-10.2f |\n', ...
            petrol_names{i}, ...
            petrol_probs(i), ...
            petrol_cdf(i), ...
            petrol_ranges(i,1), ...
            petrol_ranges(i,2), ...
            petrol_prices(i));
end
disp(' ');

% QUANTITY TIME TABLE 
quantity_amount = [1 2 10 20 30 40 50 60];
quantity_probs = [0.10 0.10  0.05 0.10 0.05 0.35 0.15 0.10];

% Calculate CDF and ranges
quantity_cdf = cumsum(quantity_probs);
quantity_highs = round(quantity_cdf * 100);
quantity_lows = [0 quantity_highs(1:end-1)+1];
quantity_ranges = [quantity_lows; quantity_highs]';


disp('QUANTITY DISTRIBUTION');
disp('--------------------------------');
fprintf('| %-10s | %-11s | %-6s | %-14s |\n', 'Quantity(litre)', 'Probability', 'CDF', 'Random Range');
for i = 1:length(quantity_amount)
    fprintf('| %-10d | %-11.2f | %.2f | %3d - %3d |\n', ...
            quantity_amount(i), ...
            quantity_probs(i), ...
            quantity_cdf(i), ...
            quantity_ranges(i,1), ...
            quantity_ranges(i,2));
end
disp(' ');

% REFUELING TIME TABLE 
refuel_times = [0 3 5 7 10 15];
refuel_probs = [0.05 0.20 0.35 0.25 0.10 0.05];

% Calculate CDF and ranges
refuel_cdf = cumsum(refuel_probs);
refuel_highs = round(refuel_cdf * 100);
refuel_lows = [0 refuel_highs(1:end-1)+1];
refuel_ranges = [refuel_lows; refuel_highs]';

disp('REFUELING TIME DISTRIBUTION');
disp('----------------------------');
fprintf('| %-10s | %-11s | %-6s | %-14s |\n', ...
        'Time (min)', 'Probability', 'CDF', 'Random Range');
for i = 1:length(refuel_times)
    fprintf('| %-10d | %-11.2f | %.2f | %3d - %3d |\n', ...
            refuel_times(i), ...
            refuel_probs(i), ...
            refuel_cdf(i), ...
            refuel_ranges(i,1), ...
            refuel_ranges(i,2));
end