function Main()
    clc;
    clear;
    tablewithvariables;

    disp('-----------------------------------');
    disp('1. LCG random generator');
    disp('2. Exponential random generator');
    disp('3. Uniform random generator');
    input_generate = input('Select the type of generator to be used (1, 2, 3):  ');
    input_number = input('Number of vehicles:  ');
    is_peak = input('Peak hour? (1 = Yes, 0 = No): ');

    % Generate base random values for each attribute
    switch input_generate
        case 1
            rand_interarrival = lcg_random(21, 43, 100, input_number);
            rand_petrol = lcg_random(23, 47, 100, input_number);
            rand_quantity = lcg_random(29, 51, 100, input_number);
            rand_refuel = lcg_random(31, 59, 100, input_number);
        case 2
            rand_interarrival = floor(exponential_random(1/25, input_number));
            rand_petrol = floor(exponential_random(1/25, input_number));
            rand_quantity = floor(exponential_random(1/25, input_number));
            rand_refuel = floor(exponential_random(1/25, input_number));
        case 3
            rand_interarrival = uniform_random(input_number, 0, 100);
            rand_petrol = uniform_random(input_number, 0, 100);
            rand_quantity = uniform_random(input_number, 0, 100);
            rand_refuel = uniform_random(input_number, 0, 100);
        otherwise
            error('Invalid choice selected');
    end

    fprintf('Inter-arrival random values: '); fprintf('%d ', rand_interarrival); fprintf('\n');
    fprintf('Petrol type random values: '); fprintf('%d ', rand_petrol); fprintf('\n');
    fprintf('Quantity random values: '); fprintf('%d ', rand_quantity); fprintf('\n');
    fprintf('Refuel time random values: '); fprintf('%d ', rand_refuel); fprintf('\n');

    simulate_scenario(rand_interarrival, rand_petrol, rand_quantity, rand_refuel, input_number, is_peak);
end

function simulate_scenario(rand_interarrival, rand_petrol, rand_quantity, rand_refuel, input_number, is_peak)
    if is_peak
        disp('========== PEAK HOUR SIMULATION ==========');
    else
        disp('======== NON-PEAK HOUR SIMULATION ========');
    end

    global peak_inter_arrival_ranges peak_inter_arrival_times
    global nonpeak_inter_arrival_ranges nonpeak_inter_arrival_times
    global petrol_ranges petrol_names petrol_prices
    global quantity_ranges quantity_amount
    global refuel_ranges refuel_times

    if is_peak
        inter_arrival_times = assign_from_table(rand_interarrival, peak_inter_arrival_ranges, peak_inter_arrival_times);
    else
        inter_arrival_times = assign_from_table(rand_interarrival, nonpeak_inter_arrival_ranges, nonpeak_inter_arrival_times);
    end

    arrival_time = zeros(1, input_number);
    arrival_time(1) = inter_arrival_times(1);
    for i = 2:input_number
        arrival_time(i) = arrival_time(i-1) + inter_arrival_times(i);
    end

    pump_free_time = zeros(1, 4);
    pump_tables = cell(4, 1);
    for i = 1:4
        pump_tables{i} = {};
    end

    vehicle_table = cell(input_number, 11);
    waiting_times = zeros(1, input_number);
    waited_flags = zeros(1, input_number);
    refuel_times_used = zeros(1, input_number);

    for i = 1:input_number
        petrol_type = assign_from_table_single(rand_petrol(i), petrol_ranges, petrol_names);
        quantity = assign_from_table_single(rand_quantity(i), quantity_ranges, quantity_amount);
        refuel_time = assign_from_table_single(rand_refuel(i), refuel_ranges, refuel_times);
        refuel_times_used(i) = refuel_time;

        lane1_pumps = [1, 2];
        lane2_pumps = [3, 4];

        lane1_occupied = sum(pump_free_time(lane1_pumps) > arrival_time(i));
        lane2_occupied = sum(pump_free_time(lane2_pumps) > arrival_time(i));

        if lane1_occupied < 2
            lane = 1; lane_pumps = lane1_pumps;
        elseif lane2_occupied < 2
            lane = 2; lane_pumps = lane2_pumps;
        else
            if min(pump_free_time(lane1_pumps)) <= min(pump_free_time(lane2_pumps))
                lane = 1; lane_pumps = lane1_pumps;
            else
                lane = 2; lane_pumps = lane2_pumps;
            end
        end

        best_start = inf;
        assigned_pump = lane_pumps(1);
        for j = 1:length(lane_pumps)
            pump = lane_pumps(j);
            start_time = max(pump_free_time(pump), arrival_time(i));
            if start_time < best_start
                best_start = start_time;
                assigned_pump = pump;
            end
        end

        start_time = best_start;
        waiting_time = start_time - arrival_time(i);
        end_time = start_time + refuel_time;
        pump_free_time(assigned_pump) = end_time;

        waited_flags(i) = waiting_time > 0;
        waiting_times(i) = waiting_time;

        price_index = find(strcmp(petrol_names, petrol_type));
        price = quantity * petrol_prices(price_index);

        vehicle_table{i, 1} = i;
        vehicle_table{i, 2} = petrol_type;
        vehicle_table{i, 3} = quantity;
        vehicle_table{i, 4} = price;
        vehicle_table{i, 5} = rand_interarrival(i);
        vehicle_table{i, 6} = inter_arrival_times(i);
        vehicle_table{i, 7} = arrival_time(i);
        vehicle_table{i, 8} = lane;
        vehicle_table{i, 9} = assigned_pump;

        row = {i, arrival_time(i), refuel_time, start_time, end_time, waiting_time, refuel_time + waiting_time};
        pump_tables{assigned_pump}(end+1, :) = row;

        fprintf('Vehicle %d arrived at minute %.0f and began refueling with %s at Pump Island %s.\n', ...
            i, arrival_time(i), petrol_type, char(64 + assigned_pump));
        fprintf('Vehicle %d finished refueling and departed at minute %.0f.\n', i, end_time);
    end

    fprintf('\n--- VEHICLE DETAILS TABLE ---\n');
    fprintf('| %-8s | %-20s | %-15s | %-13s | %-22s | %-18s | %-13s | %-6s | %-6s |\n', ...
        'Vehicle', 'Type of Petrol', 'Quantity (Litre)', 'Total Price', 'Rand Num for Interarrival', 'Interarrival Time', 'Arrival Time', 'Lane', 'Pump');
    fprintf('%s\n', repmat('-', 1, 150));
    for i = 1:input_number
        fprintf('| %-8d | %-20s | %-15d | %-13.2f | %-22d | %-18d | %-13d | %-6d | %-6s |\n', ...
            vehicle_table{i,1}, vehicle_table{i,2}, vehicle_table{i,3}, vehicle_table{i,4}, ...
            vehicle_table{i,5}, vehicle_table{i,6}, vehicle_table{i,7}, vehicle_table{i,8}, char(64 + vehicle_table{i,9}));
    end

    for p = 1:4
        fprintf('\n--- PUMP %s DETAILS ---\n', char(64 + p));
        fprintf('| %-8s | %-13s | %-16s | %-12s | %-10s | %-13s | %-12s |\n', ...
            'Vehicle', 'Arrival', 'Refuel Time', 'Start Time', 'End Time', 'Waiting Time', 'Time Spent');
        fprintf('%s\n', repmat('-', 1, 100));
        entries = pump_tables{p};
        for r = 1:size(entries, 1)
            row = entries(r, :);
            if numel(row) == 7
                fprintf('| %-8d | %-13.2f | %-16.2f | %-12.2f | %-10.2f | %-13.2f | %-12.2f |\n', row{:});
            end
        end
    end

    fprintf('\n--- PERFORMANCE METRICS ---\n');
    fprintf('Average waiting time: %.2f minutes\n', mean(waiting_times));
    fprintf('Average time in system: %.2f minutes\n', mean(refuel_times_used + waiting_times));
    fprintf('%% of customers who waited: %.2f%%\n', 100 * sum(waited_flags) / input_number);
    fprintf('Average service time (refuel only): %.2f minutes\n', mean(refuel_times_used));
end

function values_out = assign_from_table(rand_array, ranges, values)
    n = length(rand_array);
    values_out = zeros(1, n);
    for i = 1:n
        values_out(i) = assign_from_table_single(rand_array(i), ranges, values);
    end
end

function value = assign_from_table_single(rand_num, ranges, values)
    rand_num = min(max(floor(rand_num), 0), 100);
    if isempty(ranges) || isempty(values)
        error('assign_from_table_single: ranges or values are empty!');
    end
    for j = 1:size(ranges, 1)
        if rand_num >= ranges(j, 1) && rand_num <= ranges(j, 2)
            if iscell(values)
                value = values{j};
            else
                value = values(j);
            end
            return;
        end
    end
    if iscell(values)
        value = values{end};
    else
        value = values(end);
    end
end
