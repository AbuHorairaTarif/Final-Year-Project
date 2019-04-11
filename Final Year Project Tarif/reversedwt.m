function reverseimage=reversedwt(a_lowpass_coeff,horizontal,vertical,diagonal)
filter2llow=a_lowpass_coeff;
filter2lhigh=horizontal;
filter2hlow=vertical;
filter2hhigh=diagonal;
% [filter2llow,filter2lhigh,filter2hlow,filter2hhigh]=split(image);
[ rlen2r rlen2c  ]=size(filter2llow);

len12r=rlen2r;
len12c=rlen2c;

    for j = 1:1:len12r
        for k =1:1:len12c
           reversefilter2ll(j,k)=filter2llow(j,k)-round(filter2lhigh(j,k)/2);
           reversefilter2lh(j,k)=reversefilter2ll(j,k)+filter2lhigh(j,k);
           reversefilter2hl(j,k)=filter2hlow(j,k)-round(filter2hhigh(j,k)/2);
           reversefilter2hh(j,k)=filter2hhigh(j,k)+reversefilter2hl(j,k);
        end
   end
   
   
   
%1d reconstruction
[ rlen1r rlen1c  ]=size(reversefilter2ll);
rlen2r=rlen2r+rlen2r;
 %even separation
   k=1;
   for j= 2:2:rlen2r
      rl(j,:)=reversefilter2ll(k,:);
      rh(j,:)=reversefilter2hl(k,:);
      k=k+1;
   end
   %end
 %odd separation
   k=1;
   for j= 1:2:rlen2r
      rl(j,:)=reversefilter2lh(k,:);
      rh(j,:)=reversefilter2hh(k,:);
      k=k+1;
   end
[ rlenr rlenc  ]=size(rl);
%1d 
   for j= 1:1:rlenr
      for k = 1:1:rlenc
         r(j,k)=rl(j,k)-round(rh(j,k)/2);
         horizontal(j,k)=r(j,k)+rh(j,k);
      end
   end
%1d interpolation
[ rlr rlc ]=size(r);
rlc=rlc+rlc;
   for j = 1:1:rlr
        a_lowpass_coeff=1;
      for k=2:2:rlc
         reverseimage(j,k)=r(j,a_lowpass_coeff);
         a_lowpass_coeff=a_lowpass_coeff+1;
      end
   end
   for j = 1:1:rlr
        a_lowpass_coeff=1;
      for k=1:2:rlc
         reverseimage(j,k)=horizontal(j,a_lowpass_coeff);
         a_lowpass_coeff=a_lowpass_coeff+1;     
      end
   end
return

function [a,b,c,d]=split(x)
[imax,jmax]=size(x);
a=x(1:fix(imax/2),1:fix(jmax/2)); %fix round towards zero like floor a value
b=x(1+fix(imax/2):imax,1:fix(jmax/2));
c=x(1:fix(imax/2),1+fix(jmax/2):jmax);
d=x(1+fix(imax/2):imax,1+fix(jmax/2):jmax);
return;