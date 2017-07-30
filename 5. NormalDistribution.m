%Pseudo-random numbers and Distributions

%----- Normal(0,0.1)------------------

function[Normal_Number] = NormalDistribution(mi,s)
%produce float num in Normal Distribution

[Numbers] = RNG(1024,10,3,5);
Numbers = sortrows(Numbers);

%NORMPDF : Normal probability density function
Normal_Number = normpdf(Numbers,mi,s);
plot(Normal_Number)
end
