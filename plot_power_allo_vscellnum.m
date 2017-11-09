function[]=plot_power_allo_vscellnum()
global CS;
cell_radius=250/80;
long=cell_radius^(1/3);
B_tot=2;%下行总带宽为2G
Q=96;%分配的载波个数为32
% k=5;%波束个数
% K=k^2;
B_c=B_tot/Q;%每个载波分配的带宽20.4082M(96)
N=5;%循环迭代次数
%G=zeros(K,K);%定义K*K阶天线增益矩阵；
%A=zeros(K,K);%定义K*K阶信道衰减矩阵，简化函数模型无信道衰落；
%W_num=Q/K*ones(1,K);%该数组表示每个波束分配的载波个数；0<=w[i]<=Q 初始化每个波束都分配了Q个载波；
%U=zeros(1,K);%波束信号功率初始化；
%I=zeros(1,K);%波束信号干扰初始化；
%初始化载波平均分配；
%W=10.*log10(W_num);
%4色复用波束的同频波束参数设置；
v=5*10*log10(0.16);
u=0.4;
t=0.7;
for k=1:1:15
K=k*k;
W_num=Q/K*ones(1,K);
W=10.*log10(W_num);
%建立需求模型
Traffic_request=50*rand(1,K);
req=zeros(1,K);
        for i=1:K
            %req(i)=Traffic_request(i);
            req(i)=0.5*sin(7*i/505*pi);
            %req(i)=50*i;
            %req(i)=1000;
        end
%对需求函数做处理,防止个别需求量大的点波束区域分配的载波过多
sum_req=req*ones(1,K)';
Creq=8;%系数调整需求再分配 数值越大低需求波束分配的容量越低但是高需求波束分配的载波个数可能过多
req=req+sum_req*K.^(1/Creq)/K;%添加需求基数的处理方法
%场景模型
xmin=93.4274;
ymin=29.1182;
% xmin=106.95;
% ymin=33.80;
for i=1:k
       posx(i)=xmin+i*long;
       posy(i)=ymin+i*long;
end
for i=1:k
    for j=1:k
        xpos((i-1)*k+j)=posx(j);
        ypos((i-1)*k+j)=posy(i);
    end
end
for n=1:N%迭代次数
    G=zeros(K,K);%每次迭代参数初始化
    A=zeros(K,K);
    H=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
    CI=zeros(1,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(xpos(i)-xpos(j),ypos(i)-ypos(j));
        A(i,j)=10*log10(0.4);%波束k对于其他波束位置的天线增益的衰减在衰减矩阵中体现；
        %A(i,j)=10*log10(1);
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(xpos(i)-xpos(j),ypos(i)-ypos(j));
        A(i,j)=10*log10(0.4);
        %A(i,j)=10*log10(1);
    end 
    G(i,i)=1;%矩阵对角线上元素为矩阵增益52.7674
    A(i,i)=10*log10(1);%对角线元素作为每个波束的信道衰落参数，对角线上无衰落；
    H(i,:)=A(i,:)+G(i,:);%K*K阶增益矩阵，对数运算；
    U(i)=W(i)+H(i,i);%信号功率
    %h(i,:)=w.*(H(i,:)+t*W(i));%在求解信噪比时添加参数t减缓信噪比恶化情况
    I(i)=u*(4*(cell_vatalaro_p(2*long,0)+W(i)))+0.5*v;
    CI(i)=U(i)-I(i);%信噪比
    CI(i)=real(CI(i));
end
W_num=fun_f_allocation(K,W_num,CI,req);
W=10.*log10(W_num);
W=real(W);
end
%计算容量
ans72_power_cap_DVB=zeros(1,K);
ans72_power_cap_S=zeros(1,K);
ans72_power_cap_DVB=1/Q*B_tot*W_num.*fun_DVB_S2_spectral_efficiency(1+CI);
ans72_power_cap_S=1/Q*B_tot*W_num.*log2(1+CI);
sum_power_cap=0;
sum_power_DVB=ans72_power_cap_DVB*ones(1,K)'/1.9;
sum_power_S=ans72_power_cap_S*ones(1,K)'/1.9;
%SF=fun_satisfaction_factor_all(K,req,ans72_power_cap_DVB);
%subplot(1,2,1);
plot(K,sum_power_DVB,'linewidth',2,'color','r','marker','o');
hold on;
plot(K,sum_power_S,'linewidth',2,'color','b','marker','+');
hold on
xlabel('波束个数'),ylabel('系统容量');
legend('DVB-S2','Shannon');
hold on;
grid on;
%subplot(1,2,2);
%plot(K,SF,'linewidth',2,'color','r','marker','o');
hold on;
grid on;
end
