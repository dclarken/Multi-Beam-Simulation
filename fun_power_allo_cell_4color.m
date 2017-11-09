function fun_power_allo_cell_4color()
clear all;
gen_cell_geometry_senario;
global CS;%24
B_tot=2;%�����ܴ���Ϊ2G
Q=32;%������ز�����Ϊ32
K=24;%��������
B_c=B_tot/Q;%ÿ���ز�����Ĵ���20.4082M(96)
N=13;%ѭ����������
clu=6;%18�ز�������

G=zeros(K,K);%����K*K�������������
A=zeros(K,K);%����K*K���ŵ�˥�����󣬼򻯺���ģ�����ŵ�˥�䣻
%W=ones(Q,K);%���ʷ������W=[W_1,W_2...W_K],W_K����ֵ��ʾ����K�����˶����ز���W[i,j]={0,1};
W_num=Q/K*ones(1,K);%�������ʾÿ������������ز�������0<=w[i]<=Q ��ʼ��ÿ��������������Q���ز���
U=zeros(1,K);%�����źŹ��ʳ�ʼ����
I=zeros(1,K);%�����źŸ��ų�ʼ����
%��ʼ���ز�ƽ�����䣻
W=10.*log10(W_num);
v=5*10*log10(0.16);%4ɫ���ò�����ͬƵ�����������ã�
u=0.4;
t=0.7;
%t=1;
[red,wred,blue,wblue,black,wblack,yellow,wyellow]=fun_color_reuse_24(0);%��ɫ���������������÷���
%[red,wred,blue,wblue,black,wblack,yellow,wyellow]=fun_color_reuse_24(6);%��ɫ����6���������÷���
%������������ģ��
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
%��������������,��ֹ������������ĵ㲨�����������ز�����
sum_req=req*ones(1,K)';
req=req+sum_req*K.^(1/3)/K;%1�����������Ĵ�����

for n=1:N%��������
    G=zeros(K,K);%ÿ�ε���������ʼ��
    A=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        %G(j,i)=G(i,j);
        A(i,j)=10*log10(0.4);%����k������������λ�õ����������˥����˥�����������֣�
        %A(i,j)=10*log10(1);
        %A(j,i)=A(i,j);
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        A(i,j)=10*log10(0.4);
        %A(i,j)=10*log10(1);
    end 
    G(i,i)=CS(i).gain_max;%����Խ�����Ԫ��Ϊ��������52.7674
    A(i,i)=10*log10(1);%�Խ���Ԫ����Ϊÿ���������ŵ�˥��������Խ�������˥�䣻
    H(i,:)=A(i,:)+G(i,:);%K*K��������󣬶������㣻
    U(i)=W(i)+H(i,i);%�źŹ���
    w=zeros(1,K);%�ź�ͬƵ��������
    for j=1:K/4
        if (i==red(j)) w=wred;
        elseif (i==blue(j)) w=wblue;
        elseif (i==black(j)) w=wblack;
        elseif (i==yellow(j)) w=wyellow;
        end
    end
   %6ɫ����
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
    h(i,:)=w.*(H(i,:)+t*W(i));%����������ʱ��Ӳ���t��������ȶ����
    for m=1:K
        intf=intf+h(i,m);
    end
    I(i)=u*(intf-(W(i)+H(i,i)))+v;
    CI(i)=U(i)-I(i);%�����
    %if (CI(i)>0)
     %   CI(i)=CI(i);
    %else CI(i)=0.0001;
    %end
end
W_num=fun_f_allocation(24,W_num,CI,req);
W=10.*log10(W_num);
end
%��������
for i=1:K
    CS(i).ans_power_cap=W_num(i)/Q*B_tot*fun_DVB_S2_spectral_efficiency(1+CI(i));
end
sum_power_cap=0;
for i=1:K
    sum_power_cap=sum_power_cap+CS(i).ans_power_cap;
end
sum_power_cap
%��ͼ
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

