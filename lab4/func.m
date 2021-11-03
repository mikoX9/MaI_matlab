function c = func(i,x)

   if i == 1
    c = 1/sqrt(2);
   elseif mod(i,2) == 0
    c = sin(i/2*pi*x);
   else
    c = cos((i-1)/2*pi*x);   
   end 