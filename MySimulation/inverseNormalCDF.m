function y = inverseNormalCDF(p)
    % Approximation of inverse CDF of standard normal distribution
    % Using rational approximation from Peter J. Acklam's algorithm

    if p <= 0 || p >= 1
        error('Input must be between 0 and 1');
    end

    % Coefficients for the approximation
    a1 = -3.969683028665376e+01;
    a2 =  2.209460984245205e+02;
    a3 = -2.759289107478457e+02;
    a4 =  1.383577518518672e+02;
    a5 = -3.066479806614716e+01;
    a6 =  2.506628277459239e+00;

    b1 = -5.447609879803279e+01;
    b2 =  1.615858368580411e+02;
    b3 = -1.556989454625599e+02;
    b4 =  6.680131188771972e+01;
    b5 = -1.328068155288572e+01;

    c1 = -7.784894002430293e-03;
    c2 = -3.223964580411365e-01;
    c3 = -2.400758277161838e+00;
    c4 = -2.549732539343734e+00;
    c5 =  4.374664141464968e+00;
    c6 =  2.938163982696824e+00;

    d1 =  7.784695709041462e-03;
    d2 =  3.224671290700398e-01;
    d3 =  2.445134137142996e+00;
    d4 =  3.754408661907416e+00;

    % Define break points
    p_low  = 0.02425;
    p_high = 1 - p_low;

    if p < p_low
        % Rational approximation for lower region
        q = sqrt(-2*log(p));
        y = (((((c1*q + c2)*q + c3)*q + c4)*q + c5)*q + c6) / ((((d1*q + d2)*q + d3)*q + d4)*q + 1);
    elseif p <= p_high
        % Rational approximation for central region
        q = p - 0.5;
        r = q*q;
        y = (((((a1*r + a2)*r + a3)*r + a4)*r + a5)*r + a6)*q /(((((b1*r + b2)*r + b3)*r + b4)*r + b5)*r + 1);
    else
        % Rational approximation for upper region
        q = sqrt(-2*log(1 - p));
        y = -(((((c1*q + c2)*q + c3)*q + c4)*q + c5)*q + c6) / ((((d1*q + d2)*q + d3)*q + d4)*q + 1);
    end
end