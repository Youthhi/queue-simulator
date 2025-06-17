function petrolType = generatePetrolType()
    U = rand(); % Generate a random number between 0 and 1
    if U < 0.4
        petrolType = 'Primax95';
    elseif U < 0.7
        petrolType = 'Primax97';
    else
        petrolType = 'Dynamic Diesel';
    end
end