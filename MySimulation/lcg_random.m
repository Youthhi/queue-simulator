function number_arr =  lcg_random(a, c, m,numOfVehicles)
     current_value =randi(10,100);
     number_arr = [];
     for i = 1:numOfVehicles
        x = mod(a * current_value + c, m);  % still generate x
        number_arr(i) = x;
        current_value = x;
     end
     
end

    
   