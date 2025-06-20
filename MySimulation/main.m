function m= Main();
    clc,clear;
    tablewithvariables;
    disp('-----------------------------------');
    disp('1.LCG random generator');
    disp('2.Exponential random generator');
    disp('3.Uniform random generator');
    input_generate=input('Select the type of generator to be used(1,2,3):  ');
    input_number=input('Number of vehicles:  ');
    switch input_generate
        case 1
            lcg_vals=lcg_random(21,43,100,input_number);
            disp('LCG values');
            disp(lcg_vals);
            % you have to generate random values for peak interval,nonpeak
            %interval time,refueling,quantity,petrol type
            %for e.g quantity=lcg_random
            % petrol type = lcg_random
            %  and so on
            % 
            
        case 2
            
             
             expo_vals=exponential_random(1/25,input_number);
             disp('Expo values');
             disp(expo_vals);
             % same as above(refer lcg)
            
                
        case 3
           uni_vals= uniform_random(input_number,0,100);
           disp('Uni values');
           disp(uni_vals);
           % same as above(refer lcg)
            
        otherwise
                error('Invalid choice selected');
    end
    
end 