function number_arr =  lcg_random(a, c, m,numOfVehicles)
     current_value =randi(0,100);%generates random value between 0 to 100 for initial value
     number_arr = [];
     for i = 1:numOfVehicles
        x = mod(a * current_value + c, m);  % still generate x
        number_arr(i) = x;%stores the value of x in number_arr array
        current_value = x;% updates current value with newly generated x and uses it to generate subsequent values.
     end
     
end

    
   