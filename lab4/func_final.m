function y = func_final(a_est,x)
    tmp = 0;
    a_num = 1;
    for a = a_est
        %a
        tmp = tmp + a*func(a_num,x);
        
        %a*func(a_num,x)
        a_num = a_num + 1;
    end
    y = tmp;

