function[]=fun_time_allo_72cell_4color_12timeslot()
global CS;
%72���� 4ɫ���� 12���ϵ�ʱ϶���� ����ʱ϶���䷽��
%����n�ײĿ�꺯��
B_tot=500;%ÿ���������ܴ���
N_re_max=6;%����ͬʱ������һ��ʱ϶�Ĳ����� ����ֵ����n�ײ��ͼ���仯��������������
K=72;%��������Ϊ72
R=32;%���Է������ʱ϶
n=4;%n�ײ����
set_sim_power_allocation('no');%���ʷ��䷽ʽ
get_capcity_72cell_4color_12timeslot;%72���㲨���������
%ȷ����������
%Traffic_request_72=200*rand(1,72); 
        %for i=1:72
          %  CS(i).req_72=Traffic_request_72(i);
        %end
%����n�ײ

%������������
%         for i=1:72
%             %CS(i).req_72=7*i;%ϵ��Ϊ7ʱ���ֺ���С�������������ϵ��Ϊ4�������Сʱ������С����Ҳ��Ӧһ����ϵͳ����
%             CS(i).req_72=4*i;
%         end
%
for i=1:72
    cap(i)=B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot); 
    %cap(i)=B_tot*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
for i=1:72
    sum1=0;
    sum2=0;
    for k=1:72
        sum1=sum1+(log2(1+CS(i).CI_72cell_4color_12timeslot)/log2(1+CS(k).CI_72cell_4color_12timeslot)).^(n/(n-1)); %���ݼ���
    end
    for k=1:72
        sum2=sum2+CS(k).req_72./(B_tot*log2(1+CS(k).CI_72cell_4color_12timeslot)); 
    end
    sum2=sum2-N_re_max;%��ͼ���� �������Сʱ n�ײ�ķ����������������С�Ĳ�����������
    N_T(i)=CS(i).req_72/cap(i)-sum2/sum1;%������������ϵͳ����ʱ���������и�ֵ 
    N_T(i)=N_T(i)*R;
    %N_T(i)=round(N_T(i));%ȡ������ round���������룩 ceil������ȡ����
    if (N_T(i)<0) %�������ĸ������0 ������ʵ�������Ľ� n�׳˲�ķ��䷽�����ʺ����������ϵͳ���������
        N_T(i)=0;
    end
    CS(i).ans_n_72=N_T(i);
end
for i=1:72
    %CS(i).ans_n_72_cap=N_T(i)/R*12*B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot);
    CS(i).ans_n_72_cap=N_T(i)/R*12*B_tot*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_n_72_cap=0;
for i=1:72
    sum_n_72_cap=sum_n_72_cap+CS(i).ans_n_72_cap;
end
sum_n_72_cap;
%���ڹ�ƽ�Ժ���
for i=1:72
    sum3=0;
    for k=1:72
        sum3=sum3+CS(k).req_72/(B_tot*log2(1+CS(k).CI_72cell_4color_12timeslot));
    end
    N_F(i)=CS(i).req_72/cap(i)*N_re_max/sum3*R;
    %N_F(i)=round(N_F(i));%ȡ������
    CS(i).ans_f_72=N_F(i);
end
for i=1:72
    %CS(i).ans_f_72_cap=N_F(i)/R*12*B_tot*log2(1+CS(i).CI_72cell_4color_12timeslot);%RΪʱ϶���� ��12������֮���ֻ� 12*B_tot
    CS(i).ans_f_72_cap=N_F(i)/R*12*B_tot*fun_DVB_S2_spectral_efficiency(1+CS(i).CI_72cell_4color_12timeslot);
end
sum_f_72_cap=0;
for i=1:72
    sum_f_72_cap=sum_f_72_cap+CS(i).ans_f_72_cap;
end
sum_f_72_cap;