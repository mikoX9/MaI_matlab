% Non-parametric estimation of probability den-sity function
clear all;
close all;


grid = -1:0.1:1;
% Draw real function
f_lin_plus = @(x) -x+1;
f_lin_min = @(x) x+1;
real_y = [];
for x_arg = grid
    if x_arg<0
      real_y(end+1) = f_lin_min(x_arg);
    else 
      real_y(end+1) = f_lin_plus(x_arg);
    end
end
plot(grid,real_y);
hold on;
%%%%%%%%%%%%%%%


S_all = [2,5,20];

mse = [];
for S=S_all
    
    % Esitmation of a's
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

    % Calculate estimator of function
    y_final = [];
    i = 1;
    a_num = 1;
    tmp_y = 0;
    for x_arg = grid
        a_num = 1;
        tmp_y = 0;
        for a = a_est
            tmp_y = tmp_y + a*func(a_num,x_arg);
            a_num = a_num +1;
        end
        y_final(i) = tmp_y;
        i = i+1;
    end


    plot(grid,y_final);

    %MSE
    mse(end+1) = 0;
    y_tmp = 0;
    for i=1:length(grid)
        mse(end) = mse(end) + power((real_y(i)-y_final(i)), 2);
    end
    mse(end) = mse(end)/N;

end

figure
plot(S_all, mse, '*-')

