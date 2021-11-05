clear all;
close all;

miu_f = @(x) floor(x*5);

N = 100;
Uk = [];
Xk = [];
real_y = [];

for i=1:N
    u = rand()+rand()-1;
    %z = 2*rand()-1;
    z = rand()/2-0.25;
    Uk(i) = miu_f(u) + z;
    real_y(i) = miu_f(u);
    Xk(i) = u;
end

% real plot
plot(Xk,real_y,'.');
hold on;
%%%%%

%plot(Yk,Uk,'.');
UU = [Xk;Uk];
%plot(UU(1,:),UU(2,:),'.')


grid = -1:0.01:1;

%%%%%%%%% KERNEL
h = 0.05;

new_miu = [];
u_kernel = [];
for u=grid
    u_kernel = [];
    for i=1:N
        if UU(1,i) < u+h & UU(1,i) > u-h
            u_kernel(end+1) = UU(2,i); 
        end      
    end
    new_miu(end+1) = sum(u_kernel)/length(u_kernel);
end


plot(grid,new_miu,'.');


%%%%%%%%%%%%%%%%%%%%%%%
S = 5;

a_est = [];
for s=1:S
    a_est(s) = 0;    
    for i=1:N
        a_est(s) = a_est(s) + func(s, Xk(i) );
    end
    a_est(s) = a_est(s)/N;
    
end

b_est = [];
for s=1:S
    b_est(s) = 0;   
    
    for i=1:N
        b_est(s) = b_est(s) + Uk(i)*func(s, Xk(i) );
    end
    b_est(s) = b_est(s)/N;
    
end





x_final = [];
y_final = [];
i = 1;
a_num = 1;
b_num = 1;
tmp_y = 0;
numerator = 0;
denominator= 0;
for x_arg = grid
    
    b_num = 1;
    numerator = 0;
    for b = b_est
        numerator = numerator + b*func(b_num,x_arg);
        b_num = b_num +1;
    end
    
    a_num = 1;
    denominator = 0;
    for a = a_est
        denominator = denominator + a*func(a_num,x_arg);
        a_num = a_num +1;
    end
    
    y_final(i) = numerator/denominator;
    i = i+1;
end


plot(grid,y_final,'.');








