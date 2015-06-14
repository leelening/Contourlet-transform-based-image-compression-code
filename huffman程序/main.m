I=imread('t.jpg');
data=uint8(I);
[zipped,info]=huffencode(data);
unzipped=huffdecode(zipped,info);
figure,imshow(data);
figure,imshow(unzipped);
erms=compare(data(:),unzipped(:))
cr=info.ratio
whos data unzipped zipped



    
    

