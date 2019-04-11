function data
 
 c1='.bmp';
fid = fopen('database.txt', 'w+');
for i=1001:1030
    a=num2str(i);
   filename=strcat(a,c1);
    fprintf(fid,'%s\r',filename);
end
fclose(fid);