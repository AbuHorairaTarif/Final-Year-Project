function a = integerwavelet(a)

[LL,LH,HL,HH]=integerdwt1(a);
reverseimage=reversedwt(LL,LH,HL,HH);

return;
