%����һ�����Բ�ֵ������ΪDVB_S2���������Ƶ�������ʵĺ���
function[n]=fun_DVB_S2_spectral_efficiency(sinr)
x=[5,10,15,20,25,30,35,40,45,50,60,70];
%y=[1.5,2.6,3.3,4.1,4.3,4.4,4.4,4.4,4.4,4.4];
y=[1.5,2.2,3.1,3.5,3.85,3.9,3.9,3.9,3.9,3.9,3.9,3.9];
n=interp1(x,y,sinr,'linear');
%a=linspace(5,50); %������ͼ��
%plot(a,fun_DVB_S2_spectral_efficiency(a));
%grid on;


