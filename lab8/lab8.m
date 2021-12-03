% multi-dimentional systems
clear all;
close all;

N = 100;

U = [rand();rand();rand()];

for i=1:N-1
   u1 = rand();
   u2 = rand();
   u3 = rand();
   
   tmp = [u1;u2;u3];
   U = [U,tmp];
   
end

A = [1/2,0,0;
     0,1/4,0;
     0,0,1/8];
B = [1,0,0;
     0,1,0;
     0,0,1];
H = [0,0,1;
     1,0,0;
     0,1,0];
K = mpower( (eye(3) - A*H) ,-1)*B;


Z = rand(3,N)/10-0.05;
Y = K*U + Z;

%X_est = H*Y;


X_est = zeros(3,N);
for i=1:3
X_est(i,:) = H(i,:)*Y;
end



W_1 = [X_est(1,:);U(1,:)];
W = W_1;
AB_est_1 = Y(1,:)*W'*mpower((W*W')l,-1);

W_2 = [X_est(2,:);U(2,:)];
W = W_2;
AB_est_2 = Y(2,:)*W'*mpower((W*W'),-1);

W_3 = [X_est(3,:);U(3,:)];
W = W_3;
AB_est_3 = Y(3,:)*W'*mpower((W*W'),-1);

AB_est_1

