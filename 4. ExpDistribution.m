%Pseudo-random numbers and Distributions

function[Number] = ExpDistribution(i)
%produce float num in exponential distribution
% M=1 --> i=1

[Numbers] = RNG(1024,10,3,5);
Numbers = sortrows(Numbers);

Number = (-1)/i*log(1-Numbers);

plot(Number)

end
