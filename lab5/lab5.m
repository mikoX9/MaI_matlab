clear all;
close all;

miu_f = @(x) floor(x*5);

N = 100;
Uk = [];
Yk = [];


for i=1:N
    u = rand()+rand()-1;
    z = 2*rand()-1; 
    %z = rand()/2-0.25;
    Yk(i) = miu_f(u) + z;
    Uk(i) = u;
end

grid = -1:0.01:1;

% real plot
real_y = [];
for u=grid
    real_y(end+1) = miu_f(u);
end
plot(grid,real_y,'.', 'MarkerSize',20);
hold on;
%%%%%

%plot(Yk,Uk,'.');
UU = [Uk;Yk];
plot(UU(1,:),UU(2,:),'.')



%%%%%%%%% KERNEL
%h = 0.05;
%H = [0.01,0.02,0.05,0.1,0.2,0.4,0.8,1,1.2,1.5,2];

H = [0.01,0.02];

mse = [];
for h=H
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


    %MSE
    mse(end+1) = 0;
    y_tmp = 0;
    for i=1:length(grid)
        if not(isnan( power((real_y(i)-new_miu(i)), 2) ))
            mse(end) = mse(end) + power((real_y(i)-new_miu(i)), 2);
        end
    end
    mse(end) = mse(end)/N;
end


%plot(H, mse, '-');

%%%%%%%%%%%%%%%%%%%%%%%



S_all = [1,2,5,8,13];

mse = [];

for S=S_all

    a_est = [];
    for s=1:S
        a_est(s) = 0;    
        for i=1:N
            a_est(s) = a_est(s) + func(s, Uk(i) );
        end
        a_est(s) = a_est(s)/N;

    end

    b_est = [];
    for s=1:S
        b_est(s) = 0;   

        for i=1:N
            b_est(s) = b_est(s) + Yk(i)*func(s, Uk(i) );
        end
        b_est(s) = b_est(s)/N;

    end





    x_final = [];
    y_final = [];
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

        y_final(end+1) = numerator/denominator;
    end
    
    
    
    %MSE
    mse(end+1) = 0;
    for i=1:length(grid)
        if not(isnan( power((real_y(i)-y_final(i)), 2) ))
            mse(end) = mse(end) + power((real_y(i)-y_final(i)), 2);
        end
    end
    mse(end) = mse(end)/N;
    
    %plot(grid,y_final,'.', 'MarkerSize',20);

end

%figure
%plot(S_all, mse, '*-');




