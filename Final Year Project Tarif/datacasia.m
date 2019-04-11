function data
 
 c1='.bmp';
fid = fopen('casiadatabase.txt', 'w+');
for i=1:50
    a=num2str(i);
   filename=strcat(a,c1);
    fprintf(fid,'%s\r',filename);
end
fclose(fid);