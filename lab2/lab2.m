clear all;
close all;

a = 1;
f2 = @(x) -log(x)/a;

g = @(x) 0.5*exp(-abs(x));
f = @(x) (1/sqrt(2*pi))*exp(-(x^2)/2);

numbers = [];
u_nums = [];

c = 1.3;

for i=1:1000
    u = rand();
    sign = rand();
    if sign < 0.5
        x = f2(u);
    else
        x = -f2(u);
    end
    u_rand = rand();
    if c*g(x)*u_rand < f(x)
        u_nums(end+1) = u;
        numbers(end+1) = x;
    end
end

figure
plot(numbers, u_nums, ".");
% figure
% plot(all_numbers, all_u_nums, ".");

figure
hist(numbers,100)

median = median(numbers);
mean = mean(numbers);
var = var(numbers);

median
mean
var
        