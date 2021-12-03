% least squared estimation
clear all;
close all;


N = 100;
a = 0.9;
b = 1;
U = [];
V = [];
V(end+1) = 0; % initial condition
Y = [];
Y(end+1) = 0; 
deltas_1 = [];
deltas_2 = [];

N = [10,100,500,1000,5000,10000,50000,100000,500000,1000000];
for n=N
    for i=1:n
        U(i) = 2*rand()-1;
        V(i+1) = a*V(i) + b*U(i);    
        zk = rand()-0.5;
        Y(i+1) = V(i+1) + zk; 
    end

    phi = [Y(1:n)', U'];
    AB_est_1 = mpower((phi'*phi),-1)*phi'*Y(2:n+1)';
    deltas_1(end+1) = norm( AB_est_1-[a;b] );
    
    psi = [[0,U(1:n-1)]', U'];
    AB_est_2 = mpower((psi'*phi),-1)*psi'*Y(2:n+1)';
    
    deltas_2(end+1) = norm( AB_est_2 -[a;b] );
    
    
    
end

deltas_1
deltas_2


semilogx(N,deltas_1,'*-','LineWidth',2)
hold on;
semilogx(N,deltas_2,'*-','LineWidth',2)
xlabel('Numbers of data');
ylabel('Error');
legend('Least Square','Instrumental Variable');
