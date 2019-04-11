function [LL,LH,HL,HH]=integerdwt1(filterimage1)

% fim1=[11 12 13 14; 1 2 3 4;5 6 7 8;9 10 11 12];


[ r c ] = size(filterimage1);
even=zeros(r,(c/2));
%first level decomposition
%one even dimension
      for j = 1:1:r
        a=2;
        for k =1:1:(c/2)
            even(j,k)=filterimage1(j,a);
            a=a+2;
        end
      end
 %one odd dim
odd=zeros(r,(c/2));
   for j = 1:1:r
        a=1;
        for k =1:1:(c/2)
            odd(j,k)=filterimage1(j,a);
            a=a+2;
        end
    end
[ lenr lenc  ]=size(odd) ;
%one dim haar
     for j = 1:1:lenr
       for k =1:1:lenc
          filterhigh(j,k)=odd(j,k)-even(j,k);
          filterlow(j,k)=even(j,k)+round(filterhigh(j,k)/2);
      end
    end
%2nd dimension
[len2r len2c ]=size(filterlow);
     for j = 1:1:(len2c)
        a=2;
        for k =1:1:(len2r/2)
           %even separation of one dim 
           lleven(k,j)=filterlow(a,j);
           hheven(k,j)=filterhigh(a,j);
            a=a+2;
        end
    end
%odd separtion of one dim 
     for j = 1:1:(len2c)
        a=1;
        for k =1:1:(len2r/2)
           lodd(k,j)=filterlow(a,j);
           hodd(k,j)=filterhigh(a,j);
            a=a+2;
        end
    end
 %2d haar
[ len12r len12c  ]=size(lodd) ;
     for j = 1:1:len12r
        for k =1:1:len12c
           %2nd level hh 
           LH(j,k)=lodd(j,k)-lleven(j,k);
           %2nd level hl
           LL(j,k)=lleven(j,k)+round(LH(j,k)/2);
           %2nd level lh
           HH(j,k)=hodd(j,k)-hheven(j,k);
           %2nd level ll
          HL(j,k)=hheven(j,k)+round(HH(j,k)/2);
        end
     end
    
return;