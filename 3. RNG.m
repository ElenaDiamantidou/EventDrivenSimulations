%Pseudo-random numbers and Distributions

%--------  RNG(1024,10,3,5)  ---------

%linear coincident generators method
function[numbers] = RNG(m,seed,a,c)
%m : numbers - 1024
%a : multiplier - odd
%c : increase factor

numbers = [seed];
for i=1:m
          numbers(end+1) = mod(a*numbers(end)+c,m);
end

numbers(1) = [];
numbers = numbers/m;

plot(numbers)
mean(numbers)

end
