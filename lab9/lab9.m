% static nonlinear block - parametric approach
clear all;
close all;

c1 = 1;
c2 = 1;
f1 = @(u) c1*u;
f2 = @(u) c2*sin(u);
miu_f = @(u) f1(u) + f2(u);



N = 100;
Yk = [];
Uk = [];


for i=1:N
    u = 40*rand()-20;
    z = 2*rand()-1;
    %z = 0;
    %z = rand()/2-0.25;
    Yk(i) = miu_f(u) + z;
    Uk(i) = u;
end

grid = -20:0.01:20;

% real plot
real_y = [];
for u=grid
    real_y(end+1) = miu_f(u);
end
%plot(grid,real_y);
%plot(grid,real_y,'.', 'MarkerSize',2);
%hold on;
%%%%%

%plot(Yk,Uk,'.');
UU = [Uk;Yk];
%plot(UU(1,:),UU(2,:),'.')


Fi = [];
for n=1:N
    tmp_fi = [f1( Uk(n) ), f2( Uk(n) )];
    Fi = [Fi;tmp_fi];
end



C_est = mpower((Fi'*Fi),-1)*Fi'*Yk';




c1 = C_est(1);
c2 = C_est(2);
f1_est = @(u) c1*u;
f2_est = @(u) c2*sin(u);
miu_f_est = @(u) f1_est(u) + f2_est(u);


hold on;
plot(grid,miu_f_est(grid),'b','LineWidth',2);
plot(grid,real_y,'r','LineWidth',2);
plot(Uk,Yk,".",'LineWidth',5);



legend("Estimation of function","Real function", "Samples")



