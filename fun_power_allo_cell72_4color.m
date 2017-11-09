%function fun_power_allo_cell72_4color()
%clear all;
gen_cell_geometry_senario_72;
global CS;%24
B_tot=2;%�����ܴ���Ϊ2G
Q=96;%������ز�����Ϊ32
K=72;%��������
B_c=B_tot/Q;%ÿ���ز�����Ĵ���20.4082M(96)
N=12;%ѭ����������
clu=18;%18�ز�������
G=zeros(K,K);%����K*K�������������
A=zeros(K,K);%����K*K���ŵ�˥�����󣬼򻯺���ģ�����ŵ�˥�䣻
W_num=Q/K*ones(1,K);%�������ʾÿ������������ز�������0<=w[i]<=Q ��ʼ��ÿ��������������Q���ز���
U=zeros(1,K);%�����źŹ��ʳ�ʼ����
I=zeros(1,K);%�����źŸ��ų�ʼ����
req=zeros(1,K);
%��ʼ���ز�ƽ�����䣻
W=10.*log10(W_num);
%4ɫ���ò�����ͬƵ�����������ã�
v=5*10*log10(0.16);
u=0.4;
t=0.7;
[color,wcolor,w_]=fun_color_reuse_72;%72������ɫ���������������÷���
%��������ģ��
Traffic_request=50*rand(1,K);
        for i=1:K
            %req(i)=Traffic_request(i);
            req(i)=1*sin(7*i/505*pi);
            %req(i)=50*i;
            %req(i)=1000;
        end
%��������������,��ֹ������������ĵ㲨�����������ز�����
sum_req=req*ones(1,K)';
Creq=8;%ϵ�����������ٷ��� ��ֵԽ������������������Խ�͵��Ǹ�������������ز��������ܹ���
%req=req+sum_req.*K.^(1/Creq)/K;%�����������Ĵ�����   %��m�ļ�ͼ�����δ֪��֮ǰ�����ǶԵİ����ѹ�
%req=req+0.1;
for n=1:N%��������
    G=zeros(K,K);%ÿ�ε���������ʼ��
    A=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
    h=zeros(K,K);
    CI=zeros(1,K);
    H=zeros(K,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xfpos-CS(i).xfpos,CS(j).yfpos-CS(i).yfpos);
        A(i,j)=10*log10(0.4);%����k������������λ�õ����������˥����˥�����������֣�
        %A(i,j)=10*log10(1);
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xfpos-CS(i).xfpos,CS(j).yfpos-CS(i).yfpos);
        A(i,j)=10*log10(0.4);
        %A(i,j)=10*log10(1);
    end 
    G(i,i)=CS(i).gain_max;%����Խ�����Ԫ��Ϊ��������52.7674
    A(i,i)=10*log10(1);%�Խ���Ԫ����Ϊÿ���������ŵ�˥��������Խ�������˥�䣻
    H(i,:)=A(i,:)+G(i,:);%K*K��������󣬶������㣻
    U(i)=W(i)+H(i,i);%�źŹ���
    w=zeros(1,K);%�ź�ͬƵ��������
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
    h(i,:)=w.*(H(i,:)+t*W(i));%����������ʱ��Ӳ���t��������ȶ����
    for m=1:K
        intf=intf+h(i,m);
    end
    I(i)=u*(intf-(W(i)+H(i,i)))+v;
    CI(i)=U(i)-I(i);%�����
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
%��������
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
%��ͼ
%��ͼ����ʾ ��������������ȼ���û�з����ı䣬ʵ�ֹ��ʵķ��� 
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

