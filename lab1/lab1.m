clear all;
close all;


f0 = @(x) 2*x+6;
f1 = @(x) 2*sqrt(x);

a = 2;
f2 = @(x) -log(x)/a;

numbers = [];
u_nums = [];
for i=1:1000
    u = rand();
    u_nums(i) = u;
    
    numbers(i) = f1(u);
     
%     sign = rand();
%     if sign < 0.5
%         numbers(i) = f2(u);
%     else
%         numbers(i) = -f2(u);
%     end
%     
   %numbers(i) = f1(u);
    
end


% figure
% plot(numbers, u_nums, "*");
figure
hist(numbers,10)

median = median(numbers);
mean = mean(numbers);
var = var(numbers);

median
mean
var
        