clc;
clear all;
close all;
imag=sqrt(-1);
element_num=8;%阵元数为8
d_lamda=1/2;%阵元间距d与波长lamda的关系
theta=linspace(-pi/2,pi/2,200);
theta0=0;%来波方向
w=exp(imag*2*pi*d_lamda*sin(theta0)*[0:element_num-1]');
for  j=1:length(theta)
    a=exp(imag*2*pi*d_lamda*sin(theta(j))*[0:element_num-1]');
   p(j)=w'*a;
end
figure;
plot(theta,abs(p)),grid on
xlabel('theta/radian')
ylabel('amplitude')
title('8阵元均匀线阵方向图')
