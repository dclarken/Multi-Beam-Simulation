function[capcity]=fun_cap_PR_SFR(PR,FR)
global CS;%24
B_tot=2;%下行总带宽为2G
K=24;%波束个数
Q=32;%分配的载波个数为32
B_c=B_tot/Q;%每个载波分配的带宽20.4082M(96)
%PR=x;%主载波和辅载波的功率比
%FR=3/5;中心波束的频带宽度比上总带宽
cell_radius_1=250/80;%外层波束半径
cell_radius_2=5/7*250/80;%内层波束半径
power_allcolor_1=10*log10(100);%外层波束功率 子载波
power_allcolor_2=10*log10(PR*100);%内层波束功率 主载波
gen_cell_geometry_senario;
% for i=1:24
%     CS(i).power=power_allcolor_1;
%     CS(i).CI_24cell_allcolor_in=ci_co_polar_in_cell(CS(i).xpos+0.0001,CS(i).ypos+0.0001);
% end
% for i=1:24
%     CS(i).power=power_allcolor_2;
%     CS(i).CI_24cell_allcolor_out=ci_co_polar_in_cell(CS(i).xpos+0.0001,CS(i).ypos+0.0001);
% end
G=zeros(K,K);%定义K*K阶天线增益矩阵；
A=zeros(K,K);%定义K*K阶信道衰减矩阵，简化函数模型无信道衰落；
% W_num_in=Q/(1+PR)*ones(1,K);%该数组表示每个波束分配的载波个数；0<=w[i]<=Q 初始化每个波束都分配了Q个载波；4个载波
% W_num_out=PR*Q/(1+PR)*ones(1,K);
a1=Q./(1+PR);
a2=PR*Q/(1+PR);
W_num_in=a1*ones(1,K);
W_num_out=a2.*ones(1,K);
U=zeros(1,K);%波束信号功率初始化；
I=zeros(1,K);%波束信号干扰初始化；
%初始化载波平均分配；
W_in=10.*log10(W_num_in);
W_out=10.*log10(W_num_out);
v=5*10*log10(0.16);%4色复用波束的同频波束参数设置；
u=0.4;
t=0.7;

[red,wred,blue,wblue,black,wblack,yellow,wyellow]=fun_color_reuse_24(0);%四色复用无跳波束复用方案
    G=zeros(K,K);%每次迭代参数初始化
    A=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        A(i,j)=10*log10(0.4);%波束k对于其他波束位置的天线增益的衰减在衰减矩阵中体现；
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        A(i,j)=10*log10(0.4);
    end 
    G(i,i)=CS(i).gain_max;%矩阵对角线上元素为矩阵增益52.7674
    A(i,i)=10*log10(1);%对角线元素作为每个波束的信道衰落参数，对角线上无衰落；
    H(i,:)=A(i,:)+G(i,:);%K*K阶增益矩阵，对数运算；
    U(i)=W_in(i)+H(i,i);%信号功率
    w=zeros(1,K);%信号同频干扰因子
    for j=1:K/4
        if (i==red(j)) w=wred;
        elseif (i==blue(j)) w=wblue;
        elseif (i==black(j)) w=wblack;
        elseif (i==yellow(j)) w=wyellow;
        end
    end
    intf=0;
    h(i,:)=w.*(H(i,:)+t*W_in(i));%在求解信噪比时添加参数t减缓信噪比恶化情况
    for m=1:K
        intf=intf+h(i,m);
    end
    I(i)=u*(intf-(W_in(i)+H(i,i)))+v;
    CI_in(i)=U(i)-I(i);%信噪比 主
    CI_out(i)= CI_in(i);%信噪比 子 主子信道功率相同的容量分析
end
%capcity
capcity=0;
for i=1:24
   capcity=capcity+W_in(i)/Q*FR*B_tot*fun_DVB_S2_spectral_efficiency(CI_in(i))++W_out(i)/Q*(1-FR)*B_tot*fun_DVB_S2_spectral_efficiency(CI_out(i));
end
capcity;