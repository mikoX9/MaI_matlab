clear all;
close all;

S = 2;
a_est = [];
N = 100;
x = [];

for s=1:S
    a_est(s) = 0;    
    for i=1:N
        x(i) = rand()+rand()-1;
        a_est(s) = a_est(s) + func(s,x(i));
    end
    a_est(s) = a_est(s)/N;
    
end


grid = -1:0.01:1;
y = [];
for x_arg = grid
    y(end+1) = func_final(a_est,x_arg);
end 

%plot(grid,y);


   
   