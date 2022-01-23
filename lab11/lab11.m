% LSM for covariance matrix C of noice 

clear all;
close all;

delta_LS = [];
delta_GLS = [];

%N = 100;
NN = [100,500,1000,10000];

for N=NN

    y = [1];
    u = [0];
    real_gamma = [1];
    z = [0];

    a = 0.9;
    b = 1;

    for i=2:N+1
        u(i) = randn();

        z(i) = randn();

        Z = z(i)+z(i-1);

        y(i) = a*y(i-1) + b*u(i) + Z;
        real_gamma(i) = a*real_gamma(i-1) + b*u(i);
    end

    real_gamma = real_gamma(2:end);

    U = u(2:end);
    Y = y;%(2:end);

    %plot(real_gamma);

    phi = [Y(1:N)', U'];
    AB_est = mpower((phi'*phi),-1)*phi'*Y(2:N+1)';


    C = 2*diag(ones(1,N)) + diag(ones(1,N-1),-1) + diag(ones(1,N-1),1);

    C_rev = mpower(C,-1);

    AB_est_GLS = mpower((phi'*C_rev*phi),-1)*phi'*C_rev*Y(2:N+1)';


    delta_LS(end+1) = norm( AB_est -[a;b] );
    delta_GLS(end+1) = norm( AB_est_GLS -[a;b] );

end

