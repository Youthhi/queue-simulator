%function refuelingTime = generateRefuelingTime(mu, sigma)
% GENERATEREFUELINGTIME returns a refueling time that follows a normal distribution
   % refuelingTime = normrnd(mu, sigma); 
%end

function refuelingTime = generateRefuelingTime(mu, sigma)
    % Generate uniform random number
    U = rand();
    
    % Convert to standard normal using inverseNormalCDF
    z = inverseNormalCDF(U);
    
    % Scale to desired mean and standard deviation
    refuelingTime = mu + sigma * z;
end