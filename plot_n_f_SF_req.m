function plot_n_f_SF_req()
global CS;
%��ͼ n�ײ�빫ƽ��Ŀ�꺯���������������ӵĺ���ͼ��
Traffic_request_72=10*rand(1,72); 
for k=1:100 %��������������
        for i=1:72
            CS(i).req_72=k*10*Traffic_request_72(i);
        end
    fun_time_allo_72cell_4color_12timeslot;
    z_n(k)=fun_satisfaction_factor('72cell_n');%n�ײ���㷨���������������ϵͳ���������
    z_f(k)=fun_satisfaction_factor('72cell_f');
    %plot(k,z_n(k),'linewidth',8,'color','r');
    %hold on;
    %plot(k,z_f(k),'linewidth',8,'color','b');
    %grid on;
end
x=linspace(1,100);
plot(x,z_n(x),'linewidth',2,'color','r');
hold on;
plot(x,z_f(x),'linewidth',2,'color','b');
grid on;
