clear all;
close all;

N = [10,50,100,500,1000,5000,10000];
R = 100;
rand_nums = [];
averages_pow2 = [];
averages = [];
sample_variances = [];
for n = N
    for r = 1:R
        for i = 1:n
            rand_nums(i) = rand()-0.5;
        end
        averages(r) = mean(rand_nums);
        averages_pow2(r) = averages(r)^2;
    end
    
    sample_variances(end+1) = 1/r * sum(averages_pow2);
    
end


figure
semilogx(N,sample_variances, '*-' );

