clear all;
close all;

f1 = @(x) 2*sqrt(x);

a = 2;
f2 = @(x) -log(x)/a;

numbers = [];
for i=1:10000
    x = rand();
    sign = rand();
    if sign < 0.5
        numbers(i) = f2(x);
    else
        numbers(i) = -f2(x);
    end
    
    %numbers(i) = f1(x);
    
end

hist(numbers)
median = median(numbers);
mean = mean(numbers);
var = var(numbers);

median
mean
var
        