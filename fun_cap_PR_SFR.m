function[capcity]=fun_cap_PR_SFR(PR,FR)
global CS;%24
B_tot=2;%�����ܴ���Ϊ2G
K=24;%��������
Q=32;%������ز�����Ϊ32
B_c=B_tot/Q;%ÿ���ز�����Ĵ���20.4082M(96)
%PR=x;%���ز��͸��ز��Ĺ��ʱ�
%FR=3/5;���Ĳ�����Ƶ����ȱ����ܴ���
cell_radius_1=250/80;%��㲨���뾶
cell_radius_2=5/7*250/80;%�ڲ㲨���뾶
power_allcolor_1=10*log10(100);%��㲨������ ���ز�
power_allcolor_2=10*log10(PR*100);%�ڲ㲨������ ���ز�
gen_cell_geometry_senario;
% for i=1:24
%     CS(i).power=power_allcolor_1;
%     CS(i).CI_24cell_allcolor_in=ci_co_polar_in_cell(CS(i).xpos+0.0001,CS(i).ypos+0.0001);
% end
% for i=1:24
%     CS(i).power=power_allcolor_2;
%     CS(i).CI_24cell_allcolor_out=ci_co_polar_in_cell(CS(i).xpos+0.0001,CS(i).ypos+0.0001);
% end
G=zeros(K,K);%����K*K�������������
A=zeros(K,K);%����K*K���ŵ�˥�����󣬼򻯺���ģ�����ŵ�˥�䣻
% W_num_in=Q/(1+PR)*ones(1,K);%�������ʾÿ������������ز�������0<=w[i]<=Q ��ʼ��ÿ��������������Q���ز���4���ز�
% W_num_out=PR*Q/(1+PR)*ones(1,K);
a1=Q./(1+PR);
a2=PR*Q/(1+PR);
W_num_in=a1*ones(1,K);
W_num_out=a2.*ones(1,K);
U=zeros(1,K);%�����źŹ��ʳ�ʼ����
I=zeros(1,K);%�����źŸ��ų�ʼ����
%��ʼ���ز�ƽ�����䣻
W_in=10.*log10(W_num_in);
W_out=10.*log10(W_num_out);
v=5*10*log10(0.16);%4ɫ���ò�����ͬƵ�����������ã�
u=0.4;
t=0.7;

[red,wred,blue,wblue,black,wblack,yellow,wyellow]=fun_color_reuse_24(0);%��ɫ���������������÷���
    G=zeros(K,K);%ÿ�ε���������ʼ��
    A=zeros(K,K);
    U=zeros(1,K);
    I=zeros(1,K);
for i=1:K
    for j=i+1:K
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        A(i,j)=10*log10(0.4);%����k������������λ�õ����������˥����˥�����������֣�
    end
    for j=1:i-1
        G(i,j)=52.7674+cell_vatalaro_p(CS(j).xpos-CS(i).xpos,CS(j).ypos-CS(i).ypos);
        A(i,j)=10*log10(0.4);
    end 
    G(i,i)=CS(i).gain_max;%����Խ�����Ԫ��Ϊ��������52.7674
    A(i,i)=10*log10(1);%�Խ���Ԫ����Ϊÿ���������ŵ�˥��������Խ�������˥�䣻
    H(i,:)=A(i,:)+G(i,:);%K*K��������󣬶������㣻
    U(i)=W_in(i)+H(i,i);%�źŹ���
    w=zeros(1,K);%�ź�ͬƵ��������
    for j=1:K/4
        if (i==red(j)) w=wred;
        elseif (i==blue(j)) w=wblue;
        elseif (i==black(j)) w=wblack;
        elseif (i==yellow(j)) w=wyellow;
        end
    end
    intf=0;
    h(i,:)=w.*(H(i,:)+t*W_in(i));%����������ʱ��Ӳ���t��������ȶ����
    for m=1:K
        intf=intf+h(i,m);
    end
    I(i)=u*(intf-(W_in(i)+H(i,i)))+v;
    CI_in(i)=U(i)-I(i);%����� ��
    CI_out(i)= CI_in(i);%����� �� �����ŵ�������ͬ����������
end
%capcity
capcity=0;
for i=1:24
   capcity=capcity+W_in(i)/Q*FR*B_tot*fun_DVB_S2_spectral_efficiency(CI_in(i))++W_out(i)/Q*(1-FR)*B_tot*fun_DVB_S2_spectral_efficiency(CI_out(i));
end
capcity;