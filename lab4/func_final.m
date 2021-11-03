function y = func_final(a_est,x)
    tmp = 0;
    a_num = 1;
    for a = a_est
        tmp = tmp + a*func(a_num,x);
        a
        cos sie nie wyswietla sinus
        a*func(a_num,x)
        a_num = a_num + 1;
    end
    y = tmp;

