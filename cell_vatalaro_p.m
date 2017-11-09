%vatalaro 归一化波束方向图函数,单位为功率% 
function[f]= cell_vatalaro_p(x,y)%自变量xy表示的是距离  天线方向图函数模型
global CS;   
y=atan(abs(y)*300/35786)/pi*180; %距离转化为角度%cell site
x=atan(abs(x)*300/35786)/pi*180;
p=2;
q=factorial(p);%阶乘
t=0;
T=-10*log((t-1).^2);
d=0.055;%馈源间距
c=3/200;
u=10.5*pi*d*sin(sqrt(x.^2+y.^2)/180*pi)/c;%0.8 5dB 2.8m天线
%u=35*pi*d*sin(sqrt(x.^2+y.^2)/180*pi)/c;%0.2 3dB 5m天线
j_1=besselj(1,u);
j_p=besselj(p+1,u);
f=(p+1)*(1-T)/((p+1)*(1-T)+T).*(2.*(j_1./u)+2.^(p+1).*q.*(T/(1-T)).*(j_p./u.^(p+1)));
f=abs(f);
f=10*log10(f);