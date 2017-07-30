%Pseudo-random numbers and Distributions

function[Poisson_Number] = PoissonDistribution(i)
%produce a float num with Poisson Distribution
%Knuth Algorithm
%M=1 --> i=1

L = exp(i);
k=0;
Poisson_Number=1;

while Poisson_Number > L
          k=k+1;
          [Numbers] = RNG(1024,10,3,5);
          Numbers = floor(Numbers);
          Poisson_Number = Poisson_Number*Numbers;
end

plot(Poisson_Number)

end
