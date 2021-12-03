clear all;
close all;

a=0.8;%true value
b=1;%true value
a_dash=0;
b_dash=0;
yk=0;
vk=0;
P=[10000 0 ; 0 10000];
ak=[0 ; 0];
it=1;

a_history=[];
b_history=[];

lambda=0.995;

loop_counter=1000;

while it<10*loop_counter%abs(a_dash-a)+abs(b_dash-b)>.01
    uk=2*rand()-1;
    x=[yk ; uk];
    yk=yk*a+uk*b;
    zk=10*rand()-5;
    yk=yk+zk;
%    P=P-(P*x*x'*P)/(1+x'*P*x);
    P=(1/(lambda))*(P-(P*x*x'*P)/(lambda+x'*P*x));

    ak=ak+P*x*(yk-x'*ak);
    a_dash=ak(1);
    b_dash=ak(2);
    a_history=[a_history a_dash];
    b_history=[b_history b_dash];
    it=it+1;
end

a=0.3;

while it<20*loop_counter%abs(a_dash-a)+abs(b_dash-b)>.01
    uk=2*rand()-1;
    x=[yk ; uk];
    yk=yk*a+uk*b+10*rand()-5;
    P=(1/(lambda))*(P-(P*x*x'*P)/(lambda+x'*P*x));
    ak=ak+P*x*(yk-x'*ak);
    a_dash=ak(1);
    b_dash=ak(2);
    a_history=[a_history a_dash];
    b_history=[b_history b_dash];
    it=it+1;
end

plot([1:it-1],a_history)
hold on
plot([1:it-1],b_history)
%splot([1:it-1],b_history,'b')
%axis([0 27.5*loop_counter 0.4 1.1])
legend("Estimated value of a","Estimated value of b")
xlabel('Number of iteration');
ylabel('Value of parameter');

ylim([0 2])

