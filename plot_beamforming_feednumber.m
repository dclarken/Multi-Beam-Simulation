clc;
clear all;
close all;
imag=sqrt(-1);
element_num=8;%��Ԫ��Ϊ8
d_lamda=1/2;%��Ԫ���d�벨��lamda�Ĺ�ϵ
theta=linspace(-pi/2,pi/2,200);
theta0=0;%��������
w=exp(imag*2*pi*d_lamda*sin(theta0)*[0:element_num-1]');
for  j=1:length(theta)
    a=exp(imag*2*pi*d_lamda*sin(theta(j))*[0:element_num-1]');
   p(j)=w'*a;
end
figure;
plot(theta,abs(p)),grid on
xlabel('theta/radian')
ylabel('amplitude')
title('8��Ԫ����������ͼ')
