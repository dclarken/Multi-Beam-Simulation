%function fun_power_allo_cell72_4color()
%clear all;
gen_cell_geometry_senario_72;
global CS;%24
B_tot=2;%下行总带宽为2G
Q=96;%分配的载波个数为32
K=72;%波束个数
B_c=B_tot/Q;%每个载波分配的带宽20.4082M(96)
N=12;%循环迭代次数
clu=18;%18簇波束复用
G=zeros(K,K);%定义K*K阶天线增益矩阵；
A=zeros(K,K);%定义K*K阶信道衰减矩阵，简化函数模型无信道衰落；
W_num=Q/K*ones(1,K);%该数组表示每个波束分配的载波个数；0<=w[i]<=Q 初始化每个波束都分配了Q个载波；
U=zeros(1,K);%波束信号功率初始化；
I=zeros(1,K);%波束信号干扰初始化；
req=zeros(1,K);
%初始化载波平均分配；
W=10.*log10(W_num);
%4色复用波束的同频波束参数设置；
v=5*10*log10(0.16);
u=0.4;
t=0.7;
[color,wcolor,w_]=fun_color_reuse_72;%72波束四色复用无跳波束复用方案
%建立需求模型
Traffic_request=50*rand(1,K);
        for i=1:K
            %req(i)=Traffic_request(i);
            req(i)=1*sin(7*i/505*pi);
            %req(i)=50*i;
            %req(i)=1000;
        end
%对需求函数做处理,防止个别需求量大的点波束区域分配的载波过多
sum_req=req*ones(1,K)';
Creq=8;%系数调整需求再分配 数值越大低需求波束分配的容量越低但是高需求波束分配的载波个数可能过多
%req=req+sum_req.*K.^(1/Creq)/K;%添加需求基数的处理方法   %该m文件图像错误未知，之前明明是对的啊，难过
%req=req+0.1;
for n=1:N%迭代次数
    G=zeros(K,K);%每次迭代参数初始化
    A=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
    h=zeros(K,K);
    CI=zeros(1,K);
    H=zeros(K,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xfpos-CS(i).xfpos,CS(j).yfpos-CS(i).yfpos);
        A(i,j)=10*log10(0.4);%波束k对于其他波束位置的天线增益的衰减在衰减矩阵中体现；
        %A(i,j)=10*log10(1);
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xfpos-CS(i).xfpos,CS(j).yfpos-CS(i).yfpos);
        A(i,j)=10*log10(0.4);
        %A(i,j)=10*log10(1);
    end 
    G(i,i)=CS(i).gain_max;%矩阵对角线上元素为矩阵增益52.7674
    A(i,i)=10*log10(1);%对角线元素作为每个波束的信道衰落参数，对角线上无衰落；
    H(i,:)=A(i,:)+G(i,:);%K*K阶增益矩阵，对数运算；
    U(i)=W(i)+H(i,i);%信号功率
    w=zeros(1,K);%信号同频干扰因子
    m=0;
    n=0;
     for n=1:4
         for m=1:18
              if (i==color(n,m))
                 w=w_(i,:).*wcolor(n,:);
              end
         end
     end
    intf=0;
    h(i,:)=w.*(H(i,:)+t*W(i));%在求解信噪比时添加参数t减缓信噪比恶化情况
    for m=1:K
        intf=intf+h(i,m);
    end
    I(i)=u*(intf-(W(i)+H(i,i)))+v;
    CI(i)=U(i)-I(i);%信噪比
    %CI(i)=real(CI(i));
    CI(i)=22;
end
% for i=25:48
%     CI(i)=CI(i-24);
% end
% for i=49:72
%     CI(i)=CI(i-48);
% end
W_num=fun_f_allocation(72,W_num,CI,req);
W=10.*log10(W_num);
%W=real(W);
end
%计算容量
for i=1:K
    CS(i).ans72_power_cap=W_num(i)/Q*B_tot*fun_DVB_S2_spectral_efficiency(1+CI(i));
    ans72_power_cap(i)=CS(i).ans72_power_cap;
end
sum_power_cap=0;
for i=1:K
    sum_power_cap=sum_power_cap+CS(i).ans72_power_cap;
end
sum_power_cap
SF=fun_satisfaction_factor_all(K,req,ans72_power_cap)
%作图
%从图像显示 各个波束的信噪比几乎没有发生改变，实现功率的分配 
for k=1:K
subplot(2,2,1);
title('req');
%plot(k,req(k)-sum_req*K.^(1/Creq)/K,'ored');
plot(k,req(k),'ored');
hold on;
grid on;
subplot(2,2,2);
title('num');
plot(k,W_num(k),'ored');
hold on;
grid on;
subplot(2,2,3);
title('CI');
plot(k,CI(k),'ored');
hold on;
%plot(0,0);
grid on;
subplot(2,2,4);
title('cap');
plot(k,CS(k).ans72_power_cap,'ored');
%plot(0,0);
hold on;
end
grid on;

