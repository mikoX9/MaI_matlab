% Hammerstein system
clear all;
close all;


miu_f = @(u) abs(u);



N = 100;
uk = [];
yk = [];
w = [0,0];

for n=3:N+2
   
   uk(n) = 2*rand()-1;
   
   wk(n) = miu_f( uk(n) );
   zk = 0;
   yk(n) = 3*wk(n) + 2*wk(n-1) + 1*wk(n-2) + zk;
end

uk = uk(3:end);
wk = wk(3:end);
yk = yk(3:end);

plot(uk,yk , ".")
hold on;
plot(uk,wk , ".")


% estimation of miu (lab5)
grid = -1:0.01:1;
miu_est = [];
u_kernel = [];
h = 0.1;

% we need this only to R(0)
% here not for grid but for u
for u=grid % or grid
    u_kernel = [];
    for i=1:N
        if uk(i) < u+h && uk(i) > u-h
            u_kernel(end+1) = yk(i);
        end      
    end
    miu_est(end+1) = sum(u_kernel)/length(u_kernel);
end


plot(grid,miu_est, ".")




R_zero = miu_est(101);

% generating new wk
miu_est = [];
for u=uk % or grid
    u_kernel = [];
    for i=1:N
        if uk(i) < u+h && uk(i) > u-h
            u_kernel(end+1) = yk(i);
        end      
    end
    miu_est(end+1) = sum(u_kernel)/length(u_kernel);
end



miu_size = size(miu_est);
miu_size = miu_size(2);

miu_est(1)
for i=1:miu_size
    miu_est(i) = miu_est(i)-R_zero;
end

miu_est(1)


plot(uk,miu_est, ".")
legend("yk","wk","miu est", "r-r0");


new_wk = miu_est;



% estomations of gammas

Uk = [0,0,new_wk];
Yk = yk;
phi = [];



Uk = [0,0,new_wk];
phi = [ Uk(3:end)', Uk(2:end-1)', Uk(1:end-2)'];
gamma_est = mpower((phi'*phi),-1)*phi'*Yk';

% 
% phi = [];
% for i=2:N+1 
%     phi = [phi; power(Uk(i+1),2),Uk(i+1), power(Uk(i),2),Uk(i),  power(Uk(i-1),2),Uk(i-1) ];
% end
% THETA_est = mpower((phi'*phi),-1)*phi'*Yk';
% %%%%%%%%% DECOMPOSITION
% M = [ THETA_est(1:2), THETA_est(3:4), THETA_est(5:6)];
% [P,D,Q] = svd(M);
% scale = P(1,1)-P(1,2);
% c_est = P(1,:)/scale;
% gamma_est = D(1,1)*Q(:,1)*scale;
% M_est = c_est' * gamma_est';
% 
% stop




% generate new output
new_gamma = gamma_est;

new_wk = [0,0,new_wk];
new_yk = [];
for n=3:N+2
   new_yk(n) = new_gamma(1)*new_wk(n) + new_gamma(2)*new_wk(n-1) + new_gamma(3)*new_wk(n-2);
end
new_yk = new_yk(3:end);

figure
plot(yk, "-");
hold on;
plot(new_yk, "-");
legend("output", "model output");

