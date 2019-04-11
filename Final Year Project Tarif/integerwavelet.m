function [a] = integerwavelet(a)

[LL,LH,HL,HH]=integerdwt1(a);
% figure;
% imshow(LL,[])
% figure;
% imshow(LH,[])
% figure;
% imshow(HL,[])
% figure;
% imshow(HH,[])
a=reversedwt(LL,LH,HL,HH);

%return;
