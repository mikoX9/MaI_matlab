clear all;
close all;


N = 100;
y = [1];
u = [0];
real_gamma = [1];

for i=2:N+1
    u(i) = randn();
    z = 0;
    y(i) = 0.9*y(i-1) + u(i) +  z;
    real_gamma(i) = 0.9*real_gamma(i-1);
end

real_gamma = real_gamma(2:end);

u = u(2:end);
y = y(2:end);

%plot(y);



%SS = [1,2,5,10,20];
SS = [1,2,5,10,20,40];

deltas = [];

for S = SS
    
    % claculate gammas
    gamma = [];
    for t=1:S 
        sum = 0;
        for n=1:N-t
            sum = sum + u(n)*y(n+t);
        end
        gamma(t) = 1/(N-t) * sum;
    end

    %plot(gamma);


    % cumpute model
    y_est = [];
    for k=2:N
        sum = 0;
        for i=0:S-1
            sum = sum + gamma(i+1)*u(k-1);
        end
        y_est(k) = sum;

    end

% 
% % 
%     plot(y);
%     hold on;
%     plot(y_est);
%     legend("real", "estimation'");
    


    % use new data to system to check
    % generate test data
    
    y_test = [1];
    u = [0];
    for i=2:N+1 
        u(i) = randn();
        z = 0;
        y_test(i) = 0.9*y_test(i-1) + u(i-1) +  z;
    end

    y_test = y_test(2:end);

    sum = 0;
    for n=1:N
        sum = sum + (y_test(n)-y_est(n));
    end

    deltas(end+1) = 1/N * sum;
    
end

plot(SS,deltas);


