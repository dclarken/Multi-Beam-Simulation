function[]=plot_nandf_cap_allo()
global CS;
%72���� 4ɫ���� 12���ϵ�ʱ϶���� ����ʱ϶���䷽��
%����n�ײĿ�꺯��
B_tot=500;%ÿ���������ܴ���
B_voice=30;%�̶�����ҵ��
N_re_max=6;%����ͬʱ������һ��ʱ϶�Ĳ�����
K=72;%��������Ϊ72
R=12;%���Է������ʱ϶
n=4;%n�ײ���� 
%��������������
Traffic_request_voice_72=rand(1,72); 
        for i=1:72
            CS(i).req_72=10*i;
            %CS(i).req_72_voice=0.5*Traffic_request_voice_72(i);
            CS(i).req_72_voice=0.25*i;%��ʮ��֮һ���������ڻ���ҵ��
        end
%����һ���������ڻ���n�ײ���䷽ʽ ���ڻ���ҵ��
for i=1:72
    cap_n(i)=B_voice*log2(1+CS(i).CI_72cell_4color_12timeslot); 
    cap_f(i)=(B_tot-B_voice)*log2(1+CS(i).CI_72cell_4color_12timeslot);
end
movie=0;
voice=0;
for i=1:72
    movie=movie+40*CS(i).req_72; 
    voice=voice+40*CS(i).req_72_voice;
end
movie
voice
for i=1:72
    sum1=0;
    sum2=0;
    for k=1:72
        sum1=sum1+(log2(1+CS(i).CI_72cell_4color_12timeslot)/log2(1+CS(k).CI_72cell_4color_12timeslot) ).^(n/(n-1));   
    end
    for k=1:72
        sum2=sum2+CS(k).req_72_voice/(B_voice*log2(1+CS(k).CI_72cell_4color_12timeslot)); 
    end
    sum2=sum2-N_re_max;%��ͼ���� �������Сʱ n�ײ�ķ����������������С�Ĳ�����������
    N_T(i)=CS(i).req_72_voice/cap_n(i)-sum2/sum1;%������������ϵͳ����ʱ���������и�ֵ 
    N_T(i)=N_T(i)*R;
    %N_T(i)=round(N_T(i));%ȡ������ round���������룩 ceil������ȡ����
    if (N_T(i)<0) %�������ĸ������0 ������ʵ�������Ľ� n�׳˲�ķ��䷽�����ʺ����������ϵͳ���������
        N_T(i)=0;
    end
    CS(i).ans_n_72=N_T(i);
end
for i=1:72
    %CS(i).ans_n_72_cap=N_T(i)/R*12*B_voice*log2(1+CS(i).CI_72cell_4color_12timeslot);
    CS(i).ans_n_72_cap=N_T(i)/R*12*B_voice*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_n_72_cap=0;
for i=1:72
    sum_n_72_cap=sum_n_72_cap+CS(i).ans_n_72_cap;
end
sum_n_72_cap;
%���ڹ�ƽ�Ժ��� ���˻���ҵ���������������
for i=1:72
    sum3=0;
    for k=1:72
        sum3=sum3+CS(k).req_72/((B_tot-B_voice)*log2(1+CS(k).CI_72cell_4color_12timeslot));
    end
    N_F(i)=CS(i).req_72/cap_f(i)*N_re_max/sum3*R;
    %N_F(i)=round(N_F(i));%ȡ������
    CS(i).ans_f_72=N_F(i);
end
for i=1:72
    %CS(i).ans_f_72_cap=N_F(i)/R*12*(B_tot-B_voice)*log2(1+CS(i).CI_72cell_4color_12timeslot);
    CS(i).ans_f_72_cap=N_F(i)/R*12*(B_tot-B_voice)*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_f_72_cap=0;
for i=1:72
    sum_f_72_cap=sum_f_72_cap+CS(i).ans_f_72_cap;
end
sum_f_72_cap;
for k=1:72 
    z_n(k)=CS(k).ans_n_72_cap;
    z_f(k)=CS(k).ans_f_72_cap;
    z(k)=CS(k).ans_n_72_cap+CS(k).ans_f_72_cap;
    subplot(1,3,1);%50M ����ҵ���������� �������
%     plot(k,z_n(k),'or');
%     title('����ҵ��');
%     plot(k,CS(k).req_72_voice,'or');
%     hold on;
    plot(k,z_n(k),'oblack');
    ylabel('����(/Mbps)');
%     legend('����ҵ������','����ҵ�����');
        legend('����ҵ�����');
    hold on;
    grid on;
    subplot(1,3,2)
%     plot(k,CS(k).req_72,'+g');
%     hold on;
    plot(k,z_f(k),'+black');
    ylabel('����(/Mbps)');
%     legend('��Ƶҵ������','��Ƶҵ�����')��
    legend('��Ƶҵ�����');
    hold on;
    grid on;
    subplot(1,3,3)
    plot(k,z_n(k),'or');
    ylabel('����(/Mbps)');
    hold on;    
    plot(k,z_f(k),'+g');
    hold on;    
    plot(k,z(k),'xb');% ���������������������
    hold on;
    legend('����ҵ�����','��Ƶҵ�����','��ҵ�����');
    %plot(k,10.5*k,'y.');
    grid on;
end