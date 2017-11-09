function fun_power_allo_cell_4color()
clear all;
gen_cell_geometry_senario;
global CS;%24
B_tot=2;%下行总带宽为2G
Q=32;%分配的载波个数为32
K=24;%波束个数
B_c=B_tot/Q;%每个载波分配的带宽20.4082M(96)
N=13;%循环迭代次数
clu=6;%18簇波束复用

G=zeros(K,K);%定义K*K阶天线增益矩阵；
A=zeros(K,K);%定义K*K阶信道衰减矩阵，简化函数模型无信道衰落；
%W=ones(Q,K);%功率分配矩阵，W=[W_1,W_2...W_K],W_K的数值表示波束K分配了多少载波，W[i,j]={0,1};
W_num=Q/K*ones(1,K);%该数组表示每个波束分配的载波个数；0<=w[i]<=Q 初始化每个波束都分配了Q个载波；
U=zeros(1,K);%波束信号功率初始化；
I=zeros(1,K);%波束信号干扰初始化；
%初始化载波平均分配；
W=10.*log10(W_num);
v=5*10*log10(0.16);%4色复用波束的同频波束参数设置；
u=0.4;
t=0.7;
%t=1;
[red,wred,blue,wblue,black,wblack,yellow,wyellow]=fun_color_reuse_24(0);%四色复用无跳波束复用方案
%[red,wred,blue,wblue,black,wblack,yellow,wyellow]=fun_color_reuse_24(6);%四色复用6跳波束复用方案
%建立均匀需求模型
Traffic_request=50*rand(1,K);
sum_req=0;
        for i=1:K
            %req(i)=Traffic_request(i);
            req(i)=sin(7*i/180*pi);
            sum_req=sum_req+req(i);
            %req(i)=50*i;
            %req(i)=1000;
        end
sum_req     
%对需求函数做处理,防止个别需求量大的点波束区域分配的载波过多
sum_req=req*ones(1,K)';
req=req+sum_req*K.^(1/3)/K;%1添加需求基数的处理方法

for n=1:N%迭代次数
    G=zeros(K,K);%每次迭代参数初始化
    A=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        %G(j,i)=G(i,j);
        A(i,j)=10*log10(0.4);%波束k对于其他波束位置的天线增益的衰减在衰减矩阵中体现；
        %A(i,j)=10*log10(1);
        %A(j,i)=A(i,j);
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        A(i,j)=10*log10(0.4);
        %A(i,j)=10*log10(1);
    end 
    G(i,i)=CS(i).gain_max;%矩阵对角线上元素为矩阵增益52.7674
    A(i,i)=10*log10(1);%对角线元素作为每个波束的信道衰落参数，对角线上无衰落；
    H(i,:)=A(i,:)+G(i,:);%K*K阶增益矩阵，对数运算；
    U(i)=W(i)+H(i,i);%信号功率
    w=zeros(1,K);%信号同频干扰因子
    for j=1:K/4
        if (i==red(j)) w=wred;
        elseif (i==blue(j)) w=wblue;
        elseif (i==black(j)) w=wblack;
        elseif (i==yellow(j)) w=wyellow;
        end
    end
   %6色复用
%     green=[3,6,15,18];
%     wgreen= [0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0];
%     white=[9,12,21,24];
%     wwhite= [0,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,1,0,0,1];
%     for j=1:K/6
%         if (i==red(j)) w=wred;
%         elseif (i==blue(j)) w=wblue;
%         elseif (i==black(j)) w=wblack;
%         elseif (i==yellow(j)) w=wyellow;
%         elseif (i==green(j)) w=wgreen;
%         elseif (i==white(j)) w=wwhite;
%         end
%     end
    intf=0;
    h(i,:)=w.*(H(i,:)+t*W(i));%在求解信噪比时添加参数t减缓信噪比恶化情况
    for m=1:K
        intf=intf+h(i,m);
    end
    I(i)=u*(intf-(W(i)+H(i,i)))+v;
    CI(i)=U(i)-I(i);%信噪比
    %if (CI(i)>0)
     %   CI(i)=CI(i);
    %else CI(i)=0.0001;
    %end
end
W_num=fun_f_allocation(24,W_num,CI,req);
W=10.*log10(W_num);
end
%计算容量
for i=1:K
    CS(i).ans_power_cap=W_num(i)/Q*B_tot*fun_DVB_S2_spectral_efficiency(1+CI(i));
end
sum_power_cap=0;
for i=1:K
    sum_power_cap=sum_power_cap+CS(i).ans_power_cap;
end
sum_power_cap
%作图
for k=1:24
subplot(2,2,1);
title('req');
plot(k,req(k)-sum_req*K.^(1/3)/K,'ored');
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
axis([0 30 20 30]);
hold on;
plot(0,0);
hold on;
grid on;
subplot(2,2,4);
title('cap');
plot(k,CS(k).ans_power_cap,'ored');
hold on;
end
grid on;

