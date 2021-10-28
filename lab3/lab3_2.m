clear all;
close all;

us = [];
xs = [];


N = 1000;
for i=1:N
    for j=1:12
        us(j) = rand()-0.5;
    end
    xs(i) = sum(us);
end

hist(xs)
