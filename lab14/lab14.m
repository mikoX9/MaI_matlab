clear all;
close all;

% SIMULATION

miu_f = @(u) sin(u);

N = 1000;


hh = [0.005, 0.01, 0.02, 0.05, 0.1, 0.15, 0.2, 0.5,1]; 
delta = [];

for h=hh

    uk = [0];
    yk = [];

    true_phi = [2,1];

    for n=2:N+1

       uk(n) = 2*rand()-1;
       xk(n) = true_phi(1)*uk(n) + true_phi(2)*uk(n-1);
       vk(n) = miu_f(xk(n));
       zk = (rand()-0.5)/10;
       yk(n) = vk(n) + zk;

    end

    uk = uk(2:end);
    xk = xk(2:end);
    yk = yk(2:end);


    % build regressor of phis by LS with Kernel
    % here you get estimate of phi1 and phi2


    first_m = 0;
    second_m = 0;

    h = 0.02;
    for k=2:N
        phi = [uk(k); uk(k-1)];
        norm = power(uk(k),2) + power(uk(k-1),2);
        if norm  <= h
            first_m = first_m + (phi*phi');
            second_m = second_m + (phi*yk(k));
        end    
    end

    theta_est = mpower(first_m,-1) * second_m;


    % transfer u through estimators 

    new_xk = [];
    uk = [0, uk];
    for n=2:N+1
       new_xk(n) = theta_est(1)*uk(n) + theta_est(2)*uk(n-1);
    end
    uk = uk(2:end);
    new_xk = new_xk(2:end);

    % treat estiamtion of xk as true data
    % with data xk (estimation) and yk run kernel smoothing


    new_miu = [];
    u_kernel = [];

    H = 0.02;
    for n=1:N
        u = new_xk(n);
        u_kernel = [];
        for i=1:N
            if new_xk(i) < u+H && new_xk(i) > u-H
                u_kernel(end+1) = yk(i); 
            end      
        end
        new_miu(end+1) = sum(u_kernel)/length(u_kernel);
    end


    %plot(xk,yk,'.');
    %hold on;
    %plot(xk,new_miu,'.');

    delta(end+1) = 0;
    for n=1:N
        delta(end) = delta(end) + power( (yk(n)-new_miu(n)),2 );
    end
end


plot(hh, delta, "-*");

