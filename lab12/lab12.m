% HAMMERSTEIN SYSTEM
clear all;
close all;
%%%%%%%%% SIMULATION

c = [1;2];
f1 = @(u) c(1)*power(u,2);
f2 = @(u) c(2)*u;
miu_f = @(u) f1(u) + f2(u);



NN = [100,1000,10000];
deltas = [];

for N=NN

    Yk = [];
    true_Yk = [];
    Uk = [];
    Wk = [0,0];


    gamma = [3;2;1];
    for i=3:N+3
        u = 10*rand()-5;
        Wk(i) = miu_f(u);
        Uk(i) = u;
        z = rand() - 0.5;
        true_Yk(i) = gamma(1)*Wk(i) + gamma(2)*Wk(i-1) + gamma(3)*Wk(i-2);
        Yk(i) = gamma(1)*Wk(i) + gamma(2)*Wk(i-1) + gamma(3)*Wk(i-2) + z;

    end

    Yk = Yk(4:end);
    true_Yk = true_Yk(4:end);
    %Uk = Uk(4:end);


    %%%%%%%%% IDENTIFICATION

    phi = [];
    for i=3:N+2
        phi = [phi; power(Uk(i+1),2),Uk(i+1) , power(Uk(i),2),Uk(i),  power(Uk(i-1),2), Uk(i-1) ];
    end


    THETA_est = mpower((phi'*phi),-1)*phi'*Yk';
    True_THETA = mpower((phi'*phi),-1)*phi'*true_Yk';

    %%%%%%%%% DECOMPOSITION

    True_M = [ True_THETA(1:2), True_THETA(3:4), True_THETA(5:6)];
    M = [ THETA_est(1:2), THETA_est(3:4), THETA_est(5:6)];

    [P,D,Q] = svd(M);
    scale = P(1,1)-P(1,2);


    c_est = P(1,:)/scale;
    gamma_est = D(1,1)*Q(:,1)*scale;

    M_est = c_est' * gamma_est';

    %%%% REPORT

    sum = 0;
    for i=1:6
        sum = sum + power(True_M(i)-M_est(i),2);
    end
    deltas(end+1) = sqrt(sum);

end

deltas