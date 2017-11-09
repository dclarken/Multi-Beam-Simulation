function[]=plot_power_allo_vscellnum()
global CS;
cell_radius=250/80;
long=cell_radius^(1/3);
B_tot=2;%�����ܴ���Ϊ2G
Q=96;%������ز�����Ϊ32
% k=5;%��������
% K=k^2;
B_c=B_tot/Q;%ÿ���ز�����Ĵ���20.4082M(96)
N=5;%ѭ����������
%G=zeros(K,K);%����K*K�������������
%A=zeros(K,K);%����K*K���ŵ�˥�����󣬼򻯺���ģ�����ŵ�˥�䣻
%W_num=Q/K*ones(1,K);%�������ʾÿ������������ز�������0<=w[i]<=Q ��ʼ��ÿ��������������Q���ز���
%U=zeros(1,K);%�����źŹ��ʳ�ʼ����
%I=zeros(1,K);%�����źŸ��ų�ʼ����
%��ʼ���ز�ƽ�����䣻
%W=10.*log10(W_num);
%4ɫ���ò�����ͬƵ�����������ã�
v=5*10*log10(0.16);
u=0.4;
t=0.7;
for k=1:1:15
K=k*k;
W_num=Q/K*ones(1,K);
W=10.*log10(W_num);
%��������ģ��
Traffic_request=50*rand(1,K);
req=zeros(1,K);
        for i=1:K
            %req(i)=Traffic_request(i);
            req(i)=0.5*sin(7*i/505*pi);
            %req(i)=50*i;
            %req(i)=1000;
        end
%��������������,��ֹ������������ĵ㲨�����������ز�����
sum_req=req*ones(1,K)';
Creq=8;%ϵ�����������ٷ��� ��ֵԽ������������������Խ�͵��Ǹ�������������ز��������ܹ���
req=req+sum_req*K.^(1/Creq)/K;%�����������Ĵ�����
%����ģ��
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
for n=1:N%��������
    G=zeros(K,K);%ÿ�ε���������ʼ��
    A=zeros(K,K);
    H=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
    CI=zeros(1,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(xpos(i)-xpos(j),ypos(i)-ypos(j));
        A(i,j)=10*log10(0.4);%����k������������λ�õ����������˥����˥�����������֣�
        %A(i,j)=10*log10(1);
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(xpos(i)-xpos(j),ypos(i)-ypos(j));
        A(i,j)=10*log10(0.4);
        %A(i,j)=10*log10(1);
    end 
    G(i,i)=1;%����Խ�����Ԫ��Ϊ��������52.7674
    A(i,i)=10*log10(1);%�Խ���Ԫ����Ϊÿ���������ŵ�˥��������Խ�������˥�䣻
    H(i,:)=A(i,:)+G(i,:);%K*K��������󣬶������㣻
    U(i)=W(i)+H(i,i);%�źŹ���
    %h(i,:)=w.*(H(i,:)+t*W(i));%����������ʱ��Ӳ���t��������ȶ����
    I(i)=u*(4*(cell_vatalaro_p(2*long,0)+W(i)))+0.5*v;
    CI(i)=U(i)-I(i);%�����
    CI(i)=real(CI(i));
end
W_num=fun_f_allocation(K,W_num,CI,req);
W=10.*log10(W_num);
W=real(W);
end
%��������
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
xlabel('��������'),ylabel('ϵͳ����');
legend('DVB-S2','Shannon');
hold on;
grid on;
%subplot(1,2,2);
%plot(K,SF,'linewidth',2,'color','r','marker','o');
hold on;
grid on;
end
