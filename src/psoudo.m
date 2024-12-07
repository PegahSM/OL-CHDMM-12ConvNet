function  [rgb ] = psoudo(x)

%x=double(a(:,:,1));
f=(0.75*x)+0.25;
cons1=(-0.5*pi)+0.2;
phi1=(-x+cons1)*pi+0.5;
s1=sin(phi1);
s1=s1.*s1;

blue=s1.*f;
blue=normalize(blue);
%imshow(blue);
cons2=0.2-(0.5*pi)-3/14;
phi2=(-x+cons2)*pi+0.5;
s2=sin(phi2);
s2=s2.*s2;
green=s2.*f;
green= normalize(green);
%figure,imshow(green);
cons3=0.5-(0.5*pi)-6/14;
phi3=(-x+cons3)*pi+0.5;
s3=sin(phi3);
s3=s3.*s3;
red=s3.*f;
red=normalize(red);
%figure,imshow(red);
rgb=zeros(114,114,3);
rgb(:,:,1)=blue;
rgb(:,:,2)=green;
rgb(:,:,3)=red;
%imwrite(a,rgb);
%imshow (rgb);