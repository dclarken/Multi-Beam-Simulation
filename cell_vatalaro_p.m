%vatalaro ��һ����������ͼ����,��λΪ����% 
function[f]= cell_vatalaro_p(x,y)%�Ա���xy��ʾ���Ǿ���  ���߷���ͼ����ģ��
global CS;   
y=atan(abs(y)*300/35786)/pi*180; %����ת��Ϊ�Ƕ�%cell site
x=atan(abs(x)*300/35786)/pi*180;
p=2;
q=factorial(p);%�׳�
t=0;
T=-10*log((t-1).^2);
d=0.055;%��Դ���
c=3/200;
u=10.5*pi*d*sin(sqrt(x.^2+y.^2)/180*pi)/c;%0.8 5dB 2.8m����
%u=35*pi*d*sin(sqrt(x.^2+y.^2)/180*pi)/c;%0.2 3dB 5m����
j_1=besselj(1,u);
j_p=besselj(p+1,u);
f=(p+1)*(1-T)/((p+1)*(1-T)+T).*(2.*(j_1./u)+2.^(p+1).*q.*(T/(1-T)).*(j_p./u.^(p+1)));
f=abs(f);
f=10*log10(f);